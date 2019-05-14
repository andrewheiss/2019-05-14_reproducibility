library(tidyverse)
library(ggridges)
library(here)

source(here("lib", "graphics.R"))

weather_provo_2017 <- readRDS(here("data", "provo_weather_2017_clean.rds"))

# Monthly temperatures with density plots
# Not going to use this one because it's harder to read
# ggplot(weather_provo_2017, 
#        aes(x = temperatureHigh, fill = Month)) +
#   geom_density() +
#   scale_fill_viridis_d(option = "plasma", guide = FALSE) +
#   facet_wrap(~ Month) +
#   labs(x = "Daily high temperature", y = NULL) +
#   theme_weather()

# Ridgeplots are better
ggplot(weather_provo_2017, 
       aes(x = temperatureHigh, y = fct_rev(Month), fill = ..x..)) +
  geom_density_ridges_gradient(scale = 5, quantile_lines = TRUE, quantiles = 2) + 
  scale_fill_viridis_c(option = "plasma", name = "Temp") +
  labs(x = "Daily high temperature", y = NULL) +
  theme_weather()

ggsave(here("output", "figure_1.pdf"))
