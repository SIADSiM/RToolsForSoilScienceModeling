library(testthat)

# source("../../R/bulk_density_calc.R") # For local testing

context("bulk_density_calc")

test_that("bulk_density_calc works with normal inputs", {
  particle_density <- 2.65 # g/cm^3
  porosity <- 0.5

  result <- bulk_density_calc(particle_density, porosity)

  expect_is(result, "numeric")
  expect_equal(result, 1.325)
})

test_that("bulk_density equals particle_density when porosity is 0", {
  particle_density <- 2.65
  porosity <- 0

  result <- bulk_density_calc(particle_density, porosity)

  expect_equal(result, particle_density)
})

test_that("bulk_density is 0 when porosity is 1", {
  particle_density <- 2.65
  porosity <- 1

  result <- bulk_density_calc(particle_density, porosity)

  expect_equal(result, 0)
})
