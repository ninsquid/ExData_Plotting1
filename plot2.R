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
y <- PwrCon$Global_active_power

## Open Graphic Device and Make Plot
png(file="plot2.png", width = 480, height = 480)
par(mar=c(4,4,4,2))
plot(x, y, type = "l", lty = 1, xlab = "", ylab = "Global Active Power (kilowatts)")

## Check and Close Graphic Device
dev.cur()
dev.off()
