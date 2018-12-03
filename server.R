function(input, output, session) {
    #### Interactive Geography Map #####
    output$geographicVis <- renderLeaflet({
        leaflet(visas %>%
                    filter(CASE_STATUS %in% input$CASE_STATUS &
                               #FULL_TIME_POSITION == input$FULL_TIME_POSITION &
                               YEAR >= min(input$YEAR_MAP) &
                               YEAR <= max(input$YEAR_MAP) &
                               PREVAILING_WAGE >= min(input$PREVAILING_WAGE_MAP) &
                               PREVAILING_WAGE <= max(input$PREVAILING_WAGE_MAP) #&
                               #grepl(input$SOC_NAME, SOC_NAME, ignore.case = TRUE)
                           )
                ) %>%
            addTiles() %>%
            addMarkers(~lon, ~lat, clusterOptions = markerClusterOptions())
    })

    #### Pie Chart ####
    output$wageVis <- renderPlot({
        visas %>%
            filter(YEAR >= min(input$YEAR_PIE) &
                      YEAR <= max(input$YEAR_PIE) &
                       CASE_STATUS %in% input$CASE_STATUS_PIE &
                      PREVAILING_WAGE >= min(input$PREVAILING_WAGE_PIE) &
                      PREVAILING_WAGE <= max(input$PREVAILING_WAGE_PIE)) %>%
            ggplot(aes(x = "", y = CASE_STATUS, fill = CASE_STATUS)) +
            geom_bar(width = 1, stat = "identity") +
            coord_polar("y", start = 0) +
            xlab(NULL) +
            ylab("Case Status") +
            theme(axis.text = element_blank(),
                  axis.ticks = element_blank(),
                  panel.grid = element_blank()) +
            scale_fill_manual(values = statusPalette)
    })

    #### Bar chart ####
    output$acceptVis <- renderPlot({
        visas %>%
            filter(YEAR >= min(input$YEAR) &
                      YEAR <= max(input$YEAR) &
                      visas$PREVAILING_WAGE >= min(input$PREVAILING_WAGE) &
                      visas$PREVAILING_WAGE <= max(input$PREVAILING_WAGE)) %>%
            ggplot(aes_string(x = "CASE_STATUS", y = "PREVAILING_WAGE", color = "CASE_STATUS")) +
            geom_bar(stat = "identity") +
            labs(x = "Case Status", y = "Prevailing Wage") #+
            #geom_smooth(method = "lm", color = "red")
    })
    session$onSessionEnded(stopApp)
}

#deployApp()
