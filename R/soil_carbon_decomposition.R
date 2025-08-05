#' First-order Soil Carbon Decomposition
#'
#' This function models first-order soil organic carbon (SOC) decomposition with climate modifiers.
#'
#' @param temperature A numeric vector of soil temperatures (degrees C).
#' @param moisture A numeric vector of soil moisture values (fraction of field capacity).
#' @param soil_organic_carbon A numeric value for the soil organic carbon content (g C/m^2).
#' @param base_decomposition_rate A numeric value for the base decomposition rate (per day).
#' @return A numeric vector of SOC decomposition rates (g C/m^2/day).
#' @references Parton, W.J., Schimel, D.S., Cole, C.V., & Ojima, D.S. (1987). Analysis of factors controlling soil organic matter levels in Great Plains grasslands. Soil Science Society of America Journal, 51(5), 1173-1179.
#' @export
soil_carbon_decomposition <- function(temperature, moisture, soil_organic_carbon, base_decomposition_rate) {
  # Temperature scalar from the CENTURY model
  temp_scalar <- ifelse(temperature > 0, 0.1 * exp(0.05 * temperature), 0)

  # Moisture scalar from the CENTURY model
  moisture_scalar <- ifelse(moisture > 0.1, 1 / (1 + 30 * exp(-8.5 * moisture)), 0)

  # Decomposition calculation
  decomposition <- soil_organic_carbon * base_decomposition_rate * temp_scalar * moisture_scalar

  return(decomposition)
}
