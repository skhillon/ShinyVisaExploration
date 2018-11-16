#### Data processing ####
sortedSOC <- visas$SOC_NAME %>%
    toupper() %>%
    table() %>% sort(decreasing = T)
most.common.soc <- names(sortedSOC)[1]

most.common.soc <- tail(names(sort(table(visas$SOC_NAME))), 1)
#most.common.soc

min.year <- min(visas$YEAR)
max.year <- max(visas$YEAR)

#### End Data Processing ####

function(input, output, session) {
    #### Interactive Geography Map #####
    #sample.map.filtered <-

    output$geographicVis <- renderPlot({
        leaflet(visas %>%
                    filter(CASE_STATUS == input$CASE_STATUS &
                               FULL_TIME_POSITION == input$FULL_TIME_POSITION &
                               YEAR >= min(input$YEAR) &
                               YEAR <= max(input$YEAR) &
                               PREVAILING_WAGE >= min(input$PREVAILING_WAGE) &
                               PREVAILING_WAGE <= max(input$PREVAILING_WAGE) &
                               grepl(input$SOC_NAME, SOC_NAME, ignore.case = TRUE))) %>%
            addTiles() %>%
            addMarkers(~lon, ~lat, clusterOptions = markerClusterOptions())
    })

    #### Pie Chart ####
    output$wageVis <- renderPlot({
        visas %>%
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

    output$acceptVis <- renderPlot({
        visas %>%
            filter(bewteen(visas$YEAR, input$YEAR, input$YEAR)) %>%
            filter(between(visas$PREVAILING_WAGE, input$wage1, input$wage2)) %>%
            ggplot(aes(x = input$var1, y = visas$PREVAILING_WAGE)) +
            geom_smooth(method = "lm")
    })
    session$onSessionEnded(stopApp)
}
