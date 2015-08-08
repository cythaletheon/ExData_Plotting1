##
## Get the required files
##
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("powerdata.zip")) {
  download.file(fileURL, destfile = "powerdata.zip", method = "wget")
}

if (!file.exists("household_power_consumption.txt")) {
  unzip("powerdata.zip")
}

rm(fileURL)