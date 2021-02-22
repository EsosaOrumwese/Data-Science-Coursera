## Reading the entire data from txt file
png("plot2.png")
energydata <- read.delim(file.choose(), header = TRUE, sep = ";", dec = ".")

## subsetting required data
Feb_data <- subset(energydata, Date == "1/2/2007" | Date == "2/2/2007")

## Converting Date and time column to POSIXlt class
Feb_data$Date <- strptime(Feb_data$Date, "%d/%m/%Y")
Feb_data$Time <- strptime(Feb_data$Time, "%H:%M:%S")
Feb_data[1:1440, "Time"] <- format(Feb_data[1:1440, "Time"], "2007-02-01 %H:%M:%S")
Feb_data[1441:2880, "Time"] <- format(Feb_data[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

## Converting Global_active_power values to numeric
Feb_data$Global_active_power <- as.numeric(Feb_data$Global_active_power)

## Plotting graph
with(Feb_data, plot(Time, Global_active_power, type = "l" ))
dev.off()
