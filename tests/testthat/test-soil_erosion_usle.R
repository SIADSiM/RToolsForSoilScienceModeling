library(testthat)
library(terra)

# source("../../R/soil_erosion_usle.R") # For local testing

context("soil_erosion_usle")

test_that("soil_erosion_usle works with scalar inputs", {
  R <- 90
  K <- 0.3
  LS <- 1.2
  C <- 0.2
  P <- 1

  result <- soil_erosion_usle(R, K, LS, C, P)

  expect_is(result, "numeric")
  expect_equal(result, 6.48)
})

test_that("soil_erosion_usle works with raster inputs", {
  # Create dummy raster data
  r <- rast(nrows = 10, ncols = 10, xmin = 0, xmax = 10, ymin = 0, ymax = 10)
  R <- setValues(r, 90)
  K <- setValues(r, 0.3)
  LS <- setValues(r, 1.2)
  C <- setValues(r, 0.2)
  P <- setValues(r, 1)

  result <- soil_erosion_usle(R, K, LS, C, P)

  expect_s4_class(result, "SpatRaster")
  expect_equal(global(result, "mean", na.rm = TRUE)$mean, 6.48, tolerance = 1e-9)
})
