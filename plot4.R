##load necessary libraries
library(lubridate)

##loading the data
data <- read.table(file = "household_power_consumption.txt", header=TRUE, sep = ";", na.strings= c("?"))

## Converting Date and Time columns from factors
## (character) to Date respectively
data$Date <- dmy(data$Date)

##subsetting data to include only 2007-02-01 and 2007-02-02
subData<-subset(data, data$Date > "2007-01-31" & data$Date <= "2007-02-02")

##create 1 time variable (includes Date and Time)
timestamp<-as.POSIXct(strptime(paste(subData$Date, subData$Time), "%Y-%m-%d %H:%M:%S"))
dataAll <- cbind(subData, timestamp)

##open PNG device
png(file="plot4.png", width = 480, height = 480, bg="white")

##Make first plot (Global Active Power Vs DateandTime)
par(mfrow=c(2,2))
par(mar =c(4,4,2,1))
with(dataAll, plot(timestamp, Global_active_power, type = "l", ylab ="Global Active Power", 
	xlab=""))

##make second plot (Voltage vs DateandTime)
with(dataAll, plot(timestamp, Voltage, type = "l", ylab ="Voltage", 
	xlab="datetime"))

##make third plot with sub metering 1-3 variables
with(dataAll, plot(timestamp, Sub_metering_1, type = "l", ylab ="Energy sub metering", xlab=""))
par(new=TRUE)
with(dataAll, plot(timestamp, Sub_metering_2, type = "l", col="red", ylab ="", 
	axes=FALSE, xlab="", ylim = c(0,30)))
par(new=TRUE)
with(dataAll, plot(timestamp, Sub_metering_3, type = "l", col="blue", ylab ="", 
	axes=FALSE, xlab="", ylim = c(0,40)))
legend("topright", lty=c(1,1,1), col=c("Black", "Red", "Blue"), cex = 0.75, bty="n",
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##make fourth plot (GLobal reactive power vs DateandTime)
with(dataAll, plot(timestamp, Global_reactive_power, type = "l", ylab ="Global_reactive_power", 
	xlab="datetime", ylim = c(0, 0.5)))

## turn off PNG file device
dev.off()

## graphs are stored in a file titled "plot4.png" in your working directory