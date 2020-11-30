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

## (Optional) Check Weekdays
PwrCon$Day <- weekdays(PwrCon$Date, abbreviate = TRUE)

## Merge Date and Time in POSIXct Format
PwrCon$Point <- ymd_hms(paste(PwrCon$Date, PwrCon$Time, sep=" "))

## Assign Variables
x <- PwrCon$Point
a <- PwrCon$Sub_metering_1
b <- PwrCon$Sub_metering_2
c <- PwrCon$Sub_metering_3

## Open Graphic Device and Make Plot
png(file="plot3.png", width = 480, height = 480)
par(mar=c(4,4,4,2))

plot(x, a, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x, b, type = "l", col = "red")
lines(x, c, type = "l", col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1)

## Check and Close Graphic Device
dev.cur()
dev.off()
