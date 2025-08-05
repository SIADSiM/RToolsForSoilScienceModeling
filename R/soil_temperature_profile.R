#' Soil Temperature Profile
#'
#' Solves the 1D heat conduction equation in soils using finite differences.
#'
#' @param initial_temp A numeric vector of initial soil temperatures at different depths (degrees C).
#' @param surface_temp A numeric value for the surface temperature (degrees C).
#' @param thermal_diffusivity A numeric value for the soil thermal diffusivity (m^2/s).
#' @param time_step A numeric value for the time step (s).
#' @param depth_step A numeric value for the depth step (m).
#' @param num_steps A numeric value for the number of time steps.
#' @return A matrix of soil temperatures at different depths and times.
#' @references Hillel, D. (1998). Environmental Soil Physics. Academic Press.
#' @export
soil_temperature_profile <- function(initial_temp, surface_temp, thermal_diffusivity, time_step, depth_step, num_steps) {
  num_depths <- length(initial_temp)
  temp_profile <- matrix(0, nrow = num_depths, ncol = num_steps + 1)
  temp_profile[, 1] <- initial_temp

  alpha <- thermal_diffusivity * time_step / (depth_step^2)

  for (t in 1:num_steps) {
    temp_profile[1, t + 1] <- surface_temp
    for (z in 2:(num_depths - 1)) {
      temp_profile[z, t + 1] <- temp_profile[z, t] + alpha * (temp_profile[z + 1, t] - 2 * temp_profile[z, t] + temp_profile[z - 1, t])
    }
    temp_profile[num_depths, t + 1] <- temp_profile[num_depths - 1, t + 1] # Zero flux at bottom
  }

  return(temp_profile)
}
