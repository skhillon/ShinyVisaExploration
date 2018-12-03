
library(tidyverse)
library(readr)
library(leaflet)

hb1_apps <- read_csv("h1b_kaggle.csv")
new_hb1_app <- na.omit(hb1_apps)
str(new_hb1_app)

## the plan is to subset the data based on different user inputs like year,
## full time / not full time , denied / certified , withdrawn apps 
## we only subset the data to first 1:1000 observations since its so huge

leaflet(data = new_hb1_app[1:1000,]) %>% 
  addTiles() %>%
  addMarkers(~lon, ~lat, clusterOptions = markerClusterOptions())
