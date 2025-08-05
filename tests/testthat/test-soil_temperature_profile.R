library(testthat)

# source("../../R/soil_temperature_profile.R") # For local testing

context("soil_temperature_profile")

test_that("soil_temperature_profile works with normal inputs", {
  initial_temp <- rep(10, 5)
  surface_temp <- 20
  thermal_diffusivity <- 0.00002
  time_step <- 3600
  depth_step <- 0.1
  num_steps <- 10

  result <- soil_temperature_profile(initial_temp, surface_temp, thermal_diffusivity, time_step, depth_step, num_steps)

  expect_is(result, "matrix")
  expect_equal(nrow(result), 5)
  expect_equal(ncol(result), 11)
  expect_equal(result[1, 2], surface_temp)
})

test_that("soil_temperature_profile returns initial temps at time 0", {
  initial_temp <- c(10, 11, 12, 13, 14)
  surface_temp <- 20
  thermal_diffusivity <- 0.00002
  time_step <- 3600
  depth_step <- 0.1
  num_steps <- 10

  result <- soil_temperature_profile(initial_temp, surface_temp, thermal_diffusivity, time_step, depth_step, num_steps)

  expect_equal(result[, 1], initial_temp)
})
