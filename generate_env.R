library(tidyverse)  # Misc tidy data wrapper package.
library(tools)  # Only used for toTitleCase()
library(readr)

#rm(list = ls())

# Sarthak's path
#visas <- read_csv("/Users/SarthakKhillon/Desktop/DataScienceCourses/stat331/ShinyVisaExploration/visas_sk.csv")

# Christina's path
visas <- read_csv("../FinalProjectTemp/visas_sk.csv")

# Convert all SOC, and Job Title fields to Title Case.
# We leave Employers as all-caps because Company names vary greatly.
visas$SOC_NAME <- toTitleCase(tolower(visas$SOC_NAME))
visas$JOB_TITLE <- toTitleCase(tolower(visas$JOB_TITLE))

# Find the most common SOC
most.common.soc <- visas$SOC_NAME %>%
    table() %>%
    sort() %>%
    names() %>%
    tail(1)

# Finding wage and year bounds so we don't continuously have to calculate them
MIN.WAGE <- min(visas$PREVAILING_WAGE)
MAX.WAGE <- max(visas$PREVAILING_WAGE)

MIN.YEAR <- min(visas$YEAR)
MAX.YEAR <- max(visas$YEAR)

save.image("visa_info.RData")