## ---- echo = FALSE-------------------------------------------------------
#library(glue)

## ---- eval=FALSE---------------------------------------------------------
#  devtools::install_github("peter0083/LufthansaR")

## ---- eval=FALSE---------------------------------------------------------
#  library(LufthansaR)

## ---- eval=FALSE---------------------------------------------------------
#  LufthansaR::get_token()

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

