##load necessary libraries
library(lubridate)

##loading the data
data <- read.table(file = "household_power_consumption.txt", header=TRUE, sep = ";", na.strings= c("?"))

## Converting Date column from a factor
## (character) to Date class
data$Date <- dmy(data$Date)

##subsetting data to include only 2007-02-01 and 2007-02-02
subData<-subset(data, data$Date > "2007-01-31" & data$Date <= "2007-02-02")

##create 1 time variable
timestamp<-as.POSIXct(strptime(paste(subData$Date, subData$Time), "%Y-%m-%d %H:%M:%S"))
dataAll <- cbind(subData, timestamp)

##make plot 2 and create PNG file
png(file="plot2.png", width = 480, height = 480, bg="white")
par(mar=c(5,5,5,5))
with(dataAll, plot(timestamp, Global_active_power, type = "l", ylab ="Global Active Power (kilowatts)", xlab=""))
dev.off()

## graph is stored in a file titled "plot2.png" in your working directory

