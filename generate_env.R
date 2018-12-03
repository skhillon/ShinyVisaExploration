library(tidyverse)
library(readr)
library(RColorBrewer)

visas <- read_csv("/Users/SarthakKhillon/Desktop/DataScienceCourses/stat331/ShinyVisaExploration/visas_sk.csv")

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

