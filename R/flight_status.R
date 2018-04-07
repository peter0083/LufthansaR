#' GEt the status of a flight.
#'
#' @param flight_num (the flight number)
#' @param dep_date Date of departure.  CAn be from yesterday to 5 days in the future, default today
#' @param verbose prints flight data as well as outputting the httr object
#' @return httr content object
#' @export

get_flight_status <- function(flight_num = "AC123", dep_date = Sys.Date(), verbose = TRUE){

  url_api <- "https://api.lufthansa.com/v1/operations/flightstatus/"
  url_flight <- paste0(url_api,flight_num,"/",dep_date)

  # Getting the content from the Airport Resources API
  received_content <- httr::GET(url = url_flight,
                                config = httr::add_headers(Authorization = Authorization()))

  content <- httr::content(received_content, "parsed")
  content <- content$FlightStatusResource$Flights$Flight

  if (verbose == TRUE){
    basic_msg <- glue("Flight {flight_num} on {dep_date}")
    departing_msg <- glue("Scheduled Departure from {content$Departure$AirportCode} at {content$Departure$ScheduledTimeLocal$DateTime} from terminal {content$Departure$Terminal$Name}.
                          Departure Status: {content$Departure$TimeStatus$Definition}")
    arriving_msg <- glue("Scheduled Arrival at {content$Arrival$AirportCode} at {content$Arrival$ScheduledTimeLocal$DateTime} at terminal {content$Arrival$Terminal$Name}.
                         Arrival Status: {content$Arrival$TimeStatus$Definition}")

    print(basic_msg)

    print(departing_msg)

    print(arriving_msg)
  }

  return(content)
}



