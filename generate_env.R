library(tidyverse)
library(readr)
library(RColorBrewer)

visas <- read_csv("visas_sk.csv")

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
