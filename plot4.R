# required libraries
library(grDevices)

# make sure that locale does not cause issues
Sys.setlocale("LC_TIME", "English")

#if not already done, download dataset and unzip it
if( !file.exists("household_power_consumption.txt")) {
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
			"data.zip", 
			mode="wb")

    unzip("data.zip")
}

# read data in
data <- read.table("household_power_consumption.txt", 
			 header=TRUE, 
			 sep = ";", 
			 na.strings = "?", 
			 colClasses=c("character","character","numeric","numeric",
					  "numeric","numeric","numeric","numeric",
					  "numeric"))

# add timestamp column
data$Timestamp <- paste(data$Date, data$Time)

# convert date column from character to date
# convert timestamp column from character to timestamp
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Timestamp <- strptime(data$Timestamp, "%d/%m/%Y %H:%M:%S")

# limit data between 2007-02-01 and 2007-02-02
data <- subset(data, data$Date >= as.Date("01/02/2007", "%d/%m/%Y") & 
			   data$Date <= as.Date("02/02/2007", "%d/%m/%Y"))

# plot 4 images to plot4.png in total, in 2x2 matrix 
png(filename = "plot4.png", 
    width = 480, 
    height = 480, 
    units = "px", 
    pointsize = 12, 
    bg = "white")
par(mfrow=c(2,2))

# plot Global_active_power over timestamps
plot(data$Timestamp, 
     data$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power")

# plot Voltage over timestamps
plot(data$Timestamp, 
     data$Voltage, 
     type="l", 
     xlab="datetime", 
     ylab="Voltage")

# plot sub metering data (3 sepearate graphs) with legend
plot(data$Timestamp, 
     data$Sub_metering_1, 
     type="n", 
     xlab="", 
     ylab="Energy sub metering")
points(data$Timestamp, data$Sub_metering_1, type="l", col="black")
points(data$Timestamp, data$Sub_metering_2, type="l", col="red")
points(data$Timestamp, data$Sub_metering_3, type="l", col="blue")
legend("topright", 
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty="solid", 
       bty = "n")

# plot Global_reactive_power over timestamps
plot(data$Timestamp, 
     data$Global_reactive_power, 
     type="l", 
     xlab="datetime", 
     ylab="Global_reactive_power")

# close file
dev.off()