context("User Credentials")

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
  options(lufthansar_token_cache = '.other-name-token')
  get_token()
  cache_creds <- get_creds_from_cache()
  expect_is(cache_creds, "list")
})

# Cleanup
file.remove('.other-name-token')

