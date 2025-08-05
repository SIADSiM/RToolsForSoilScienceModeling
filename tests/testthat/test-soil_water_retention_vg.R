library(testthat)

# source("../../R/soil_water_retention_vg.R") # For local testing

context("soil_water_retention_vg")

test_that("soil_water_retention_vg fits parameters correctly", {
  # Generate synthetic data
  theta_r_true <- 0.05
  theta_s_true <- 0.45
  alpha_true <- 0.02
  n_true <- 1.5

  pressure_head <- seq(1, 1000, by = 50)
  water_content_true <- theta_r_true + (theta_s_true - theta_r_true) / (1 + (alpha_true * pressure_head)^n_true)^(1 - 1/n_true)

  # Add some noise
  set.seed(123)
  water_content_noisy <- water_content_true + rnorm(length(water_content_true), 0, 0.01)

  start_params <- list(theta_r = 0.1, theta_s = 0.4, alpha = 0.01, n = 1.4)

  fitted_params <- soil_water_retention_vg(pressure_head, water_content_noisy, start_params)

  expect_is(fitted_params, "matrix")
  expect_equal(nrow(fitted_params), 4)

  # Check if the fitted parameters are close to the true parameters
  expect_true(abs(fitted_params["theta_r", "Estimate"] - theta_r_true) < 0.02)
  expect_true(abs(fitted_params["theta_s", "Estimate"] - theta_s_true) < 0.02)
  expect_true(abs(fitted_params["alpha", "Estimate"] - alpha_true) < 0.01)
  expect_true(abs(fitted_params["n", "Estimate"] - n_true) < 0.1)
})
