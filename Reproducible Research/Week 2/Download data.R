setwd("D:/Documents/R Programming/Data-Science-Coursera/Reproducible Research/Week 2")

## Downloading data and unziping archive
Url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(Url, paste(getwd(),"dataFiles.zip",sep = "/"))
unzip(zipfile = "dataFiles.zip")
