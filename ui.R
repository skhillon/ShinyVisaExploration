##############################
#   - App Title: Visa Exploration
#   - Authors: Sarthak Khillon, Juan Moreno, Christina Walden
##############################

##### CHECK DEPENDENCIES #####
if (!require("tidyverse")) {
    install.packages("tidyverse")
}
library(tidyverse)

if (!require("readr")) {
    install.packages("readr")
}
library(readr)

if (!require("stringr")) {
    install.packages("stringr")
}
library(stringr)

if (!require("leaflet")) {
    install.packages("leaflet")
}
library(leaflet)

if (!require("ggplot2")) {
    install.packages("ggplot2")
}
library(ggplot2)

##### UI #####

shinyUI(pageWithSidebar(

    # Application Title
    headerPanel("Explore Visa Statuses"),

    # Sidebar contains filters, which are the same regardless of visualization type.
    # Note that any radio elements will have `All` selected by default.
    # `All` will toggle every element; if at least one element is selected, All will make them all unselected.
    # If none are selected, then All will toggle every radio element to ON.
    sidebarPanel(
        # CASE_STATUS only has the following 4 values:
        #- Certified-Withdrawn
        #- Certified
        #- Withdrawn
        #- Denied
        # As such, this will be a radio element.
        radioButtons("CASE_STATUS", "Case Status",
                     c("All", "Certified-Withdrawn", "Certified", "Withdrawn", "Denied")),

        # There are many values for EMPLOYER_NAME, so this will be an autocomplete text field.
        selectizeInput("EMPLOYER_NAME", "Employer Name",
                       choices = visa$EMPLOYER_NAME,
                       options = list(maxItems = 1)),

        # Similarly, there are also many values for SOC_NAME. This will also be a text field.
        selectizeInput("SOC_NAME", "SOC Name",
                       choices = visa$SOC_NAME,
                       options = list(maxItems = 1)),

        # Another text field for JOB_TITLE
        selectizeInput("JOB_TITLE", "Job Title",
                       choices = visa$JOB_TITLE,
                       options = list(maxItems = 1)),

        # Full Time Position is either a yes or a no, so this is a 2-button radio section.
        radioButtons("FULL_TIME_POSITION", "Job Type",
                     c("All", "Full Time", "Part Time")),

        # PREVAILING_WAGE will be an inclusive slider.
        sliderInput("PREVAILING_WAGE", "Wage Range", min = MIN_WAGE,
                    max = MAX_WAGE, value = c(MIN_WAGE, MAX_WAGE)),

        # There are very few years that are unique in the dataset, so this will be an inclusive slider.
        sliderInput("YEAR", "Year Range", min = MIN_YEAR,
                    max = MAX_YEAR, value = c(MIN_YEAR, MAX_YEAR))
    )
))
