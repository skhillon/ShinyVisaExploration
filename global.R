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

if (!require("shiny")) {
    install.packages("shiny")
}
library(shiny)

if (!require("RColorBrewer")) {
   install.packages("RColorBrewer")
}
library(RColorBrewer)

visas <- read_csv("visas_sk.csv")
#visas <- read_csv("minVisas.csv")

#most.common.soc <- tail(names(sort(table(visas$SOC_NAME))), 1)
most.common.soc <- visas$SOC_NAME %>%
   toupper() %>%
   table() %>% 
   sort() %>%
   names() %>%
   tail(1)

MIN.WAGE <- min(visas$PREVAILING_WAGE)
MAX.WAGE <- max(visas$PREVAILING_WAGE)

MIN.YEAR <- min(visas$YEAR)
MAX.YEAR <- max(visas$YEAR)

statusPalette <- brewer.pal(4, "Set1")
