
library(reshape2)
library(ggplot2)

#### Get list of excel files from directory and sub-directories

files  <- list.files(pattern ='\\.csv$', full.names = T, recursive = F)

# get a list of file names + the 'full.names' which means

# it has the directory + file name. Recursive = T - means it goes into all sub-directories/folders that are in our working directory.

filesList <- list(files)

# make files object into a list rather than a string of characters

All <- lapply(files,function(i){
  
  read.csv(i)
  
})
# funtion to read excel data into R - the data is in a 'list' of 'dataframes' - 'lapply' applies read.xls function to list of files
myData2 <- All
data <- melt(myData2, id = "X.1")
data <- data[data$value != "",]
data$family <- data$value
date <- data[data$X.1 == "Month",]
depth <- data[data$X.1 == "Depth",]
multi <- data[data$X.1 == "Sub-sample multiplier",]
data2 <- merge(data, date, by.x = "variable", by.y="variable")
data2$date <- data2$value.y
data2$value.y <- NULL
data2 <- merge(data2, depth, by.x = "variable", by.y="variable")
data2$depth <- data2$value.x
data2$value.y <- NULL
data2 <- merge(data2, multi, by.x = "variable", by.y="variable")
data2$multi <- data2$value.y
data2$value.y <- NULL
data3 <- data.frame(c(data2$date, data2$X.1.x,data2$multi,data2$value.x))
data3 <- data2[,c("date","X.1.x","multi","value.x")]

dataA <- melt(myData2, id = "X")
dataA <- dataA[dataA$value != "",]
dataA <- dataA[dataA$variable == "X.1",]
data3 <- merge(data3, dataA, by.x = "X.1.x", by.y="value" )
data3 <- data3[data3$X.1.x != "Month" | data3$X.1.x != "Depth" | data3$X.1.x != "Sub-sample multiplier",]

data3$value.x <- as.numeric(data3$value.x)

qplot(data3$date, data3$value.x, color=data3$X)

write.csv(data3, "zooDataFormatted.csv")
