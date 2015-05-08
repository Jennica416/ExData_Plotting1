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

##make plot with sub metering 1-3 variables and create PNG
png(file="plot3.png", width = 480, height = 480, bg="white")

## Plot sub-metering_1 variable
par(mar=c(5,5,5,5))
with(dataAll, plot(timestamp, Sub_metering_1, type = "l", ylab ="Energy sub metering", xlab=""))
## Plot sub-metering_2 variable
par(new=TRUE)
with(dataAll, plot(timestamp, Sub_metering_2, type = "l", col="red", ylab ="", 
	axes=FALSE, xlab="", ylim = c(0,30)))
## Plot sub-metering_3 variable
par(new=TRUE)
with(dataAll, plot(timestamp, Sub_metering_3, type = "l", col="blue", ylab ="", 
	axes=FALSE, xlab="", ylim = c(0,40)))
## Create legend
legend("topright", lty=c(1,1,1), col=c("Black", "Red", "Blue"), cex = 0.75, 
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

## graph is stored in a file titled "plot3.png" in your working directory

