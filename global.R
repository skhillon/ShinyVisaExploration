##############################
#   - App Title: Visa Exploration
#   - Authors: Sarthak Khillon, Juan Moreno, Christina Walden
##############################

library(tidyverse)
library(readr)
library(stringr)
library(leaflet)
library(ggplot2)
library(shiny)
library(RColorBrewer)
library(tools)

load("visa_info.RData")

# Convert all SOC, and Job Title fields to Title Case.
# We leave Employers as all-caps because Company names vary greatly.
visas$SOC_NAME <- toTitleCase(tolower(visas$SOC_NAME))
visas$JOB_TITLE <- toTitleCase(tolower(visas$JOB_TITLE))

# Set color palette.
statusPalette <- brewer.pal(9, "Set1")
