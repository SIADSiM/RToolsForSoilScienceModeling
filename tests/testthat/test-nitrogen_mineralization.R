library(testthat)

# source("../../R/nitrogen_mineralization.R") # For local testing

context("nitrogen_mineralization")

test_that("nitrogen_mineralization works with normal inputs", {
  temp <- 20
  moisture <- 0.6
  c_n <- 15
  soc <- 10000
  base_rate <- 0.001

  result <- nitrogen_mineralization(temp, moisture, c_n, soc, base_rate)

  expect_is(result, "numeric")
  expect_true(result > 0)
})

test_that("nitrogen_mineralization is zero at low temp/moisture", {
  c_n <- 15
  soc <- 10000
  base_rate <- 0.001

  # Test with low temperature
  result_low_temp <- nitrogen_mineralization(-5, 0.6, c_n, soc, base_rate)
  expect_equal(result_low_temp, 0)

  # Test with low moisture
  result_low_moisture <- nitrogen_mineralization(20, 0.05, c_n, soc, base_rate)
  expect_equal(result_low_moisture, 0)
})
