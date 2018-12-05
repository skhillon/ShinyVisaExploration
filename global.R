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

load("visas_and_models.RData")

# Set color palette.
statusPalette <- brewer.pal(9, "Set1")

