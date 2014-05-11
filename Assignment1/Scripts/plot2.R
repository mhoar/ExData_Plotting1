########  Get file data from file

setwd("~/Documents/R")
dataDir <- "./data/"

##### read all data, it's big...
# classes = c("Date", "Date", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
# epc.data <- read.table(paste(dataDir, "household_power_consumption.txt", sep=""), sep=";", header=TRUE, colClasses = classes, na.strings="?")
epc.data <- read.table(paste(dataDir, "household_power_consumption.txt", sep=""), sep=";", header=TRUE)

##### shrink data down by date (2/2007) values
epc.data <- epc.data[grepl("^1/2/2007|^2/2/2007", epc.data$Date), ]
#### format date in column 1
epc.data$Date <- as.Date(epc.data[ , 1], format="%d/%m/%Y")

#fixtime <- as.POSIXlt(epc.data[ , 2], format="%H:%M:%S")
epc.data$Time <- as.POSIXlt(epc.data[ , 2], format="%H:%M:%S")
names(epc.data)

epc.data$Global_active_power <- as.numeric(as.character(epc.data$Global_active_power))
epc.data$Global_reactive_power <- as.numeric(as.character(epc.data$Global_reactive_power))
epc.data$Voltage <- as.numeric(as.character(epc.data$Voltage))
epc.data$Sub_metering_1 <- as.numeric(as.character(epc.data$Sub_metering_1))
epc.data$Sub_metering_2 <- as.numeric(as.character(epc.data$Sub_metering_2))
epc.data$Sub_metering_3 <- as.numeric(as.character(epc.data$Sub_metering_3))

###############  Varible Description #####
##  Date: Date in format dd/mm/yyyy
##  Time: time in format hh:mm:ss
##  Global_active_power: household global minute-averaged active power (in kilowatt)
##  Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
##  Voltage: minute-averaged voltage (in volt)
##  Global_intensity: household global minute-averaged current intensity (in ampere)
##  Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
##  Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
##  Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
################

###### save original par settings
opar <- par() 

####plot 2
###### plot Global Active Power data by time from Thursday to Saturday  ####### Exported in RStudio
png(file = "plot2.png") ######## 480x480 by default
tstime <- ts(as.character(epc.data$Time))
with(epc.data, ts.plot(tstime, Global_active_power, gpars=list(xaxt='n', ann=FALSE, type="l")))
axis(1, labels=c("Thu", "Fri", "Sat"), at=c(0, 1440, 2880), cex.axis=.9)
title(ylab = "Global Active Power (kilowatts)")
dev.off()


######## restore par to original settings
par(opar)
