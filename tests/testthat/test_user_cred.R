context("User Credentials")

# Get the existing cache option
cache_setting <- getOption("lufthansar_cache_token", default = NULL)

# Prepare token for tests
options(lufthansar_token_cache = TRUE)
testtoken <- get_token('../../.lufthansa-token')

test_that("Key exists", {
  expect_is(testtoken, "character")
})

test_that("Key is in environment", {
  envcreds <- get_creds_from_env()
  envtoken <- envcreds$token
  expect_equal(testtoken, envtoken)
})

test_that("Key not cached if requested", {
  options(lufthansar_token_cache = FALSE)
  cache_creds <- get_creds_from_cache()
  expect_null(cache_creds)
})

test_that("Key is in cached if requested", {
  options(lufthansar_token_cache = TRUE)
  cache_creds <- get_creds_from_cache('../../.lufthansa-token')
  expect_is(cache_creds, "list")
})

test_that("Key is in location requested", {

  # Change cache location
  options(lufthansar_token_cache = '.other-name-token')

  # Check if retrieved token is in new location
  get_token()
  cache_creds <- get_creds_from_cache()
  expect_is(cache_creds, "list")

  # Restore cache setting
  #options(lufthansar_token_cache = cache_setting)
})

#####################
#### Functionality Tests
####################

testthat::context("Basic functionality tests")

test_that('get_flight_status basic functionality', {
  #outputs

  expect_is(get_flight_status(),'list')
  expect_is(get_flight_status("LH123"),'list')
  expect_is(get_flight_status(verbose = FALSE),'list')
  expect_is(get_flight_status("LH123",verbose = FALSE ),'list')

})



test_that('get_flight_status_arrival basic functionality', {
  #outputs

  expect_is(get_flight_status_arrival(),'list')
  expect_is(get_flight_status_arrival(airport = "YYZ"),'list')
})


test_that('cget_flight_status_departure basic functionality', {
  #outputs

  expect_is(get_flight_status_departure(),'list')
  expect_is(get_flight_status_departure(airport = "YVR"),'list')
})



test_that('airport basic functionality', {
  #outputs

  expect_is(airport(),'list')
  expect_is(airport("YYZ"),'list')
})


testthat::context("errors thrown correctly")

#skip('skip')

testthat::test_that("get_flight_status_arrival throws errors correctly", {

  testthat::expect_error(get_flight_status_arrival(airport = "123"))
  testthat::expect_error(get_flight_status_arrival(fromDateTime = "sam"))

})

testthat::test_that("get_flight_status_departure throws errors correctly", {

  testthat::expect_error(get_flight_status_departure(airport = "123"))
  testthat::expect_error(get_flight_status_departure(fromDateTime = "sam"))

})

testthat::test_that("get_flight_status throws errors correctly", {

  testthat::expect_error(get_flight_status(airport = "123"))
  testthat::expect_error(get_flight_status(date = "sammy"))

})

testthat::test_that("airport throws errors correctly", {

  testthat::expect_error(airport("123"))
  testthat::expect_error(airport(c(1,3,4)))

})


# Cleanup
file.remove('.other-name-token')




