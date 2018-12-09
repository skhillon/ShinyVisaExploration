function(input, output, session) {
   #### Interactive Geography Map #####
   output$geographicVis <- renderLeaflet({
      leaflet(visas %>%
                 filter(
                    {if (input$EMPLOYER_NAME_MAP != "")
                       grepl(input$EMPLOYER_NAME_MAP,
                             EMPLOYER_NAME, ignore.case = TRUE)
                       else
                          TRUE} &
                    {if (input$SOC_NAME_MAP != "")
                       grepl(input$SOC_NAME_MAP,
                             SOC_NAME, ignore.case = TRUE)
                       else
                          TRUE} &
                    {if (input$JOB_TITLE_MAP != "")
                       grepl(input$JOB_TITLE_MAP,
                             JOB_TITLE, ignore.case = TRUE)
                       else
                          TRUE} &
                    {if (input$FULL_TIME_POSITION_MAP != "")
                       FULL_TIME_POSITION == input$FULL_TIME_POSITION_MAP
                       else
                          TRUE} &
                       CASE_STATUS %in% input$CASE_STATUS_MAP &
                       YEAR >= min(input$YEAR_MAP) &
                       YEAR <= max(input$YEAR_MAP) &
                       PREVAILING_WAGE >= min(input$PREVAILING_WAGE_MAP) &
                       PREVAILING_WAGE <= max(input$PREVAILING_WAGE_MAP)
                 )
      ) %>%
         addTiles() %>%
         addMarkers(~lon, ~lat, clusterOptions = markerClusterOptions())
   })

   #### Pie Chart ####
   output$acceptVis <- renderPlot({
      visas %>%
         filter(
            {if (input$EMPLOYER_NAME_PIE != "")
               grepl(input$EMPLOYER_NAME_PIE,
                     EMPLOYER_NAME, ignore.case = TRUE)
               else
                  TRUE} &
            {if (input$SOC_NAME_PIE != "")
               grepl(input$SOC_NAME_PIE,
                     SOC_NAME, ignore.case = TRUE)
               else
                  TRUE} &
            {if (input$JOB_TITLE_PIE != "")
               grepl(input$JOB_TITLE_PIE,
                     JOB_TITLE, ignore.case = TRUE)
               else
                  TRUE} &
            {if (input$FULL_TIME_POSITION_PIE != "")
               FULL_TIME_POSITION == input$FULL_TIME_POSITION_PIE
               else
                  TRUE} &
               YEAR >= min(input$YEAR_PIE) &
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
            {if (input$FULL_TIME_POSITION_3 != "")
               FULL_TIME_POSITION == input$FULL_TIME_POSITION_3
               else
                  TRUE} &
            {if (input$SOC_NAME_3 != "")
               SOC_NAME == input$SOC_NAME_3
               else
                  TRUE} &
            {if (input$JOB_TITLE_3 != "")
               JOB_TITLE == input$JOB_TITLE_3
               else
                  TRUE} &
            {if (input$EMPLOYER_NAME_3 != "")
               EMPLOYER_NAME == input$EMPLOYER_NAME_3
               else
                  TRUE} &
               YEAR >= min(input$YEAR_3) &
               YEAR <= max(input$YEAR_3) &
               PREVAILING_WAGE >= min(input$PREVAILING_WAGE_3) &
               PREVAILING_WAGE <= max(input$PREVAILING_WAGE_3)
         ) %>%
           ggplot(aes(x = CASE_STATUS, y = mean(PREVAILING_WAGE), fill = CASE_STATUS)) +
         geom_bar(stat = "identity") +
         labs(x = "Case Status", y = "Mean Prevailing Wage") +
         scale_fill_manual(values = statusPalette) +
           scale_y_continuous(labels = comma)#+
      #geom_smooth(method = "lm", color = "red")
   })

    #### Reset Filter Buttons ####
    observeEvent(input$mapResetFilters, {
        reset("CASE_STATUS_MAP")

        map_tags <- c("EMPLOYER_NAME_MAP", "SOC_NAME_MAP", "JOB_TITLE_MAP",
                      "FULL_TIME_POSITION_MAP", "PREVAILING_WAGE_MAP", "YEAR_MAP")

        for (tag in map_tags) {
            reset(tag)
        }
    })

    observeEvent(input$acceptResetFilters, {
        accept_tags <- c("EMPLOYER_NAME_PIE", "SOC_NAME_PIE", "JOB_TITLE_PIE",
                         "FULL_TIME_POSITION_PIE", "PREVAILING_WAGE_PIE", "YEAR_PIE")

        for (tag in accept_tags) {
            reset(tag)
        }
    })

    observeEvent(input$wageResetFilters, {
        wage_tags <- c("EMPLOYER_NAME_3", "SOC_NAME_3", "JOB_TITLE_3",
                         "FULL_TIME_POSITION_3", "PREVAILING_WAGE_3", "YEAR_3")

        for (tag in wage_tags) {
            reset(tag)
        }
    })

    # Automatically stop app when R session terminates.
    session$onSessionEnded(stopApp)
}

#deployApp()
