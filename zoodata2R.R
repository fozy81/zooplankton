
# setwd("/home/tim/R/Riverfly") # set working directory - this is where the Riverfly excel files

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
Data <- melt(myData2, id = "X.1")
dcast(Data, Johnstons.Point ~ X.12)
Data$Location <- Johnston Point ## cheat - needs work
write.csv(Data, "data.csv")
