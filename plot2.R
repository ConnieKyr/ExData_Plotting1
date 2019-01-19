#!/usr/bin/env Rscript

library(readr)
library(stringr)
library(lubridate)
library(dplyr)


# Reading in the data assuming they're in the working directory
power <- read_csv2( "household_power_consumption.txt")

#conversion of the Date column to date class
power$Date <- dmy(power$Date)

#filtering the desired timeframe
pwr <- power %>% filter( Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02") )

#various column conversions needed
pwr$Global_active_power<-as.numeric(pwr$Global_active_power)
pwr$Global_reactive_power<-as.numeric(pwr$Global_reactive_power)
pwr$Global_intensity<-as.numeric(pwr$Global_intensity)
pwr$Sub_metering_1<-as.numeric(pwr$Sub_metering_1)
pwr$Sub_metering_2<-as.numeric(pwr$Sub_metering_2)
pwr$Sub_metering_3<-as.numeric(pwr$Sub_metering_3)

#changing ? values to NA in Voltage column
pwr[pwr$Voltage == "?"] <- NA
pwr$Voltage<-as.numeric(pwr$Voltage)

#making a datetime column
pwr$Datetime<-as.POSIXct(paste(pwr$Date, pwr$Time), format="%Y-%m-%d %H:%M:%S")

#plotting
png("plot2.png", width = 480, height = 480)
plot(pwr$Datetime,pwr$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)",main="")
dev.off()
