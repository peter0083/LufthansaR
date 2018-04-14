# LufthansaR
`r Sys.Date()`  


```r
library(glue)
```

## Introduction to LufthansaR

`LufthansaR` is an API wrapper package for R. It enables programmers to access to [Lufthansa Open API](https://developer.lufthansa.com/docs) from R environment. 

This document introduces you to LufthansaR's basic set of tools, and show how to use them. Once you have installed the package, read `vignette("LufthansaR")` to learn more.

## Lufthansa Open API

To have access to Lufthansa Open API, one has to sign in to Mashery, Lufthansa's developer platform, and apply for a key. Please visit [here](https://developer.lufthansa.com/docs/API_basics/). Once you are registered, you will be given:

- a key and
- a secret

These two values can be exchanged for a _short-lived_ access token. A valid access token must be sent with every API request while accessing any Lufthansa's API. In other words, every Lufthansa API requires you to pass Oauth token when getting the data from it. 

## How to install LufthansaR

You can install `LufthansaR` development version from GitHub


```r
library(devtools)
install_github("peter0083/LufthansaR")
```

CRAN version of the package will be scheduled to be added in the next version.

## How to deal with Lufthansa Open API credentials

TBD

## Usage

You can load `LufthansaR` as follows.


```r
library(LufthansaR)
```

This will load the core `lufthansaR` functions. 

## How to see the active token used

Get the current token being used by the package


```r
get_token()
```

Each token is valid for a specified period of time. When the token is valid, `LufthansaR` uses the `Client ID` and `Client Secret` in your `.Renviron`.

## How to get flight status

This will print out the flight's information 

```r
f_status <- get_flight_status("LH493")
```

```
## Flight LH493 on 2018-04-14
## Scheduled Departure from YVR at 2018-04-14T16:20 from terminal M.
## Departure Status: Flight On Time
## Scheduled Arrival at FRA at 2018-04-15T11:05 at terminal 1.
## Arrival Status: Flight On Time
```

Default is today's data. However, you can call 5 days in the future by passing `dep_date="2018-04-15"` argument. The departure date (YYYY-MM-DD) in the local time of the departure airport.

Since the function returns httr content object, you can access to different attributes of the content:


```r
# Departure Airport abbreviation
f_status$Departure$AirportCode
```

```
## [1] "YVR"
```

```r
# Scheduled Departure Time (departure local time)
f_status$Departure$ScheduledTimeLocal$DateTime
```

```
## [1] "2018-04-14T16:20"
```

```r
# Departure Terminal
f_status$Departure$Terminal$Name
```

```
## [1] "M"
```

```r
# Departure Status
f_status$Departure$TimeStatus$Definition
```

```
## [1] "Flight On Time"
```

```r
# Arrival Airport abbreviation
f_status$Arrival$AirportCode
```

```
## [1] "FRA"
```

```r
# Scheduled Arrival Time (arrival local time)
f_status$Arrival$ScheduledTimeLocal$DateTime
```

```
## [1] "2018-04-15T11:05"
```

```r
# Arrival Terminal
f_status$Arrival$Terminal$Name
```

```
## [1] 1
```

```r
# Arrival Status
f_status$Arrival$TimeStatus$Definition
```

```
## [1] "Flight On Time"
```


## Getting status of flights arriving at a particular airport

TBA 

## Getting status of flights departing from a particular airport 

TBA

Visualization to add

to built vignette use shift  + ctrl + D
