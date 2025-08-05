library(testthat)

# source("../../R/green_ampt_infiltration.R") # For local testing

context("green_ampt_infiltration")

test_that("green_ampt_infiltration works with normal inputs", {
  k <- 1.0 # cm/hr
  psi <- 20.0 # cm
  delta_theta <- 0.3
  time <- c(0, 1, 2)

  result <- green_ampt_infiltration(k, psi, delta_theta, time)

  expect_is(result, "numeric")
  expect_equal(length(result), 3)
  expect_equal(result[1], 0)
  expect_true(all(result >= 0))
  expect_true(result[3] > result[2])
})

test_that("green_ampt_infiltration handles time = 0", {
  k <- 1.0
  psi <- 20.0
  delta_theta <- 0.3
  time <- c(0)

  result <- green_ampt_infiltration(k, psi, delta_theta, time)

  expect_equal(result, c(0))
})
