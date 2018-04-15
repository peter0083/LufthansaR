## ---- eval=FALSE---------------------------------------------------------
#  devtools::install_github("peter0083/LufthansaR")

## ---- eval=FALSE---------------------------------------------------------
#  library(LufthansaR)

## ------------------------------------------------------------------------
LufthansaR::get_token()

## ------------------------------------------------------------------------
f_status <- LufthansaR::get_flight_status("LH493")

## ------------------------------------------------------------------------
# Departure Airport abbreviation
f_status$Departure$AirportCode

# Scheduled Departure Time (departure local time)
f_status$Departure$ScheduledTimeLocal$DateTime

# Departure Terminal
f_status$Departure$Terminal$Name

# Departure Status
f_status$Departure$TimeStatus$Definition

# Arrival Airport abbreviation
f_status$Arrival$AirportCode

# Scheduled Arrival Time (arrival local time)
f_status$Arrival$ScheduledTimeLocal$DateTime

# Arrival Terminal
f_status$Arrival$Terminal$Name

# Arrival Status
f_status$Arrival$TimeStatus$Definition

## ------------------------------------------------------------------------
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(lubridate))

## ---- eval=FALSE---------------------------------------------------------
#  get_flight_status_arrival(airport = "YVR", fromDateTime = "2018-04-13T00:00")

## ------------------------------------------------------------------------
# This to get the current local time at FRA and convert it to the ISO-8601 format.
tm <- as.POSIXlt(Sys.time(), tz="Europe/Berlin", "%Y-%m-%dT%H:%M")
tm_FRA <- strftime(tm,  "%Y-%m-%dT%H:%M")
# to parse the content
parsed_content <- LufthansaR::get_flight_status_arrival(airport = "FRA", fromDateTime = tm_FRA)

## ------------------------------------------------------------------------

if (parsed_content$FlightStatusResource$Meta$TotalCount == 1){
  
  (no_flight_returned <-parsed_content$FlightStatusResource$Meta$TotalCount)
  
} else{
  
  (no_flight_returned <- summary(parsed_content$FlightStatusResource$Flights)[1])
  
}

## ---- fig.width=7.5, fig.height=5, fig.align="center"--------------------

# The following is performed if the API returns some flight information
if(!(is.nan(no_flight_returned) | no_flight_returned <= 1)){
  flight_departure_data <- data.frame(dept_airport = rep(NA, no_flight_returned), 
            scheduled_dept =rep(NA, no_flight_returned), actual_dept =rep(NA, no_flight_returned))
  
  # wrangle the data
  for (i in 1:no_flight_returned){
  
    flight_departure_data$dept_airport[i] <- 
      parsed_content$FlightStatusResource$Flights[[1]][[i]]$Departure$AirportCode
  
    flight_departure_data$scheduled_dept[i] <-  
      parsed_content$FlightStatusResource$Flights[[1]][[i]]$Departure$ScheduledTimeLocal$DateTime
  
    flight_departure_data$actual_dept[i] <- 
      ifelse (is.null(parsed_content$FlightStatusResource$Flights[[1]][[i]]$Departure$ActualTimeLocal$DateTime), NA, parsed_content$FlightStatusResource$Flights[[1]][[i]]$Departure$ActualTimeLocal$DateTime)
  }
  
  # clean the json data
  flight_departure_data$delay <-
    -as.numeric(as.duration(interval(ymd_hm(flight_departure_data$actual_dept),                                                                          ymd_hm(flight_departure_data$scheduled_dept))), "minutes")
  flight_departure_data<- flight_departure_data %>% 
    mutate(status = ifelse(is.na(delay), "not departed", 
                         ifelse(delay>0, "delayed departure", "early/on-time"))) %>% 
    mutate(delay = ifelse(is.na(delay), 1,  delay)) 
  
  # visualize the result
  ggplot(data=flight_departure_data, aes(x=as.factor(dept_airport), y=delay)) +
    geom_bar(stat="identity", aes(fill=status)) + 
    coord_flip() +
    ggtitle(paste0("Delay Status at the Departure Airports for the Flights arriving at ", "FRA")) +
    theme(legend.position = "bottom") +
    xlab("Airport") +
    ylab("Delay (minutes)")
  } else {
    
  print("No more than one flight information available at this time!")

}

## ---- eval=FALSE---------------------------------------------------------
#  get_flight_status_departure(airport = "YVR", fromDateTime = "2018-04-13T00:00")

## ------------------------------------------------------------------------
# This to get the current local time at FRA and convert it to the ISO-8601 format.
tm <- as.POSIXlt(Sys.time(), tz="Europe/Berlin", "%Y-%m-%dT%H:%M")
tm_FRA <- strftime(tm,  "%Y-%m-%dT%H:%M")

# to parse the content
parsed_content <- LufthansaR::get_flight_status_departure(airport = "FRA", fromDateTime = tm_FRA)

## ------------------------------------------------------------------------
# to count the number of flights returned

if (parsed_content$FlightStatusResource$Meta$TotalCount == 1){

  (no_flight_returned <-parsed_content$FlightStatusResource$Meta$TotalCount)

  } else {
    
  (no_flight_returned <- summary(parsed_content$FlightStatusResource$Flights)[1])

}

## ------------------------------------------------------------------------
# The following is performed if the API returns more than one flight

if(!(is.nan(no_flight_returned) | no_flight_returned <= 1)){
  flight_departure_data <- data.frame(flight_code = rep(NA, no_flight_returned), 
            scheduled_dept =rep(NA, no_flight_returned), destination_airport =rep(NA, no_flight_returned), arrival_time =rep(NA, no_flight_returned))
  
  # data wrangling
  for (i in 1:no_flight_returned){
  
    flight_departure_data$flight_code[i] <- 
      paste0( parsed_content$FlightStatusResource$Flights[[1]][[i]]$MarketingCarrier$AirlineID,parsed_content$FlightStatusResource$Flights[[1]][[i]]$MarketingCarrier$FlightNumber)
  
    flight_departure_data$scheduled_dept[i] <-  
      parsed_content$FlightStatusResource$Flights[[1]][[i]]$Departure$ScheduledTimeLocal$DateTime
  
    flight_departure_data$destination_airport[i] <- parsed_content$FlightStatusResource$Flights[[1]][[i]]$Arrival$AirportCode
    
    flight_departure_data$arrival_time[i] <- parsed_content$FlightStatusResource$Flights[[1]][[i]]$Arrival$ScheduledTimeLocal
  }
  
flight_departure_data
  
} else {
  
  print("No flight information available at this time!")

}


