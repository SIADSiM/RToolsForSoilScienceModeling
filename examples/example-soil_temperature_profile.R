# Example for soil_temperature_profile()

# Load the function
# source("../R/soil_temperature_profile.R")

# --- 1. Define inputs ---
initial_temp <- rep(15, 10) # Initial temperature at 10 depths (15 C)
surface_temp_series <- 25 + 10 * sin(2 * pi * (1:24) / 24) # Diurnal surface temp
thermal_diffusivity <- 0.00002 # m^2/s
time_step <- 3600 # 1 hour
depth_step <- 0.1 # 10 cm
num_steps <- 24 # 24 hours

# --- 2. Run the model ---
# We'll run the model step-by-step to apply the changing surface temperature
temp_profile_results <- matrix(0, nrow = length(initial_temp), ncol = num_steps + 1)
temp_profile_results[, 1] <- initial_temp
current_temp <- initial_temp

for(i in 1:num_steps){
  # Run for a single time step
  temp_profile_step <- soil_temperature_profile(current_temp, surface_temp_series[i], thermal_diffusivity, time_step, depth_step, 1)
  current_temp <- temp_profile_step[,2]
  temp_profile_results[, i+1] <- current_temp
}


# --- 3. View and plot results ---
print(head(temp_profile_results))

# Plot the results as a heatmap
depths <- seq(0, (length(initial_temp) - 1) * depth_step, by = depth_step)
times <- 0:num_steps

image(x = times, y = depths, z = t(temp_profile_results),
      col = heat.colors(12),
      xlab = "Time (hours)", ylab = "Depth (m)",
      main = "Soil Temperature Profile")
contour(x = times, y = depths, z = t(temp_profile_results), add = TRUE)
