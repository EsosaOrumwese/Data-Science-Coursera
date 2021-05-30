##  - - - - - - - - - - Q U E S T I O N  6 - - - - - - - -
##  Between Los Angeles County & Baltimore City, which city has seen greater changes over time in motor vehicle emissions?

##  - - - - - - - - - - A N S W E R - - - - - - - - - - 
##  First and foremost, it was worth noting that the total emissions in Los Angeles far exceed that of Baltimore City. Further more,
##  It is Baltimore City that has seen a greater change being that there is a recorded 74.55% decrease between 1999 and 2008



## This first line will likely take a few seconds. Be patient!
setwd("D:/Documents/R Programming/Data-Science-Coursera/Exploratory Data Analysis/Week 4")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##  - - - - - - - - - - A P P R O A C H - - - - - - - - - -
##  I.  Get the SCC rows which match the motor vehicle emission
##  II. With those SCC rows, select their entire column from the NEI dataset
##  III.Filter out the data for Baltimore City (fips == "24510" & "06037")
##  IV. Again create a barplot total PM2.5 emissions against year and facet between the two fips

on.road.Related <- SCC[which(SCC$Data.Category == "Onroad"),]

## Selecting the needed from NEI dataset
NEI.on.road <- NEI[NEI$SCC %in% on.road.Related$SCC,]

## Filter out the data for Baltimore City
library(dplyr)
NEI.on.road <- filter(NEI.on.road, fips == "24510"|fips == "06037")
NEI.on.road$year <- as.factor(NEI.on.road$year)
NEI.on.road$fips <- as.factor(NEI.on.road$fips)

## Create plot data
plot.data <- NEI.on.road %>% group_by(fips,year) %>% summarise(Emissions = sum(Emissions))

baltimore.on.road <- filter(plot.data, fips == "24510")
baltimore.on.road$County <- "Baltimore City, MD"
losangeles.on.road <- filter(plot.data, fips == "06037")
losangeles.on.road$County <- "Los Angeles County, CA"
both.on.road <- rbind(baltimore.on.road, losangeles.on.road)
both.on.road$fips <- NULL

## Create barplot
png("plot6.png")

library(ggplot2)
ggplot(both.on.road, aes(x=year, y=Emissions, fill=County, label=round(Emissions,2))) +
        theme_bw() + geom_bar(stat = "identity") + facet_grid(County~., scales="free") +
        labs(x="Year", y=expression("Total PM"[2.5]*" Emissions in Tons")) +
        labs(title = expression("Motor vehicle emission variation in Baltimore and Los Angeles in tons")) +
        geom_label(aes(fill = County), colour = "white", fontface = "bold")

dev.off()



















