
library(ggplot2)
library(tidyverse)

data<-read_csv("h1b_kaggle.csv")

# only 1 submission per group but all group names should be on it

data %>%
   filter(data$X1 %in% sample(nrow(data), 100000)) %>%
   ggplot(aes_string(y = "PREVAILING_WAGE", x = "YEAR")) +
   geom_point()

data %>% filter(data$PREVAILING_WAGE >= 1000000) %>%
   filter(CASE_STATUS == "CERTIFIED") %>%
   select(wage = PREVAILING_WAGE, jobTitle = JOB_TITLE)

data %>% 
   filter(data$PREVAILING_WAGE >= 1000000000) 
#ggplot(aes(x=CASE_STATUS)) + 
#geom_bar()