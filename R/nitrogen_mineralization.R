#' Nitrogen Mineralization
#'
#' Computes nitrogen mineralization using CENTURY model temperature and moisture scalars.
#'
#' @param temperature A numeric vector of soil temperatures (degrees C).
#' @param moisture A numeric vector of soil moisture values (fraction of field capacity).
#' @param C_N_ratio A numeric value for the C:N ratio of the decomposing organic matter.
#' @param soil_organic_carbon A numeric value for the soil organic carbon content (g C/m^2).
#' @param base_mineralization_rate A numeric value for the base mineralization rate (g N/m^2/day).
#' @return A numeric vector of nitrogen mineralization rates (g N/m^2/day).
#' @references Parton, W.J., Schimel, D.S., Cole, C.V., & Ojima, D.S. (1987). Analysis of factors controlling soil organic matter levels in Great Plains grasslands. Soil Science Society of America Journal, 51(5), 1173-1179.
#' @export
nitrogen_mineralization <- function(temperature, moisture, C_N_ratio, soil_organic_carbon, base_mineralization_rate) {
  # Temperature scalar from the CENTURY model
  temp_scalar <- ifelse(temperature > 0, 0.1 * exp(0.05 * temperature), 0)

  # Moisture scalar from the CENTURY model
  moisture_scalar <- ifelse(moisture > 0.1, 1 / (1 + 30 * exp(-8.5 * moisture)), 0)

  # Mineralization calculation
  mineralization <- soil_organic_carbon / C_N_ratio * base_mineralization_rate * temp_scalar * moisture_scalar

  return(mineralization)
}
