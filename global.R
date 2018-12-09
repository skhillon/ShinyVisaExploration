##############################
#   - App Title: Visa Exploration
#   - Authors: Sarthak Khillon, Juan Moreno, Christina Walden
##############################

library(tidyverse)  # Misc tidy data wrapper package.
library(readr)  # File IO
library(stringr)  # String processing.
library(leaflet)  # Map plotting.
library(ggplot2)  # Plotting.
library(shiny)  # Duh.
library(RColorBrewer)  # Color palette configuration.
library(shinyjs)  # To reset Shiny input elements.
library(scales)  # GGPlot axis formatting.

load("visas_and_models.RData")

# Set color palette.
statusPalette <- brewer.pal(9, "Set1")

# Global user input dataframe.
user_info_df <- data.frame(
    EMPLOYER_NAME = "",
    SOC_NAME = "",
    JOB_TITLE = "",
    FULL_TIME_POSITION = TRUE,
    YEAR = 2011,
    WORKSITE = "",
    lon = 25,
    lat = 25
)
