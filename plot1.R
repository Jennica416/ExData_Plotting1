##load necessary library
library(lubridate)

##loading the data
data <- read.table(file = "household_power_consumption.txt", header=TRUE, sep = ";", na.strings= c("?"))

## Converting Date and Time columns from factors
## (character) to Date and Time respectively
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

##subsetting data to include only 2007-02-01 and 2007-02-02
subData<-subset(data, data$Date > "2007-01-31" & data$Date <= "2007-02-02")

##make plot 1 and save it as a PNG file in your working directory
png(file="plot1.png", width = 480, height = 480, bg="white")
hist(subData$Global_active_power, col="red", main="Global Active Power", xlab ="Global Active 
Power (kilowatts)", ylab="Frequency")
dev.off()

## graph is stored in a file titled "plot1.png" in your working directory