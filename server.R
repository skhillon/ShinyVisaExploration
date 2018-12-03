function(input, output, session) {
    #### Interactive Geography Map #####
    output$geographicVis <- renderLeaflet({
        leaflet(visas %>%
                    filter(
                       if (input$FULL_TIME_POSITION_MAP != "") 
                          FULL_TIME_POSITION == input$FULL_TIME_POSITION_MAP
                       else 
                          TRUE
                    ) %>%
                    filter(CASE_STATUS %in% input$CASE_STATUS_MAP &
                               FULL_TIME_POSITION == input$FULL_TIME_POSITION_MAP &
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
    output$acceptVis <- renderPlot({
        visas %>%
          filter(
             if (input$FULL_TIME_POSITION_PIE != "") 
                FULL_TIME_POSITION == input$FULL_TIME_POSITION_PIE
             else 
                TRUE
          ) %>%
            filter(YEAR >= min(input$YEAR_PIE) &
                      YEAR <= max(input$YEAR_PIE) &
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
    output$wageVis <- renderPlot({
        visas %>%
            filter(
               if (input$FULL_TIME_POSITION_3 != "") 
                  FULL_TIME_POSITION == input$FULL_TIME_POSITION_3 
               else 
                  TRUE
               ) %>%
            filter(YEAR >= min(input$YEAR_3) &
                      YEAR <= max(input$YEAR_3) &
                      PREVAILING_WAGE >= min(input$PREVAILING_WAGE_3) &
                      PREVAILING_WAGE <= max(input$PREVAILING_WAGE_3) #&
                      #FULL_TIME_POSITION == input$FULL_TIME_POSITION_3
                   ) %>%
            ggplot(aes_string(x = "CASE_STATUS", y = "PREVAILING_WAGE", fill = "CASE_STATUS")) +
            geom_bar(stat = "identity") +
            labs(x = "Case Status", y = "Prevailing Wage") +
            scale_fill_manual(values = statusPalette) #+
            #geom_smooth(method = "lm", color = "red")
    })
    session$onSessionEnded(stopApp)
}

#deployApp()
