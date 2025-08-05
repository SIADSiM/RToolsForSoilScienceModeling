#' Green-Ampt Infiltration Model
#'
#' This function implements the Green-Ampt infiltration model.
#'
#' @param hydraulic_conductivity A numeric value for saturated hydraulic conductivity (cm/hr).
#' @param wetting_front_suction A numeric value for the wetting front suction head (cm).
#' @param change_in_water_content A numeric value for the change in water content.
#' @param time A numeric vector of time points (hr).
#' @return A numeric vector of cumulative infiltration (cm).
#' @references Green, W.H., & Ampt, G.A. (1911). Studies on soil physics. The Journal of Agricultural Science, 4(1), 1-24.
#' @export
green_ampt_infiltration <- function(hydraulic_conductivity, wetting_front_suction, change_in_water_content, time) {
  cumulative_infiltration <- numeric(length(time))
  for (i in seq_along(time)) {
    if (time[i] == 0) {
      cumulative_infiltration[i] <- 0
    } else {
      f <- function(F_val) {
        F_val - wetting_front_suction * change_in_water_content * log(1 + F_val / (wetting_front_suction * change_in_water_content)) - hydraulic_conductivity * time[i]
      }
      cumulative_infiltration[i] <- uniroot(f, lower = 0, upper = 1000)$root
    }
  }
  return(cumulative_infiltration)
}
