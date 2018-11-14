library(tidyverse)
library(readr)
library(stringr)
library(leaflet)
library(ggplot2)

raw.input <- read_csv("h1b_kaggle.csv")

h1b.apps <- raw.input %>%
  na.omit() %>%
  sample_n(10000)

#### Interactive Geography Map #####
sample.map.filtered <- h1b.apps %>%
  filter(CASE_STATUS == input$CASE_STATUS &
           FULL_TIME_POSITION == input$FULL_TIME_POSITION & 
           (YEAR == input$YEAR) & 
           PREVAILING_WAGE > input$PREVAILING_WAGE & 
           grepl(input$SOC_NAME, SOC_NAME, ignore.case = TRUE))

leaflet(sample.map.filtered) %>% 
  addTiles() %>%
  addMarkers(~lon, ~lat, clusterOptions = markerClusterOptions())

#### Wages ####
most.common.soc <- tail(names(sort(table(h1b.apps$SOC_NAME))), 1)
most.common.soc 

h1b.apps %>%
  filter(SOC_NAME == input$SOC_NAME) %>%
  group_by(YEAR) %>%
  summarize(av.wage.by.year = mean(PREVAILING_WAGE)) %>%
  ggplot(aes(x = YEAR, y = av.wage.by.year)) +
  geom_line() +
  xlab("Year") +
  ylab("Average Wage")

#### Pie Chart ####
h1b.apps %>%
  filter(YEAR == input$YEAR) %>%
  ggplot(aes(x = "", y = input$CASE_STATUS, fill = input$CASE_STATUS)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  xlab(NULL) +
  ylab(NULL) +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())