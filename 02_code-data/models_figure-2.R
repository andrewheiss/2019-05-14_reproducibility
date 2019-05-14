library(tidyverse)
library(scales)
library(broom)
library(huxtable)
library(here)

source(here("lib", "graphics.R"))

weather_provo_2017 <- readRDS(here("data", "provo_weather_2017_clean.rds"))


# Models
model1 <- lm(temperatureHigh ~ humidity_scaled + moonPhase_scaled + 
               precipProbability_scaled + windSpeed + pressure + cloudCover_scaled,
             data = weather_provo_2017)

model2 <- lm(temperatureHigh ~ windSpeed + pressure + cloudCover_scaled,
             data = weather_provo_2017)

summary(model1)
summary(model2)
huxreg(model1, model2) %>% 
  quick_html(file = here("output", "table-1.html"), open = FALSE)

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
ggsave(here("output", "figure_2.pdf"))
