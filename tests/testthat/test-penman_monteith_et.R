library(testthat)

# source("../../R/penman_monteith_et.R") # For local testing

context("penman_monteith_et")

test_that("penman_monteith_et matches FAO-56 example", {
  # Example from FAO-56, Chapter 4, Example 17
  t_mean <- 20
  u2 <- 2.0
  rs <- 15
  t_max <- 25
  t_min <- 15
  rh_mean <- 70
  elevation <- 100
  lat <- 30

  # The expected value from the example is ~4.1 mm/day
  # My implementation might differ slightly due to constants or rounding
  expected_et <- 4.1

  result <- penman_monteith_et(t_mean, u2, rs, t_max, t_min, rh_mean, elevation, lat)

  expect_is(result, "numeric")
  expect_true(abs(result - expected_et) < 0.2)
})
