
##  - - - - - - - - - - Q U E S T I O N  5 - - - - - - - -
##  How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

##  - - - - - - - - - - A N S W E R - - - - - - - - - - -
##  There has been an overall 74.55% decrease in emissions from motor vehicles from between 1999 and 2008. The largest decline was seen between
##  1999 and 2002 and it was a 61.27% decrease. The least decline was between 2002 and which showed a 2.89% decrease.



## This first line will likely take a few seconds. Be patient!
setwd("D:/Documents/R Programming/Data-Science-Coursera/Exploratory Data Analysis/Week 4")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##  - - - - - - - - - - A P P R O A C H - - - - - - - - - -
##  I.  Get the SCC rows which match the motor vehicle emission
##  II. With those SCC rows, select their entire column from the NEI dataset
##  III.Filter out the data for Baltimore City (fips == "24510")
##  IV. Again create a barplot total PM2.5 emissions against year

## Getting the SCC rows needed ~ "on-road" from EI.Sector

#on.road.Related <- grepl("On-Road", SCC$EI.Sector, ignore.case = TRUE, fixed = TRUE)
on.road.Related <- SCC[which(SCC$Data.Category == "Onroad"),]
#On.road_rows <- which(on.road.Related == TRUE)

## Selecting the needed from NEI dataset
NEI.on.road <- NEI[NEI$SCC %in% on.road.Related$SCC,]

## Filter out the data for Baltimore City
library(dplyr)
library(ggplot2)
NEI.on.road_Baltimore <- filter(NEI.on.road, fips == "24510")
NEI.on.road_Baltimore$year <- as.factor(NEI.on.road_Baltimore$year)

## Create plot data
plot.data <- NEI.on.road_Baltimore %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

## Create barplot
png("plot5.png", width = 640)

ggplot(plot.data, aes(x=year, y=Emissions, fill=year, label=round(Emissions,2))) +
        theme_bw() + geom_bar(stat = "identity") +
        labs(x="Year", y=expression("Total PM"[2.5]*" Emissions in Tons")) +
        labs(title = expression("Total PM"[2.5]*" Emissions from Motor Vehicle Sources from 1999–2008 in Baltimore City, Maryland")) +
        geom_label(aes(fill=year), colour="white", fontface = "bold")

dev.off()





