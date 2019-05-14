FROM rocker/verse:3.6.0

MAINTAINER Andrew Heiss <andrew@andrewheiss.com>

# Install other libraries
RUN install2.r --error \
        ggridges here huxtable

COPY provo-weather.Rmd 08_docker.Rproj /home/rstudio/
COPY data/ /home/rstudio/data/
COPY lib/ /home/rstudio/lib/
