## Reading the entire data from txt file
png("plot3.png")
energydata <- read.delim(file.choose(), header = TRUE, sep = ";", dec = ".")

## subsetting required data
Feb_data <- subset(energydata, Date == "1/2/2007" | Date == "2/2/2007")

## Converting Date and time column to POSIXlt class
Feb_data$Date <- strptime(Feb_data$Date, "%d/%m/%Y")
Feb_data$Time <- strptime(Feb_data$Time, "%H:%M:%S")

Feb_data[1:1440, "Time"] <- format(Feb_data[1:1440, "Time"], "2007-02-01 %H:%M:%S")
Feb_data[1441:2880, "Time"] <- format(Feb_data[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

## Converting sub_metering columns to numeric
Feb_data$Sub_metering_1 <- as.numeric(Feb_data$Sub_metering_1)
Feb_data$Sub_metering_2 <- as.numeric(Feb_data$Sub_metering_2)
Feb_data$Sub_metering_3 <- as.numeric(Feb_data$Sub_metering_3)

##Plotting data
with(Feb_data, plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(Feb_data, lines(Time, Sub_metering_2, col = "red"))
with(Feb_data, lines(Time, Sub_metering_3, col = "blue"))

## adding legends and title.
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main = "Energy sub-metering")
dev.off()