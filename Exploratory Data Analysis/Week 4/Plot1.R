
## - - - - - QUESTION 1 - - - - - -
## Have total emissions from PM2.5 decreased in the US from 1999 to 2008?

##  - - - - - - A N S W E R - - - - - - -
##  Yes, total emissions from PM2.5 have decreased by 52.76% across the US




## This first line will likely take a few seconds. Be patient!
setwd("D:/Documents/R Programming/Data-Science-Coursera/Exploratory Data Analysis/Week 4")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Produce a plot with ylim = range of emissions for all years, x val = total PM2.5 emissions for each year.

## 1. I need the total emissions for 1999, 2002, 2005 and 2008
##      a. I need a data frame with just 2 variables: total emission & year
##      b. Use base to plot Total emissions against year

NEI$year <- as.factor(NEI$year)   ##converting year column into a factor so that it can be used in tapply()
NEI_sum <- data.frame(year = levels(NEI$year), total_emissions = tapply(NEI$Emissions, NEI$year, sum))

png("plot1.png")

par(mfrow = c(1,1), mar = c(4,4,2,1))
x1 <- barplot(NEI_sum$total_emissions/1000, names.arg = NEI_sum$year, ylim = c(0,8000), col = c("red","green","yellow","blue"), 
        main = expression("Total Emissions of PM"[2.5]*" for All Years"))

## Adding labels to each bar
text(x=x1, y=round(NEI_sum$total_emissions/1000,2), label=round(NEI_sum$total_emissions/1000,2), 
     pos=3, cex=0.8, col="black")

?barplot

dev.off()

## - - - - - - TIPS - - - - - - - 
Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(Url, destfile = "./exdata-data-NEI_data.zip", method = "auto")

zipfile.data = "./exdata-data-NEI_data.zip"

## Making sure the data isn't in the working directory if not download the zip file.
if (file.exists(zipfile.data)) {
        unzip(zipfile = "./exdata-data-NEI_data.zip", exdir = getwd())
}

## Don't get the essence of its presence
path_rf <- file.path("./exdata-data-NEI_data")
files <- list.files(path_rf, recursive = TRUE)
files

## REading the National Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

## Total emissions per year
total.emissions <- summarise(group_by(NEI, year), Emissions = sum(Emissions))
clrs <- c("red","green","blue","yellow")

png("plot1.png")

## The Barplot
x1 <- barplot(height = total.emissions$Emissions/1000, names.arg=total.emissions$year, ylim = c(0,8000),
              main = expression('Total PM'[2.5]*' emissions at various years in kilotons'), col = clrs)

## Add text at top of bars
text(x=x1, y=round(total.emissions$Emissions/1000,2), labels = round(total.emissions$Emissions/1000,2),
     pos = 3, cex = 0.8, col = "black")


dev.off()










