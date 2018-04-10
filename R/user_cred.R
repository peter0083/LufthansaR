# Functions that deal with user authorization for using
# the Lufthansa API


# Store user credentials/key in a new environment for each session.
##credEnv <- new.env()


#' Generate a new token from Lufthansa.
#'
#' @param client_id The client ID used to register for using the API.
#' @param client_secret The secret provided during registration.
#' @return the token as a string
#' @family token handling functions
#' @export
new_token <- function(client_id, client_secret){


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
    stop("Problem with calling the API - response: ", content(response))
  }

  response <- httr::content(response, "parsed")


  # Parse token details
  token <- response$access_token
  expire_time <- response$expires_in

  # Check if there is no token
  if (is.null(token)) {
    stop("No token returned. Check credentials.")
  }

  # Set the token and show how long it lasts
  print(paste("Token expires in: ", expire_time/60/60, "hours"))
  ##set_token(token)
  saveRDS(token, "token_file.rds")
  saveRDS(token, "tests/testthat/token_file.rds")
}


#' Sets the user's token.
#'
#' The user's token is saved in an environment inside the package for use by the package.
#' Package forgets the token at the end of the session.
#' @param token The token as a string
#' @family token handling functions
#' @export
set_token <- function(token = NULL){
  assign("token", token, envir=credEnv)
}


#' Get the current token being used by the package
#'
#' @return The token as a string
#' @family token handling functions
#' @export
get_token <- function(){
  token <- readRDS("token_file.rds")
  return(token)
  ##return( get("token", envir=credEnv) )
}


