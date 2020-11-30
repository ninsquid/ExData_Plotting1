library(readr)
library(dplyr)
library(lubridate)

## Load Data and Specify Colnames
PwrCon <- read.table("household_power_consumption.txt", skip = 66637, nrows = 2880, header = FALSE, sep = ";",
                      dec = ".", 
                      strip.white = FALSE, na.strings = "?")
colnames(PwrCon) <- read.table("household_power_consumption.txt", nrows = 1, header = FALSE, sep=";")

## Change Data Format for $Date
PwrCon$Date <- dmy(PwrCon$Date)

## Open Graphic Device and Make Plot
png(file="plot1.png", width = 480, height = 480)
hist(PwrCon$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

## Check and Close Graphic Device
dev.cur()
dev.off()
