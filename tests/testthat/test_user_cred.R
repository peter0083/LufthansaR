context("User Credentials")

# Get the existing cache option
cache_setting <- getOption("lufthansar_cache_token", default = NULL)

# Prepare token for tests
options(lufthansar_token_cache = TRUE)
testtoken <- get_token()

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
  cache_creds <- get_creds_from_cache()
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

# Cleanup
file.remove('.other-name-token')
file.remove('.lufthansa-token')




