library(testthat)

# source("../../R/soil_respiration_q10.R") # For local testing

context("soil_respiration_q10")

test_that("soil_respiration_q10 works with normal inputs", {
  temp <- 20
  base_resp <- 2
  q10 <- 2

  result <- soil_respiration_q10(temp, base_resp, q10)

  expect_is(result, "numeric")
  expect_equal(result, 4)
})

test_that("respiration increases with temperature", {
  base_resp <- 2
  q10 <- 2

  resp_10 <- soil_respiration_q10(10, base_resp, q10)
  resp_20 <- soil_respiration_q10(20, base_resp, q10)

  expect_true(resp_20 > resp_10)
})

test_that("respiration at ref_temp equals base_respiration", {
  temp <- 15
  base_resp <- 2
  q10 <- 2
  ref_temp <- 15

  result <- soil_respiration_q10(temp, base_resp, q10, ref_temp)

  expect_equal(result, base_resp)
})
