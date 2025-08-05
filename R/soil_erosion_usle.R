#' Universal Soil Loss Equation (USLE)
#'
#' This function implements the Universal Soil Loss Equation (Wischmeier & Smith, 1978).
#'
#' @param R A numeric value or a SpatRaster object for the rainfall-runoff erosivity factor.
#' @param K A numeric value or a SpatRaster object for the soil erodibility factor.
#' @param LS A numeric value or a SpatRaster object for the topographic factor (slope length and steepness).
#' @param C A numeric value or a SpatRaster object for the cover-management factor.
#' @param P A numeric value or a SpatRaster object for the support practice factor.
#' @return A numeric value or a SpatRaster object representing the average annual soil loss.
#' @references Wischmeier, W.H., & Smith, D.D. (1978). Predicting rainfall erosion losses. USDA Agriculture Handbook 537.
#' @importFrom terra rast
#' @export
soil_erosion_usle <- function(R, K, LS, C, P) {
  if (inherits(R, "SpatRaster") || inherits(K, "SpatRaster") || inherits(LS, "SpatRaster") || inherits(C, "SpatRaster") || inherits(P, "SpatRaster")) {
    # Ensure all inputs are SpatRasters if one is
    if (!inherits(R, "SpatRaster")) R <- terra::rast(ext(K), res = res(K), vals = R)
    if (!inherits(K, "SpatRaster")) K <- terra::rast(ext(R), res = res(R), vals = K)
    if (!inherits(LS, "SpatRaster")) LS <- terra::rast(ext(R), res = res(R), vals = LS)
    if (!inherits(C, "SpatRaster")) C <- terra::rast(ext(R), res = res(R), vals = C)
    if (!inherits(P, "SpatRaster")) P <- terra::rast(ext(R), res = res(R), vals = P)

    soil_loss <- R * K * LS * C * P
  } else {
    soil_loss <- R * K * LS * C * P
  }

  return(soil_loss)
}
