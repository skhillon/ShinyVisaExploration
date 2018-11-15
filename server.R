library(tidyverse)
library(readr)
library(stringr)
library(leaflet)
library(ggplot2)
library(shiny)

#### Data processing ####

visas <- read_csv("visas.csv")
sortedSOC <- visas$SOC_NAME %>%
  toupper() %>%
  table() %>% sort(decreasing = T)
most.common.soc <- names(sortedSOC)[1] 

#raw.input <- read_csv("h1b_kaggle.csv")

h1b.apps <- read_csv("visas.csv") #raw.input %>%
#na.omit() %>%
#sample_n(10000)

most.common.soc <- tail(names(sort(table(h1b.apps$SOC_NAME))), 1)
most.common.soc 

min.year <- min(h1b.apps$YEAR)
max.year <- max(h1b.apps$YEAR)

#### End Data Processing ####

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
  
  output$plot3 <- renderPlot({
    h1b.apps %>%
      filter(bewteen(h1b.apps$YEAR, input$YEAR, input$YEAR)) %>%
      filter(between(h1b.apps$PREVAILING_WAGE, input$wage1, input$wage2)) %>%
      ggplot(aes(x = input$var1, y = h1b.apps$PREVAILING_WAGE)) + 
      geom_smooth(method = "lm")
  })
  session$onSessionEnded(stopApp)
}
