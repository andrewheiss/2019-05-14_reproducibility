data/provo_weather_2017_clean.rds: process-data.R
	Rscript process-data.R

output/figure_1.pdf: figure-1.R
	Rscript figure-1.R

output/table-1.html output/figure_2.pdf: models_figure-2.R
	Rscript models_figure-2.R

output: data/provo_weather_2017_clean.rds output/figure_1.pdf output/table-1.html output/figure_2.pdf

clean:
	rm data/provo_weather_2017_clean.rds output/figure_1.pdf output/table-1.html output/figure_2.pdf
