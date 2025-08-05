#' Fit van Genuchten parameters
#'
#' This function fits the van Genuchten (1980) retention curve parameters to data.
#'
#' @param pressure_head A numeric vector of pressure head values (cm).
#' @param water_content A numeric vector of volumetric water content values (cm^3/cm^3).
#' @param start_params A list of starting values for the nls fit, e.g., list(theta_r = 0.05, theta_s = 0.5, alpha = 0.02, n = 1.5).
#' @return A list with the fitted van Genuchten parameters (theta_r, theta_s, alpha, n).
#' @references van Genuchten, M.T. (1980). A closed-form equation for predicting the hydraulic conductivity of unsaturated soils. Soil Science Society of America Journal, 44(5), 892-898.
#' @importFrom stats nls
#' @export
soil_water_retention_vg <- function(pressure_head, water_content, start_params) {
  fit <- nls(water_content ~ theta_r + (theta_s - theta_r) / (1 + (alpha * abs(pressure_head))^n)^(1 - 1/n),
             start = start_params)

  return(summary(fit)$parameters)
}
