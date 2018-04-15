# Functions that deal with user authorization for using
# the Lufthansa API


# Store user credentials/key in a new environment for each session.
credEnv <- new.env()



#' Get token information from environment
#'
#' @description This serves as a helper function to retrieve
#' token information from the package environment.
#'
#' @return a named list with components \code{token} and \code{expiry}
#' @family token handling functions
#' @export
get_creds_from_env <- function(){
  creds <- tryCatch( get("creds", envir=credEnv),
                     error=function(x) NULL )
  return(creds)
}

#' Interprets the cache option
#'
#' @description To control the way token is stored between sessions, the package
#' uses looks for the option \code{lufthansar_token_cache} which can be set using
#' \code{options(lufthansar_token_cache=...)}. The options can include
#' \describe{
#' \item{\code{TRUE}}{to store the cache in the file \code{.lufthansa-token} in the
#' current working directory.}
#' \item{\code{FALSE}}{to suppress storing the token. Without a cached file, the
#' token will not be remembered between R sessions.}
#' \item{\code{character}}{to indicate the file where the cache will be stored. This
#' is used to both look for the file and store it in.}
#' }
#' This function finds the option and interprets it for use by other functions.
cache_option <- function(){
  cache=getOption("lufthansar_token_cache", default = TRUE)
  try(
    if(cache){ cache <- ".lufthansa-token" }
      else{ cache <- NULL },
    silent=TRUE
  )
  return(cache)
}


#' Retrieves token information from cache file
#' @family token handling functions
get_creds_from_cache <- function(){
  cache <- cache_option()
  creds <- tryCatch( expr=readRDS(cache),
                     error=function(x) NULL,
                     warning=function(x) NULL )
  return(creds)
}


#' Generate a new token from Lufthansa.
#'
#' @description A token is obtained in the last step of the OAuth2.0 authentication
#' process whereby a client ID and secret are exchanged with the authorizing server.
#' This function helps perform this last step of the exchange. LufthansaR API tokens
#' expire after a while so the expiry time is also stored.
#'
#' To avoid having to type your id and secret into the terminal which might be
#' saved into a history file, it is recommended that these be stored in a \code{.Renviron}
#' file which is loaded by R before the start of every session. By default, this
#' function looks for the following string variables in the system environment:
#' \describe{
#' \item{\code{LUFTHANSA_API_CLIENT_ID}}{a string}
#' \item{\code{LUFTHANSA_API_CLIENT_SECRET}}{a string}
#' }
#'
#' @param client_id The client ID used to register for using the API.
#' @param client_secret The secret provided during registration.
#' @return the token information as a list with components \code{token} and \code{expiry}.
#' @family token handling functions
#' @export
get_creds_from_server <- function(client_id=Sys.getenv("LUFTHANSA_API_CLIENT_ID"),
                      client_secret=Sys.getenv("LUFTHANSA_API_CLIENT_SECRET")){

  # check client_id length. should be length = 1.
  if (length(client_id) != 1) {
    stop("Problem with the input : ", client_id, "-- Input should be in one string. ie. 'agkeoiwertkk'")
  }

  # check client_id class. should be class = characeter.
  if (class(client_id) != "character") {
    stop("Problem with the input : ", client_id, "-- Input class should be 'character'. ie. 'agkeoiwertkk'")
  }

  # check client_secret length. should be length = 1.
  if (length(client_secret) != 1) {
    stop("Problem with the input : ", client_secret, "-- Input should be in one string. ie. 'agkeoiwertkk'")
  }

  # check client_id class. should be class = characeter.
  if (class(client_secret) != "character") {
    stop("Problem with the input : ", client_secret, "-- Input class should be 'character'. ie. 'agkeoiwertkk'")
  }

  # Ask for token
  response <- httr::POST(url = "https://api.lufthansa.com/v1/oauth/token",
                         body=list(client_id = client_id,
                                   client_secret = client_secret,
                                   grant_type ="client_credentials"),
                         encode = "form")

  # check response status. a good response should have status code = 200.
  if (response$status_code != 200) {
    stop("Problem with calling the API - response: ", httr::content(response))
  }

  # Parses the response
  response <- httr::content(response, "parsed")

  token <- response$access_token
  expires_in <- response$expires_in

  # Check if there is no token
  if (is.null(token)) {
    stop("No token returned. Check credentials.")
  }

  # Set the token and show how long it lasts
  expiry = lubridate::now() + lubridate::dseconds(expires_in)

  # Credentials are the token and expire datetime
  creds <- list(token=token, expiry=expiry)
  return(creds)
}



#' Saves the user's token in the environment
#'
#' @description The user's token is saved in an environment inside the package for use by the package.
#' Package forgets the token at the end of the session.
#' @param creds a list generated by a \code{get_creds_from_} function
#' @family token handling functions
#' @export
add_creds_to_env <- function(creds=NULL){
  assign("creds", creds, envir=credEnv)
}

#' Store credentials in a cache file
#'
#' @description When a valid token is available, it is stored in a cache file
#' for retrieval between R sessions. Care must be taken to ensure this file is
#' kept confidential. For example, by adding it to a `.gitignore` file.
#' @param creds a list generated by a \code{get_creds_from_} function
#' @family token handling functions
#' @export
add_creds_to_cache <- function(creds=NULL){
  # If caching is true, make default cache location
  cache <- cache_option()
  try( expr=saveRDS(creds, cache),
       silent=TRUE )
}


#' Gets the internal token
#'
#' @description When configured properly, the package keeps a memory of
#' the token and its expiry date and time for wrapper functions to use and to
#' prevent requesting new tokens too frequently. The \code{get_token} function
#' first searches the package environment for a token then proceeds to search for a
#' cached token file. If a token cannot be found in either of these places,
#' a new token is requested from the Lufthansa API using the user's credentials.
#'
#' The token in the package environment only lasts during an R session. To use the same
#' token between R sessions, the token and its expiry can be cached using the option
#' \code{options(lufthansar_token_cache = TRUE)}. The cached token is stored in a file
#' called `.lufthansa-token` in the current working directory. Care must be taken
#' to prevent the file from making the file public. For example, by adding it to a
#' `.gitignore` file.
#'
#' @return The token as a string
#' @export
get_token <- function(){

  # Search the package environment first for token
  creds <- get_creds_from_env()
  token <- creds$token

  # Search a file for token
  if( is.null(token) ){
    creds <- get_creds_from_cache()
    token <- creds$token
  }

  # Checks if a token is valid
  expiry <- creds$expiry
  if( !lubridate::is.timepoint(expiry) ){
    token <- NULL
  } else if ( !( lubridate::now() < expiry ) ){
    token <- NULL
  }

  # Generate a new token if valid token does not exist
  if(is.null(token)){
    creds <- get_creds_from_server()
    token <- creds$token
  }

  # Update all credentials
  add_creds_to_env(creds)
  add_creds_to_cache(creds)

  return(token)
}



