#' GET Flight Status at Arrival Airport
#'
#' @param airport 3-letter IATA airport code (e.g. 'YVR'). Default 'FRA'.
#' @param fromDateTime ISO 8601 data time string. Format is YYYY-MM-DDTHH:mm. Default is the Sys.time().
#'
#' @return httr content object
#' @export
#'
#' @examples
#' get_flight_status_departure(airport = "YVR", fromDateTime = Sys.time())



get_flight_status_arrival <- function(airport = "FRA", fromDateTime = NULL){
  # operations/flightstatus/arrivals/{airportCode}/{fromDateTime}
  url_flightstatus_api <- "https://api.lufthansa.com/v1/operations/flightstatus/arrivals/"

  # if no fromDateTime is specified, using Sys.time
  if(is.null(fromDateTime)){
    tm <- as.POSIXlt(Sys.time(), "", "%Y-%m-%dT%H:%M")
    fromDateTime <-strftime(tm,  "%Y-%m-%dT%H:%M")
  }

  # check fromDateTime class. The class should be "characer".
  if(class(fromDateTime) != "character"){
    stop("Problem with the fromDateTime input : ", fromDateTime, "-- Input CLASS should be 'character'. ie. '2018-04-09 12:27:11 PDT'")
  }

  # check fromDateTime length. The length should be "1".
  if(length(fromDateTime) != 1){
    stop("Problem with the fromDateTime input : ", fromDateTime, "-- Input LENGTH should be '1'. ie. '2018-04-09 12:27:11 PDT'")
  }

  url_flightstatus_api_airport <- paste0(url_flightstatus_api,airport,"/", fromDateTime)
  key <- get_token()

  # Sending GET request
  received_content <- httr::GET(url_flightstatus_api_airport,
                                httr::add_headers(Authorization = paste("Bearer", key, sep = " "),
                                            Accept = "application/json"))

  # check response status. a good response should have status code = 200.
  if (received_content$status_code != 200) {
    stop("Problem with calling the API - response: ", content(received_content))
  }

  # to parse the content
  parsed_content <- httr::content(received_content,"parsed")

  # to return the parsed content
  return(parsed_content)
}

