##  - - - - - - - - - - - - Q U E S T I O N  4 - - - - - - - - - -
## How have emissions from coal combustion-related sources changed from 1999–2008 across the US?

## - - - - - - - - - - - - - A N S W E R - - - - - - - - - 
## There has been a 39.97% decrease in coal combustion-related sources between 1999 and 2008 across the US. It was noticed that
## 1999 and 2005, the total emissions where similar, but in 2008, there was a noticeable drop in emissions.


## This first line will likely take a few seconds. Be patient!
setwd("D:/Documents/R Programming/Data-Science-Coursera/Exploratory Data Analysis/Week 4")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

## Using grepl to find rows with "comb" in EI.Sector column & "coal" in EI.Sector column
combustionRelated <- grepl("comb", SCC[,"EI.Sector"], ignore.case = TRUE)
coalRelated <- grepl("coal", SCC[,"EI.Sector"],ignore.case = TRUE)

coal.combus.rows <- which(combustionRelated & coalRelated == TRUE)

SCC.combustion <- SCC[coal.combus.rows, "SCC"]
NEI.combustion <- NEI[NEI[,"SCC"] %in% SCC.combustion,]

str(NEI.combustion)

## Change categorical columns into factors
NEI.combustion$year <- as.factor(NEI.combustion$year)

## Get a dataframe to plot
plot.data <- NEI.combustion %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

png("plot4.png", width = 640)

## Using ggplot
ggplot(plot.data, aes(x=year, y=Emissions/1000, fill=year, label=round(Emissions/1000,2))) + 
        geom_bar(stat = "identity") + labs(x="Year", y=expression("Total PM"[2.5]*" Emissions in Tons (*1000)")) +
        geom_label(aes(fill=year),colour="white",fontface="bold") +
        labs(title = expression("Total PM"[2.5]*" Emissions from Coal Combustion-Related Sources from 1999–2008 Across the US"))

dev.off()       
                                                         


