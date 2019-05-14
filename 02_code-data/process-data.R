# Load libraries
library(tidyverse)
library(lubridate)
library(here)

# Load data
weather_provo_raw <- read_csv(here("data", "provo_weather_2017.csv"))

weather_provo_2017 <- weather_provo_raw %>% 
  mutate(Month = month(date, label = TRUE, abbr = FALSE),
         Day = wday(date, label = TRUE, abbr = FALSE)) %>% 
  mutate(humidity_scaled = humidity * 100,
         moonPhase_scaled = moonPhase * 100,
         precipProbability_scaled = precipProbability * 100,
         cloudCover_scaled = cloudCover * 100)

saveRDS(weather_provo_2017, here("data", "provo_weather_2017_clean.rds"))
