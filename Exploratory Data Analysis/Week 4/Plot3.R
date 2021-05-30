
## - - - - - - - - Q U E S T I O N 3 - - - - - - - 
## A.   Of the 4 types of sources(point, nonpoint, onroad, nonroad), which of these have seen decrease in
##      emissions from 1999-2008 for Baltimore City?
## B.   Which of these types of sources have since increase in emissions from 1999-2008 in Baltimore City?

## - - - - - - - - A N S W E R - - - - - - - - - -
## The right code == APPROACH 2
## A.   Non-road, Nonpoint and On-road source type all showed decrease in emissions throughout the years 1999-2008
## B.   Point emissions showed an increase in emissions with the largest seen between 2002 and 2005 which was a
##      111.24% increase.


##  - - - - - - - - - - A P P R O A C H - - - - - - - - 
## i.   Subset out the needed data based on fips == "24510"
## ii.  Subset out the needed columns i.e. Year, Types of Sources, Emissions
## iii. Create a list of datasets based on the years and create a new dataset based on the each year: Types, Total emission and year
## iv.  Scatter plot using ggplot y~x; total emissions against year with different colors of pts reping the different types of sources

## This first line will likely take a few seconds. Be patient!
setwd("D:/Documents/R Programming/Data-Science-Coursera/Exploratory Data Analysis/Week 4")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting out the needed data based on fips = 24510
fips.24510 <- which(NEI$fips == "24510")
baltimore <- NEI[fips.24510, -c(1,2,3)]           ## Subsetting out the needed columns
row.names(baltimore) <- 1:length(baltimore$year)  ## Changing the rownames to something better (1:total no of rows)

## Converting from integer class to factor
baltimore$year <- as.factor(as.character(baltimore$year))  

## Getting rows of data for each year
row.1999 <- which(baltimore$year == "1999")
row.2002 <- which(baltimore$year == "2002")
row.2005 <- which(baltimore$year == "2005")
row.2008 <- which(baltimore$year == "2008")

## Subsetting the data based on each year
baltimore.1999 <- baltimore[row.1999,]; rownames(baltimore.1999) <- 1:length(baltimore.1999$year); 
baltimore.2002 <- baltimore[row.2002,]; rownames(baltimore.2002) <- 1:length(baltimore.2002$year)
baltimore.2005 <- baltimore[row.2005,]; rownames(baltimore.2005) <- 1:length(baltimore.2005$year)
baltimore.2008 <- baltimore[row.2008,]; rownames(baltimore.2008) <- 1:length(baltimore.2008$year)

## Joining them into one mega list
baltimore.years <- list(baltimore.1999 = baltimore.1999, baltimore.2002 = baltimore.2002, 
                        baltimore.2005= baltimore.2005, baltimore.2008 = baltimore.2008)

## Creating a list with total emission for each type for each year
for (x in baltimore.years) {
        if (x$year[1] == "1999") {
                baltimore.1999$type <- as.factor(baltimore.1999$type)
                type.source <- tapply(baltimore.1999$Emissions,baltimore.1999$type,sum)
                type.1999 <- data.frame(total.emissions = type.source, type = levels(baltimore.1999$type), year = rep(1999,4), row.names = NULL)
        } else if (x$year[1] == "2002"){
                baltimore.2002$type <- as.factor(baltimore.2002$type)
                type.source <- tapply(baltimore.2002$Emissions,baltimore.2002$type,sum)
                type.2002 <- data.frame(total.emissions = type.source, type = levels(baltimore.2002$type), year = rep(2002,4), row.names = NULL)
        } else if (x$year[1] == "2005"){
                baltimore.2005$type <- as.factor(baltimore.2005$type)
                type.source <- tapply(baltimore.2005$Emissions,baltimore.2005$type,sum)
                type.2005 <- data.frame(total.emissions = type.source, type = levels(baltimore.2005$type), year = rep(2005,4), row.names = NULL)
        } else {
                baltimore.2008$type <- as.factor(baltimore.2008$type)
                type.source <- tapply(baltimore.2008$Emissions,baltimore.2008$type,sum)
                type.2008 <- data.frame(total.emissions = type.source, type = levels(baltimore.2008$type), year = rep(2008,4), row.names = NULL)
        }
        baltimore.types <- list(type.1999 = type.1999, type.2002 = type.2002, type.2005 = type.2005, type.2008 = type.2008)
}


## - - - - - - - - - C O R R E C T I O N - - - - - - - - - - -

library(ggplot2)


## Subset NEI data by fips == 24510 {Baltimore City, Maryland}
baltimoreNEI <- NEI[NEI$fips=="24510",]
View(baltimoreNEI)

png("plot3.png")

ggplot(baltimoreNEI, aes(factor(year), Emissions, fill=type)) + geom_bar(stat="identity") +
        theme_bw() + guides(fill=FALSE) + facet_grid(.~type, scales="free",space="free") +
        labs(x="year", y=expression("Total PM"[2.5]*"Emission (Tons)")) +
        labs(title=expression("PM"[2.5]*"Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off
?dev.cur()
?geom_bar


#png("plot3.png", width=number.add.width, height=number.add.height)
# Group total NEI emissions per year:
baltcitymary.emissions.byyear<-summarise(group_by(filter(NEI, fips == "24510"), year,type), Emissions=sum(Emissions))
#clrs <- c("red", "green", "blue", "yellow")
ggplot(baltcitymary.emissions.byyear, aes(x=factor(year), y=Emissions, fill=type,label = round(Emissions,2))) +
        geom_bar(stat="identity") +
        #geom_bar(position = 'dodge')+
        facet_grid(. ~ type) +
        xlab("year") +
        ylab(expression("total PM"[2.5]*" emission in tons")) +
        ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                           "City by various source types", sep="")))+
        geom_label(aes(fill = type), colour = "white", fontface = "bold")

dev.off()


##  - - - - - - - - - - A P P R O A C H  2 - - - - - - - - 

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Y = Total emissions, X = Source Types, Facetted by year = .~Year

## COnverting categorical columns to factors
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

library(dplyr)
library(ggplot2)
fips.24510 <- filter(NEI, fips == "24510")
NEI.baltimore <- summarise(group_by(fips.24510,year,type), Emissions = sum(Emissions))

png("plot3.png")

ggplot(NEI.baltimore, aes(year, Emissions, fill = type,label=round(Emissions,2))) +
        theme_bw() + facet_grid(.~type) +
        geom_bar(stat = "identity") + 
        labs(y = expression("Total PM"[2.5]*" Emission (Tons)"), x = "Year") +
        labs(title = expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type")) +
        geom_label(aes(fill=type),colour="white",fontface="bold")

dev.off()

