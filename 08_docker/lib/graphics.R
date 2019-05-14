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
