### Download file, load into R-studio, then subset

library(lubridate); library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fp <- file.path(getwd(), "./data/data1.zip")
download.file(fileUrl, fp)

unzip("./data/data1.zip", exdir = "./data" )

file <- "./data/household_power_consumption.txt"
alldata <- fread(file, na.strings = "?")
mydata <- alldata %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

mydata$Date <- dmy(mydata$Date)
mydata$DateTime <- strptime(paste(mydata$Date, mydata$Time), format = "%F %T")

### Plot #4
png(filename = "Plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(mydata, {
        plot(DateTime, Global_active_power, type = "l", xlab = "",
             ylab = "Global Active Power")
        
        plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        
        plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(mydata$DateTime, mydata$Sub_metering_2, col = "red")
        lines(mydata$DateTime, mydata$Sub_metering_3, col = "blue")
        legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
        plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")
        
})
dev.off()