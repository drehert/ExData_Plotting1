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

##Plot2

par(mar = c(5, 5, 5, 5))

plot(hpcFeb$Date_Time, hpcFeb$Global_active_power, type="l",xlab="", ylab="Global Active Power (kilowatts)")

##Save as PNG

dev.copy(png, file="plot2.png", height=480, width=480)

dev.off()