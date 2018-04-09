#' GET Flight Status at Departure Airport
#'
#' @param airport 3-letter IATA airport code (e.g. 'YVR'). Default 'FRA'.
#' @param fromDateTime ISO 8601 data time string. Format is YYYY-MM-DDTHH:mm. Default is the Sys.time().
#'
#' @return httr content object
#' @export
#'
#' @examples
#'
#' get_flight_status_departure(airport = "YVR", fromDateTime = Sys.time())
#'
get_flight_status_departure <- function(airport = "FRA", fromDateTime = NULL){
  # operations/flightstatus/departures/{airportCode}/{fromDateTime}
  url_flightstatus_api <- "https://api.lufthansa.com/v1/operations/flightstatus/departures/"

  # if no fromDateTime is specified, using Sys.time
  if(is.null(fromDateTime)){
    tm <- as.POSIXlt(Sys.time(), "", "%Y-%m-%dT%H:%M")
    fromDateTime <-strftime(tm,  "%Y-%m-%dT%H:%M")
  }

  url_flightstatus_api_airport <- paste0(url_flightstatus_api,airport,"/", fromDateTime)
  key <- get_token()

  # Sending GET request
  received_content <- httr::GET(url_flightstatus_api_airport,
                                httr::add_headers(Authorization = paste("Bearer", key, sep = " "),
                                            Accept = "application/json"))

  # to parse the content
  parsed_content <- httr::content(received_content,"parsed")

  # to return the parsed content
  return(parsed_content)
}


