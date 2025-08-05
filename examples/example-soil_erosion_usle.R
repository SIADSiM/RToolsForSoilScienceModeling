# Example for soil_erosion_usle()

# Load the function and terra library
# source("../R/soil_erosion_usle.R")
library(terra)

# --- 1. Scalar (single value) calculation ---
print("--- Scalar USLE Calculation ---")
R_factor <- 150
K_factor <- 0.4
LS_factor <- 0.8
C_factor <- 0.1
P_factor <- 1.0

scalar_erosion <- soil_erosion_usle(R_factor, K_factor, LS_factor, C_factor, P_factor)
print(paste("Average annual soil loss:", round(scalar_erosion, 2), "t/ha/yr"))


# --- 2. Raster-based calculation ---
print("--- Raster USLE Calculation ---")

# Create a dummy raster template
template <- rast(nrows=20, ncols=20, xmin=0, xmax=20, ymin=0, ymax=20, crs="local")

# Create raster layers for each USLE factor
# In a real scenario, these would be loaded from files
set.seed(123)
R_raster <- setValues(template, runif(ncell(template), 140, 160))
K_raster <- setValues(template, runif(ncell(template), 0.3, 0.5))
LS_raster <- setValues(template, runif(ncell(template), 0.5, 1.5))
C_raster <- setValues(template, runif(ncell(template), 0.05, 0.2))
P_raster <- setValues(template, 1.0) # Assume no support practices

# --- 3. Run the model with raster inputs ---
raster_erosion <- soil_erosion_usle(R_raster, K_raster, LS_raster, C_raster, P_raster)

# --- 4. View and plot results ---
print("Summary of raster-based soil loss:")
print(summary(raster_erosion))

# Plot the output raster
plot(raster_erosion, main = "Spatial Distribution of Estimated Soil Loss (t/ha/yr)")
