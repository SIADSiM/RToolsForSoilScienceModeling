# Example for soil_moisture_balance()

# Load the function (if the package is not installed)
# source("../R/soil_moisture_balance.R")

# --- 1. Define inputs ---
# Synthetic daily weather data for 30 days
set.seed(123)
precipitation <- rpois(30, lambda = 3) # Daily precipitation in mm
evapotranspiration <- runif(30, min = 1, max = 5) # Daily ET in mm

# Soil parameters
soil_water_holding_capacity <- 150 # mm
initial_soil_moisture <- 75 # mm

# --- 2. Run the model ---
water_balance_results <- soil_moisture_balance(
  precipitation = precipitation,
  evapotranspiration = evapotranspiration,
  soil_water_holding_capacity = soil_water_holding_capacity,
  initial_soil_moisture = initial_soil_moisture
)

# --- 3. View and plot results ---
print(head(water_balance_results))

# Plot the results using base R plotting
plot(water_balance_results$date, water_balance_results$soil_moisture,
     type = 'l', col = 'blue',
     xlab = "Day", ylab = "Soil Moisture (mm)",
     main = "Daily Soil Moisture Balance")
lines(water_balance_results$date, water_balance_results$percolation, col = 'red')
legend("topright", legend = c("Soil Moisture", "Percolation"), col = c("blue", "red"), lty = 1)

# If you have ggplot2 (part of tidyverse) installed:
if (requireNamespace("ggplot2", quietly = TRUE) && requireNamespace("tidyr", quietly = TRUE)) {
  library(ggplot2)
  library(tidyr)

  water_balance_long <- pivot_longer(water_balance_results, cols = c(soil_moisture, percolation), names_to = "variable", values_to = "value")

  ggplot(water_balance_long, aes(x = date, y = value, color = variable)) +
    geom_line() +
    labs(title = "Daily Soil Moisture Balance",
         x = "Day",
         y = "Water (mm)") +
    theme_minimal()
}
