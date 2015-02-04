##Download & Unzip

url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

file <- "~/Coursera/household_power_consumption.zip"

download.file(url = url, destfile = file)

unzip(zipfile = file)

##Read into R

hpc <- read.csv("~/Coursera/household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

##Read dates as dates

hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")

##Subset to Feb 1st & 2nd

hpcFeb <- hpc[hpc$Date=="2007-02-01" | hpc$Date=="2007-02-02",]

##Combine Dates and Times

hpcFeb$Date_Time <- paste(hpcFeb$Date, hpcFeb$Time)

hpcFeb$Date_Time <- strptime(hpcFeb$Date_Time, format="%Y-%m-%d %H:%M:%S")

##Make the Sub_metering, global active power, and voltage variables numeric

for(i in 3:9) hpcFeb[,i] <- as.numeric(hpcFeb[,i])

##Plot4

par(mfcol=c(2,2))

##Top Left

plot(hpcFeb$Date_Time, hpcFeb$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=NA)

##Bottom Left

plot(hpcFeb$Date_Time, hpcFeb$Sub_metering_1,type="l",ylab="Energy sub metering",xlab=NA,col="black")

lines(hpcFeb$Date_Time, hpcFeb$Sub_metering_2, col="red")

lines(hpcFeb$Date_Time, hpcFeb$Sub_metering_3, col="blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")


##Top Right

plot(hpcFeb$Date_Time, hpcFeb$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Bottom Right

plot(hpcFeb$Date_Time, hpcFeb$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

##Save as PNG

dev.copy(png, file="plot4.png", height=480, width=480)

dev.off()