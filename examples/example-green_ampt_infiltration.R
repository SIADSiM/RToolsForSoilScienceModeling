# Example for green_ampt_infiltration()

# Load the function
# source("../R/green_ampt_infiltration.R")

# --- 1. Define inputs ---
hydraulic_conductivity <- 1.0 # cm/hr
wetting_front_suction <- 20.0 # cm
change_in_water_content <- 0.3
time <- seq(0, 5, by = 0.1) # Time in hours

# --- 2. Run the model ---
cumulative_infiltration <- green_ampt_infiltration(
  hydraulic_conductivity = hydraulic_conductivity,
  wetting_front_suction = wetting_front_suction,
  change_in_water_content = change_in_water_content,
  time = time
)

# --- 3. View and plot results ---
results_df <- data.frame(time = time, infiltration = cumulative_infiltration)
print(head(results_df))

# Plot the results
plot(results_df$time, results_df$infiltration,
     type = 'l', col = 'darkgreen',
     xlab = "Time (hours)", ylab = "Cumulative Infiltration (cm)",
     main = "Green-Ampt Infiltration")
