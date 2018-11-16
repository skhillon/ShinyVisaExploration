rawInput <- read_csv("h1b_kaggle.csv") %>%
   na.omit()

# Making sure that 1/3 of the values are from the last quarter of the data set

sampleSize <- 100000
portion <- 4

data2<-rawInput[sample(nrow(rawInput)/portion, sampleSize/3) + nrow(rawInput)*(1-1/portion),]
data1<-rawInput[sample(nrow(rawInput)* (portion - 1)/portion, sampleSize*2/3),]

data <- rbind(data1, data2)
write.csv(data, file = "sampledVisas.csv")