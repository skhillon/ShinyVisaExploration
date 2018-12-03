library(tidyverse)
library(shiny)
#library(rsconnect)
#deployApp()
#To use different palettes in ggplot:
# for fills: 
#     + scale_fill_manual(values = <paletteName>)
# for lines and points: 
#     + scale_fill_manual(values = <paletteName>)
#making own palette:
# myPal <- c("#999999", "#E69F00", "#56B4E9", etc)

rawInput <- read_csv("h1b_kaggle.csv") %>%
   na.omit()

# Making sure that 1/<portion> of the values are from the last quarter of the data set

sampleSize <- 10
portion <- 4

data2<-rawInput[sample(nrow(rawInput)/portion, sampleSize/3) + nrow(rawInput)*(1-1/portion),]
data1<-rawInput[sample(nrow(rawInput)* (portion - 1)/portion, sampleSize*2/3),]

data <- rbind(data1, data2)
write.csv(data, file = "minVisas.csv", row.names = FALSE, fileEncoding = "UTF-8")