# Functions that deal with user authorization for using
# the Lufthansa API


# Store user credentials/key in a new environment for each session.
credEnv <- new.env()

# By default, store token in a cache file unless overwritten by user
options(lufthansar_token_cache = TRUE)


#' Token in the package environment
#'
#' @return The token as a string
#' @family token handling functions
get_creds_from_env <- function(){
  creds <- tryCatch( get("creds", envir=credEnv),
                     error=function(x) NULL )
  return(creds)
}

#' Caching the token
#'
#' @description Stores and retrives tokens from a cached file.
#' @param cache A list a \code{token} and \code{expiry} component. The \code{token} is
#' a string provided by Lufthansa for using the API. The \code{expiry} is a \code{}
#' @name caching
NULL


#' @describeIn caching Interpreting the cache setting
interpret_cache <- function(cache){
  try(
    if(cache){ cache <- ".lufthansa-token" }
      else{ cache <- NULL },
    silent=TRUE
  )
  return(cache)
}


#' @describeIn caching Retrieves previously stored token information from the cache file
get_creds_from_cache <- function(cache=getOption("lufthansar_token_cache")){
  cache <- interpret_cache(cache)
  creds <- tryCatch( expr=readRDS(cache),
                     error=function(x) NULL,
                     warning=function(x) NULL )
  return(creds)
}


#' Generate a new token from Lufthansa.
#'
#' @param client_id The client ID used to register for using the API.
#' @param client_secret The secret provided during registration.
#' @return the token as a string
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



#' @describeIn get_creds_from_env Saves the user's token in the environment
#'
#' The user's token is saved in an environment inside the package for use by the package.
#' Package forgets the token at the end of the session.
#' @param token The response token
#' @family token handling functions
add_creds_to_env <- function(creds=NULL){
  assign("creds", creds, envir=credEnv)
}


#' @describeIn caching Saves token information to a cache file for later retrieval
add_creds_to_cache <- function(creds=NULL, cache=getOption("lufthansar_token_cache")){
  # If caching is true, make default cache location
  cache <- interpret_cache(cache)
  try( expr=saveRDS(creds, cache),
       silent=TRUE )
}


#' Get the current token being used by the package
#'
#' @return The token as a string
#' @family token handling functions
#' @export
get_token <- function(cache=getOption("lufthansar_token_cache")){

  # Search the package environment first for token
  creds <- get_creds_from_env()
  token <- creds$token

  # Search a file for token
  if( is.null(token) ){
    creds <- get_creds_from_cache(cache)
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
  add_creds_to_cache(creds, cache)

  return(token)
}



