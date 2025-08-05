#' Penman-Monteith Evapotranspiration
#'
#' This function calculates reference evapotranspiration (ET) using the FAO-56 Penman-Monteith equation.
#'
#' @param t_mean A numeric value for mean daily air temperature (degrees C).
#' @param u2 A numeric value for wind speed at 2m height (m/s).
#' @param rs A numeric value for solar radiation (MJ/m^2/day).
#' @param t_max A numeric value for maximum daily air temperature (degrees C).
#' @param t_min A numeric value for minimum daily air temperature (degrees C).
#' @param rh_mean A numeric value for mean relative humidity (%).
#' @param elevation A numeric value for elevation (m).
#' @param lat A numeric value for latitude (degrees).
#' @return A numeric value for reference evapotranspiration (mm/day).
#' @references Allen, R.G., Pereira, L.S., Raes, D., & Smith, M. (1998). Crop Evapotranspiration — Guidelines for computing crop water requirements. FAO Irrigation and Drainage Paper 56.
#' @export
penman_monteith_et <- function(t_mean, u2, rs, t_max, t_min, rh_mean, elevation, lat) {
  # Constants
  GSC <- 0.0820 # Solar constant (MJ/m^2/min)
  sigma <- 4.903e-9 # Stefan-Boltzmann constant (MJ/K^4/m^2/day)

  # Saturation vapor pressure
  es_tmax <- 0.6108 * exp(17.27 * t_max / (t_max + 237.3))
  es_tmin <- 0.6108 * exp(17.27 * t_min / (t_min + 237.3))
  es <- (es_tmax + es_tmin) / 2

  # Actual vapor pressure
  ea <- (rh_mean / 100) * es

  # Slope of the saturation vapor pressure curve
  delta <- 4098 * (0.6108 * exp(17.27 * t_mean / (t_mean + 237.3))) / (t_mean + 237.3)^2

  # Psychrometric constant
  P <- 101.3 * ((293 - 0.0065 * elevation) / 293)^5.26
  gamma <- 0.000665 * P

  # Extraterrestrial radiation
  dr <- 1 + 0.033 * cos(2 * pi / 365 * as.numeric(format(Sys.Date(), "%j")))
  delta_sol <- 0.409 * sin(2 * pi / 365 * as.numeric(format(Sys.Date(), "%j")) - 1.39)
  ws <- acos(-tan(lat * pi / 180) * tan(delta_sol))
  Ra <- (24 * 60 / pi) * GSC * dr * (ws * sin(lat * pi / 180) * sin(delta_sol) + cos(lat * pi / 180) * cos(delta_sol) * sin(ws))

  # Net radiation
  Rso <- (0.75 + 2e-5 * elevation) * Ra
  Rns <- (1 - 0.23) * rs
  Rnl <- sigma * (((t_max + 273.16)^4 + (t_min + 273.16)^4) / 2) * (0.34 - 0.14 * sqrt(ea)) * (1.35 * (rs / Rso) - 0.35)
  Rn <- Rns - Rnl

  # ET calculation
  ET0 <- (0.408 * delta * (Rn - 0) + gamma * (900 / (t_mean + 273)) * u2 * (es - ea)) / (delta + gamma * (1 + 0.34 * u2))

  return(ET0)
}
