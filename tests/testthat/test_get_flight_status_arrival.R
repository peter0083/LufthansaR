testthat::context("Incorrect Airport Abbreviation")

testthat::test_that("get_flight_status_arrival expect an airport abbreviation", {

  error_message <- "Invalid airport code in flight arrival status request (formally incorrect). Example: /flightstatus/arrivals/FRA/2014-12-03T10:00/2014-12-03T12:00."
  testthat::expect_identical(get_flight_status_arrival(airport = "123")$ProcessingErrors$ProcessingError$Description, error_message)

  #testthat::expect_identical(get_flight_status_arrival(airport = "Canada")$ProcessingErrors$ProcessingError$Description, error_message)
  #testthat::expect_identical(get_flight_status_arrival(airport = "Vancouver")$ProcessingErrors$ProcessingError$Description, error_message)
})
