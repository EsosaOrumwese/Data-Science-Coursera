##Opening PNG device
png("./plot1.png")

## Reading the entire data from txt file
energydata <- read.delim(file.choose(), header = TRUE, sep = ";", dec = ".")

## subsetting required data
Feb_data <- subset(energydata, Date == "1/2/2007" | Date == "2/2/2007")

## Converting Date and time column to POSIXlt class
Feb_data$Date <- strptime(Feb_data$Date, "%d/%m/%Y")
Feb_data$Time <- strptime(Feb_data$Time, "%H:%M:%S")

## Converting Global_active_power values to numeric
Feb_data$Global_active_power <- as.numeric(Feb_data$Global_active_power)

## Plotting histogram
hist(Feb_data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
