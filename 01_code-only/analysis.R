# Provo weather analysis, 2017
# Author: Andrew Heiss
# Last run: A while ago? I forgot to write it down.


# Libraries, data, functions ----------------------------------------------

# Load libraries
library(tidyverse)
library(lubridate)
library(ggridges)
library(broom)
library(huxtable)
library(scales)

# Make the randomness reproducible
set.seed(1234)

# Create custom ggplot theme
theme_weather <- function(base_size = 9) {
  ret <- theme_bw(base_size) +
    theme(plot.title = element_text(size = rel(1.4), face = "bold"),
          plot.subtitle = element_text(size = rel(1)),
          plot.caption = element_text(size = rel(0.8), color = "grey50", 
                                      face = "plain", margin = margin(t = 10)),
          panel.border = element_blank(),
          panel.spacing = unit(1, "lines"),
          panel.grid.minor = element_blank(),
          strip.text = element_text(size = rel(0.9), hjust = 0, face = "bold"),
          strip.background = element_rect(fill = "#ffffff", colour = NA),
          axis.ticks = element_blank(),
          axis.title.x = element_text(margin = margin(t = 10)),
          legend.key = element_blank(),
          legend.text = element_text(size = rel(1)),
          legend.spacing = unit(0.1, "lines"),
          legend.box.margin = margin(t = -0.5, unit = "lines"),
          legend.margin = margin(t = 0))
  
  ret
}

# Load data
# Please e-mail andrew_heiss@byu.edu for the original data
# Or download it from https://andhs.co/provoweather
weather_provo_raw <- read_csv("provo_weather_2017.csv")

weather_provo_2017 <- weather_provo_raw %>% 
  mutate(Month = month(date, label = TRUE, abbr = FALSE),
         Day = wday(date, label = TRUE, abbr = FALSE)) %>% 
  mutate(humidity_scaled = humidity * 100,
         moonPhase_scaled = moonPhase * 100,
         precipProbability_scaled = precipProbability * 100,
         cloudCover_scaled = cloudCover * 100)


# Exploratory stuff -------------------------------------------------------

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


# Models and predictions --------------------------------------------------

# Models
model1 <- lm(temperatureHigh ~ humidity_scaled + moonPhase_scaled + 
               precipProbability_scaled + windSpeed + pressure + cloudCover_scaled,
             data = weather_provo_2017)

model2 <- lm(temperatureHigh ~ windSpeed + pressure + cloudCover_scaled,
             data = weather_provo_2017)

summary(model1)
summary(model2)
huxreg(model1, model2)

# Predictions

# Does cloud cover in May have an effect on high temperatures?

monthly_averages <- weather_provo_2017 %>% 
  group_by(Month) %>% 
  summarize_if(is.numeric, mean, na.rm = TRUE)

may_avg <- monthly_averages %>% filter(Month == "May")

newdata_clouds <- tibble(windSpeed = may_avg$windSpeed,
                         pressure = may_avg$pressure,
                         precipProbability_scaled = may_avg$precipProbability_scaled,
                         moonPhase_scaled = may_avg$moonPhase_scaled,
                         humidity_scaled = may_avg$humidity_scaled,
                         cloudCover_scaled = seq(0, 100, by = 1))

# Calculate confidence intervals and scale cloud cover back down to 0-1 instead
# of 0-100 so we can use scale_x_continuous(labels = percent)
predicted_highs_clouds_1 <- augment(model1, newdata = newdata_clouds) %>% 
  mutate(model = "Model 1")
predicted_highs_clouds_2 <- augment(model2, newdata = newdata_clouds) %>% 
  mutate(model = "Model 2")

predicted_highs_clouds <- bind_rows(predicted_highs_clouds_1, 
                                    predicted_highs_clouds_2) %>% 
  mutate(conf.low = .fitted + (-1.96 * .se.fit),
         conf.high = .fitted + (1.96 * .se.fit)) %>% 
  mutate(cloudCover = cloudCover_scaled / 100) %>% 
  mutate(model = factor(model))

ggplot(predicted_highs_clouds, aes(x = cloudCover, y = .fitted)) +
  geom_ribbon(aes(fill = model, ymin = conf.low, ymax = conf.high),
              alpha = 0.3) + 
  geom_line(aes(color = model), size = 1) +
  scale_x_continuous(labels = percent) +
  scale_color_viridis_d(option = "plasma", end = 0.8, name = NULL) +
  scale_fill_viridis_d(option = "plasma", end = 0.8, name = NULL) +
  labs(x = "Cloud cover", y = "Predicted high temperature (F)") +
  theme_weather()
