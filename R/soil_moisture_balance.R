#' Compute daily soil water balance
#'
#' This function computes the daily soil water balance based on FAO-56 methodology.
#'
#' @param precipitation A numeric vector of daily precipitation (mm).
#' @param evapotranspiration A numeric vector of daily potential evapotranspiration (mm).
#' @param soil_water_holding_capacity A numeric value for the total soil water holding capacity (mm).
#' @param initial_soil_moisture A numeric value for the initial soil moisture (mm).
#' @return A data frame with daily soil water storage and percolation.
#' @references Allen, R.G., Pereira, L.S., Raes, D., & Smith, M. (1998). Crop Evapotranspiration — Guidelines for computing crop water requirements. FAO Irrigation and Drainage Paper 56.
#' @export
soil_moisture_balance <- function(precipitation, evapotranspiration, soil_water_holding_capacity, initial_soil_moisture) {
  num_days <- length(precipitation)
  soil_moisture <- numeric(num_days)
  percolation <- numeric(num_days)

  soil_moisture[1] <- initial_soil_moisture + precipitation[1] - evapotranspiration[1]
  if (soil_moisture[1] > soil_water_holding_capacity) {
    percolation[1] <- soil_moisture[1] - soil_water_holding_capacity
    soil_moisture[1] <- soil_water_holding_capacity
  } else if (soil_moisture[1] < 0) {
    soil_moisture[1] <- 0
  }

  for (i in 2:num_days) {
    soil_moisture[i] <- soil_moisture[i-1] + precipitation[i] - evapotranspiration[i]
    if (soil_moisture[i] > soil_water_holding_capacity) {
      percolation[i] <- soil_moisture[i] - soil_water_holding_capacity
      soil_moisture[i] <- soil_water_holding_capacity
    } else if (soil_moisture[i] < 0) {
      soil_moisture[i] <- 0
    }
  }

  return(data.frame(date = 1:num_days, soil_moisture = soil_moisture, percolation = percolation))
}
