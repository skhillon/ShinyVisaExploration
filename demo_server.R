library(tidyverse)
library(readr)
library(stringr)
library(leaflet)
library(ggplot2)
library(shiny)

raw.input <- read_csv("h1b_kaggle.csv")

most.common.soc <- tail(names(sort(table(h1b.apps$SOC_NAME))), 1)
most.common.soc 

h1b.apps <- raw.input %>%
  na.omit() %>%
  sample_n(10000)

function(input, output, session) {
  #### Interactive Geography Map #####
  sample.map.filtered <- h1b.apps %>%
    filter(CASE_STATUS == input$CASE_STATUS &
             FULL_TIME_POSITION == input$FULL_TIME_POSITION & 
             (YEAR == input$YEAR) & 
             PREVAILING_WAGE > input$PREVAILING_WAGE & 
             grepl(input$SOC_NAME, SOC_NAME, ignore.case = TRUE))
  
  output$plot1 <- renderPlot({
    leaflet(sample.map.filtered) %>% 
    addTiles() %>%
    addMarkers(~lon, ~lat, clusterOptions = markerClusterOptions())
  })
  
  #### Pie Chart ####
  output$plot2 <- renderPlot({
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
  })
  
  session$onSessionEnded(stopApp)
}


#### Wages ####
h1b.apps %>%
  filter(YEAR == input$YEAR1 & YEAR == input$YEAR2) %>%
  filter(PREVAILING_WAGE %between% c(input$wage1, input$wage2)) %>%
  summarize(av.wage.by.year = mean(PREVAILING_WAGE)) %>%
  ggplot(aes(x = YEAR, y = av.wage.by.year)) +
  geom_line() +
  xlab("Year") +
  ylab("Average Wage")
