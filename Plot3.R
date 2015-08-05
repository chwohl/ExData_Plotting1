# load package sqldf, graphics and grDevices
library(sqldf)
library(graphics)
library(grDevices)

# read subset of data (for 1/2/2007 and 2/2/2007)
hec12<-read.csv.sql("household_power_consumption.txt", sql = 'select * from file where "Date" = "1/2/2007"', sep = ";")
hec22<-read.csv.sql("household_power_consumption.txt", sql = 'select * from file where "Date" = "2/2/2007"', sep = ";")

# combine tables to one
hec<-rbind(hec12, hec22)

# convert row "Time" to POSIX, combining columns "Date" and "Time"
hec$Time<-strptime(paste(hec$Date, hec$Time), format="%d/%m/%Y %H:%M")

# create file
png(file="Plot3.png")

# create plot in file
plot(hec$Sub_metering_1, type="l", col="black", main="", xlab="", ylab="Energy sub metering", xaxt="n")
lines(hec$Sub_metering_2, type="l", col="red")
lines(hec$Sub_metering_3, type="l", col="blue")

# add axis ticks and labels separately (for non-English locale)
axis(1, at=c(1, 1440, 2880), labels=c("Thu", "Fri", "Sat"))

# add legend
legend("topright", lty=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
