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

  url_airport_api <- "https://api.lufthansa.com/v1/references/airports/"
  url_airport_api_airport <- paste0(url_airport_api, abbr)

  # Getting the content from the Airport Resources API
  received_content <- httr::GET(url = url_airport_api_airport,
                                config = httr::add_headers(Authorization = Authorization()))

  airport_content <- httr::content(received_content, "parsed")
  return(airport_content)
}

