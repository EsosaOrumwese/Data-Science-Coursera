png("plot4.png")
par(mfrow = c(2,2))

## Reading the entire data from txt file
energydata <- read.delim(file.choose(), header = TRUE, sep = ";", dec = ".")

## Subsetting required data
Feb_data <- subset(energydata, Date == "1/2/2007" | Date == "2/2/2007")

## Converting Date and time column to POSIXlt class
Feb_data$Date <- strptime(Feb_data$Date, "%d/%m/%Y")
Feb_data$Time <- strptime(Feb_data$Time, "%H:%M:%S")

Feb_data[1:1440, "Time"] <- format(Feb_data[1:1440, "Time"], "2007-02-01 %H:%M:%S")
Feb_data[1441:2880, "Time"] <- format(Feb_data[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

## Converting all columns to numeric
Feb_data$Global_active_power <- as.numeric(Feb_data$Global_active_power)
Feb_data$Global_reactive_power <- as.numeric(Feb_data$Global_reactive_power)
Feb_data$Voltage <- as.numeric(Feb_data$Voltage)
Feb_data$Sub_metering_1 <- as.numeric(Feb_data$Sub_metering_1)
Feb_data$Sub_metering_2 <- as.numeric(Feb_data$Sub_metering_2)
Feb_data$Sub_metering_3 <- as.numeric(Feb_data$Sub_metering_3)

## Plot A :- Global Active Power~Time (y~x)
with(Feb_data, plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power" ))

## Plot B :- Voltage~Time
with(Feb_data, plot(Time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))

## Plot C :- Energy sub-metering~Time
with(Feb_data, plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(Feb_data, lines(Time, Sub_metering_2, col = "red"))
with(Feb_data, lines(Time, Sub_metering_3, col = "blue"))

## Plot D :- Global Reactive Power~Time
with(Feb_data, plot(Time, Global_reactive_power, type = "l", xlab = "datetime", ylab = ""))
dev.off()
