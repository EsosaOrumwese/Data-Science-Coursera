## - - - - - QUESTION 2 - - - - - -
## Have total emissions from PM2.5 decreased in Baltimore City, Maryland ever since?

##  - - - - - - - A N S W E R - - - - - - - - - - -
##  Yes, there has been a 43.12% decrease in total emissions between 1999 and 2008. There was a 25.98% increase in emission was between 2002 and 2005.


## This first line will likely take a few seconds. Be patient!
setwd("D:/Documents/R Programming/Data-Science-Coursera/Exploratory Data Analysis/Week 4")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##      1. Select rows which contain data for fips == "24510"
##      2. Create new data frame with year & total emissions
##      3. Create barplot with total emissions/1000 as the height, different colors, main = "Title", name.arg = levels(of year column)


## Selecting the rows which contain data for fips == "24510"
baltimore <- which(NEI$fips == "24510")
NEI.baltimore <- NEI[baltimore,]

## Creating the data frame with the important columns
NEI.baltimore$year <- as.factor(as.character(NEI.baltimore$year))
NEI.totalemission.balt <- data.frame(year = levels(NEI.baltimore$year), 
                                     total.emissions = tapply(NEI.baltimore$Emissions, NEI.baltimore$year,sum), row.names = NULL)

png("plot2.png")

## Creating the barplot
x2 <- barplot(NEI.totalemission.balt$total.emissions, ylim = c(0,4000), names.arg = NEI.totalemission.balt$year,
        main = expression("Total PM"[2.5]*" Emissions in Baltimore City, Maryland"), col = c("red","blue","yellow","green"))

## Adding text (labels) to top of bars
text(x = x2, y = round(NEI.totalemission.balt$total.emissions,2), labels = round(NEI.totalemission.balt$total.emissions,2),
     pos = 3, cex = 0.8, col = "black")

dev.off()
