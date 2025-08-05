library(testthat)

# source("../../R/soil_moisture_balance.R") # For local testing

context("soil_moisture_balance")

test_that("soil_moisture_balance works with normal inputs", {
  precip <- c(10, 5, 0)
  evap <- c(3, 4, 2)
  swhc <- 100
  initial_sm <- 50

  result <- soil_moisture_balance(precip, evap, swhc, initial_sm)

  expect_is(result, "data.frame")
  expect_equal(nrow(result), 3)
  expect_equal(result$soil_moisture, c(57, 58, 56))
  expect_equal(result$percolation, c(0, 0, 0))
})

test_that("soil_moisture_balance handles percolation", {
  precip <- c(20, 10, 5)
  evap <- c(2, 3, 4)
  swhc <- 50
  initial_sm <- 40

  result <- soil_moisture_balance(precip, evap, swhc, initial_sm)

  expect_equal(result$soil_moisture, c(50, 50, 50))
  expect_equal(result$percolation, c(8, 7, 1))
})

test_that("soil_moisture_balance handles soil drying to zero", {
  precip <- c(1, 1, 1)
  evap <- c(10, 20, 5)
  swhc <- 100
  initial_sm <- 10

  result <- soil_moisture_balance(precip, evap, swhc, initial_sm)

  expect_equal(result$soil_moisture, c(1, 0, 0))
  expect_equal(result$percolation, c(0, 0, 0))
})
