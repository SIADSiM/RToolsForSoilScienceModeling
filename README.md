# R Tools For Soil Science Modeling
[![DOI](https://zenodo.org/badge/1032774832.svg)](https://doi.org/10.5281/zenodo.16748629)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2FSIADSiM%2FRToolsForSoilScienceModeling.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2FSIADSiM%2FRToolsForSoilScienceModeling?ref=badge_shield)

An R-based repository for modeling and analyzing soil processes, integrating physics, hydrology, biogeochemistry, and erosion dynamics.

## 👷 Installation

You can install the development version of this package from GitHub using `devtools`:

```r
# install.packages("devtools")
devtools::install_github("your-github-username/RToolsForSoilScienceModeling_DEV")
```


## ⚓ Usage Examples

Here are some examples of how to use the functions in this package. For more detailed examples, please see the scripts in the `/examples` directory.

### soil_moisture_balance

```r
# --- 1. Define inputs ---
precipitation <- rpois(30, lambda = 3)
evapotranspiration <- runif(30, min = 1, max = 5)
soil_water_holding_capacity <- 150
initial_soil_moisture <- 75

# --- 2. Run the model ---
water_balance_results <- soil_moisture_balance(
  precipitation = precipitation,
  evapotranspiration = evapotranspiration,
  soil_water_holding_capacity = soil_water_holding_capacity,
  initial_soil_moisture = initial_soil_moisture
)

# --- 3. View and plot results ---
plot(water_balance_results$date, water_balance_results$soil_moisture, type = 'l')
```

### soil_erosion_usle (with rasters)

```r
library(terra)
template <- rast(nrows=20, ncols=20, xmin=0, xmax=20, ymin=0, ymax=20)
R_raster <- setValues(template, runif(ncell(template), 140, 160))
K_raster <- setValues(template, runif(ncell(template), 0.3, 0.5))
LS_raster <- setValues(template, runif(ncell(template), 0.5, 1.5))
C_raster <- setValues(template, runif(ncell(template), 0.05, 0.2))
P_raster <- setValues(template, 1.0)
raster_erosion <- soil_erosion_usle(R_raster, K_raster, LS_raster, C_raster, P_raster)
plot(raster_erosion)
```

## 🧩 UML Diagram

The source code for the UML diagram showing the functional dependencies is available in the `uml_diagram.puml` file. You can render this file using a PlantUML tool to view the diagram.
## 📜 License

This project is licensed under a custom non-commercial license.

* ✅ **Free for personal, academic, and research use.**
* ❌ **Commercial use is strictly prohibited without a separate license.**

For commercial licensing inquiries, please contact me at ** s i a d s i m @ g m a i l . c o m  **.


[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2FSIADSiM%2FRToolsForSoilScienceModeling.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2FSIADSiM%2FRToolsForSoilScienceModeling?ref=badge_large)

## 📑 References

Allen, R.G., Pereira, L.S., Raes, D., & Smith, M. (1998). *Crop Evapotranspiration — Guidelines for computing crop water requirements*. FAO Irrigation and Drainage Paper 56.

Green, W.H. & Ampt, G.A. (1911). Studies on soil physics. *The Journal of Agricultural Science, 4*(1), 1-24.

Hillel, D. (1998). *Environmental Soil Physics*. Academic Press.

Lloyd, J. & Taylor, J.A. (1994). On the temperature dependence of soil respiration. *Functional Ecology, 8*(3), 315-323.

Parton, W.J., Schimel, D.S., Cole, C.V., & Ojima, D.S. (1987). Analysis of factors controlling soil organic matter levels in Great Plains grasslands. *Soil Science Society of America Journal, 51*(5), 1173-1179.

van Genuchten, M.T. (1980). A closed-form equation for predicting the hydraulic conductivity of unsaturated soils. *Soil Science Society of America Journal, 44*(5), 892-898.

Wischmeier, W.H., & Smith, D.D. (1978). *Predicting rainfall erosion losses*. USDA Agriculture Handbook 537.