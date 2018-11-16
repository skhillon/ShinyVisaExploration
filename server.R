statusPalette <- brewer.pal(4, "Greens")

function(input, output, session) {
    #### Interactive Geography Map #####
    output$geographicVis <- renderLeaflet({
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
            filter(YEAR >= min(input$YEAR) &
                      YEAR <= max(input$YEAR)) %>%
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
            filter(YEAR >= min(input$YEAR) &
                      YEAR <= max(input$YEAR) & 
                      visas$PREVAILING_WAGE >= min(input$PREVAILING_WAGE) &
                      visas$PREVAILING_WAGE <= max(input$PREVAILING_WAGE)) %>%
            ggplot(aes_string(x = "CASE_STATUS", y = "PREVAILING_WAGE")) +
            geom_point(color = "red") #+
            #geom_smooth(method = "lm", color = "red")
    })
    session$onSessionEnded(stopApp)
}
