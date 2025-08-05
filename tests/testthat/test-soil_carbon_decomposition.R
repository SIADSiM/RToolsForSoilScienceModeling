library(testthat)

# source("../../R/soil_carbon_decomposition.R") # For local testing

context("soil_carbon_decomposition")

test_that("soil_carbon_decomposition works with normal inputs", {
  temp <- 20
  moisture <- 0.6
  soc <- 10000
  base_rate <- 0.0001

  result <- soil_carbon_decomposition(temp, moisture, soc, base_rate)

  expect_is(result, "numeric")
  expect_true(result > 0)
})

test_that("soil_carbon_decomposition is zero at low temp/moisture", {
  soc <- 10000
  base_rate <- 0.0001

  # Test with low temperature
  result_low_temp <- soil_carbon_decomposition(-5, 0.6, soc, base_rate)
  expect_equal(result_low_temp, 0)

  # Test with low moisture
  result_low_moisture <- soil_carbon_decomposition(20, 0.05, soc, base_rate)
  expect_equal(result_low_moisture, 0)
})
