# Examples of interaction with the API

#' Format of the authorization part for obtaining content
#' @return authorization string to be sent with a GET requeset
Authorization <- function(){
  token <- get_token()
  return( paste("Bearer", token) )
}

#' Airport Reference Content.
#'
#' @param abbr The airport abbreviation. Default is 'YVR', the Vancouver Airport
#' @return httr content object
#' @export
airport <- function(abbr = "YVR"){

  # check input length. should be length = 1.
  if (length(abbr) != 1) {
    stop("Problem with the API input : ", abbr, "-- Input should be in one string. ie. 'YVR'")
  }

  # check input class. should be class = characeter.
  if (class(abbr) != "character") {
    stop("Problem with the API input : ", abbr, "-- Input class should be 'character'. ie. 'YVR'")
  }

  url_airport_api <- "https://api.lufthansa.com/v1/references/airports/"
  url_airport_api_airport <- paste0(url_airport_api, abbr)

  # Getting the content from the Airport Resources API
  received_content <- httr::GET(url = url_airport_api_airport,
                                config = httr::add_headers(Authorization = Authorization()))

  if (received_content$status_code != 200) {
    stop("Problem with calling the API - response: ", content(received_content))
  }

  airport_content <- httr::content(received_content, "parsed")
  return(airport_content)
}


