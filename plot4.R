##
## Plot 4
##
## By Damon Grummet (cythaletheon)
## for Data Science - Exploratory Data Analysis, Assignment 1, August 2015.
##
library(data.table)
library(dplyr)

## used Vim to search the file for the starting row for 2007-02-01 and numrows
## to get to end of 2007-02-02:
## start:   66638
## end:     69518
## numrows:  2880
## 
## so skip first 66637 rows, then collect only 2880 rows.

dataset <- fread("household_power_consumption.txt", skip = 66637, nrows = 2880, 
                 na.strings = "?", header = FALSE)

## check that first row of head is 1/2/2007 00:00:00
head(dataset)

## check that last row of tail is 2/2/2007 23:59:00
tail(dataset)

## give names to columns
## first, read in header from data file
headernames <- fread("household_power_consumption.txt", nrows = 1, 
                     na.strings = "?", header = TRUE)

## now swap these into the dataset
setnames(dataset,names(headernames))

## we don't need the headernames anymore
rm(headernames)

## reformat date and time columns
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")
dataset$Time <- as.POSIXct(paste(dataset$Date,dataset$Time))

## Generate a png file
png(filename = "plot4.png", width = 480, height = 480)

## containing 4 charts (2x2) filling first column then second
par(mfcol = c(2,2))

## first chart is global active power by date/time
plot(dataset$Time, dataset$Global_active_power, type="l", xlab = "",
     ylab = "Global Active Power")

## second chart is energy sub metering over time
plot(dataset$Time, dataset$Sub_metering_1, type="l", xlab = "", 
     ylab = "Energy sub metering")
lines(dataset$Time, dataset$Sub_metering_2, col = "red")
lines(dataset$Time, dataset$Sub_metering_3, col = "blue")
legend("topright", lty = c(1,1), col = c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n", cex = 0.75)


## third chart is voltage over time
plot(dataset$Time, dataset$Voltage, type="l", xlab = "datetime",
     ylab = "Voltage")

## fourth chart is global reactive power over time
plot(dataset$Time, dataset$Global_reactive_power, type="l", xlab = "datetime",
     ylab = "Global_reactive_power")

## close the png device to save the image.
dev.off()

## cleanup
rm(dataset)
## end of file
################################################################################