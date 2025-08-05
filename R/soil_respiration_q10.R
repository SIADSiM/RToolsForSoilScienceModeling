#' Q10-based Soil Respiration Model
#'
#' This function models soil respiration using a Q10 temperature coefficient.
#'
#' @param temperature A numeric vector of soil temperatures (degrees C).
#' @param base_respiration A numeric value for the base respiration rate at the reference temperature (g C/m^2/day).
#' @param q10 A numeric value for the Q10 temperature coefficient.
#' @param ref_temp A numeric value for the reference temperature (degrees C), default is 10.
#' @return A numeric vector of soil respiration rates (g C/m^2/day).
#' @references Lloyd, J., & Taylor, J.A. (1994). On the temperature dependence of soil respiration. Functional Ecology, 8(3), 315-323.
#' @export
soil_respiration_q10 <- function(temperature, base_respiration, q10, ref_temp = 10) {
  respiration <- base_respiration * q10^((temperature - ref_temp) / 10)
  return(respiration)
}
