
# Set the working directory to where the data will be downloaded
setwd("~/Downloads/")

## Download the zipped data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="exdata-data-household_power_consumption.zip")
# Go to the downloads folder and unzip the file there

# Load libraries usefule for reading in large data tables e.g. 
library(dplyr)
library(data.table)

# Read the data and convert it back to data.frame (easy to subset etc)
mydata <- fread("household_power_consumption.txt", na.strings="?")
mydata <- as.data.frame(mydata)
dim(mydata)
#	[1] 2075259       9

# Convert the data and time columns from the column class to appropriate classes
mydata$datetime <- with(mydata, paste(Date, Time))
mydata$datetime <- strptime(mydata$datetime, format = "%d/%m/%Y %H:%M:%S")
mydata$Date <-  as.Date(mydata$Date, format = "%d/%m/%Y")

mysubsetdata <- subset(mydata, (Date >= "2007-02-01" & Date <= "2007-02-02"))
dim(mysubsetdata)
# [1] 2880    10


### plot 2
png(file = "plot2.png", width = 480, height = 480, units = "px")
with(mysubsetdata, plot(datetime, Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)"))
with(mysubsetdata, lines(datetime, Global_active_power))
dev.off()

