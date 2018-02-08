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

### Plot #2
png(filename = "Plot2.png", width = 480, height = 480, units = "px")
with(mydata, plot(DateTime, Global_active_power, type = "l", xlab = "",
                  ylab = "Global Active Power (Kilowatts)"))
dev.off()