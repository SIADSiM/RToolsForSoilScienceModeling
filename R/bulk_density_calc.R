#' Calculate Bulk Density
#'
#' This function calculates bulk density from particle density and porosity.
#'
#' @param particle_density A numeric value for particle density (g/cm^3).
#' @param porosity A numeric value for porosity (fraction).
#' @return A numeric value for bulk density (g/cm^3).
#' @references Hillel, D. (1998). Environmental Soil Physics. Academic Press.
#' @export
bulk_density_calc <- function(particle_density, porosity) {
  bulk_density <- particle_density * (1 - porosity)
  return(bulk_density)
}
