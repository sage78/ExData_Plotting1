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

# plot Global_active_power over timestamp and save to plot2.png
png(filename = "plot2.png", 
    width = 480, 
    height = 480, 
    units = "px", 
    pointsize = 12, 
    bg = "white")

plot(data$Timestamp, 
     data$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

dev.off()
