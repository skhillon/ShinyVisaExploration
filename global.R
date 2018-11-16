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

visas <- read_csv("visas.csv")

MIN.WAGE <- min(visas$PREVAILING_WAGE)
MAX.WAGE <- max(visas$PREVAILING_WAGE)

MIN.YEAR <- min(visas$YEAR)
MAX.YEAR <- max(visas$YEAR)
