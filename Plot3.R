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

### Plot #3
png(filename = "Plot3.png", width = 480, height = 480, units = "px")

with(mydata, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
        lines(mydata$DateTime, mydata$Sub_metering_2, col = "red")
        lines(mydata$DateTime, mydata$Sub_metering_3, col = "blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), 
                legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
dev.off()