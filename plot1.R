##
## Plot 1
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
dataset$Time <- as.Date(dataset$Time, "%H:%M:%S")

## Generate histogram of global active power as a png file
png(filename = "plot1.png", width = 480, height = 480)
hist(dataset$Global_active_power, xlab="Global Active Power (kilowatts)", 
     col="red", main="Global Active Power")

## close the png device to save the image.
dev.off()

## cleanup
rm(dataset)
## end of file
################################################################################