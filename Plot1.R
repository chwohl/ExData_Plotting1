# load package sqldf, graphics and grDevices
library(sqldf)
library(graphics)
library(grDevices)

# read subset of data (for 1/2/2007 and 2/2/2007)
hec12<-read.csv.sql("household_power_consumption.txt", sql = 'select * from file where "Date" = "1/2/2007"', sep = ";")
hec22<-read.csv.sql("household_power_consumption.txt", sql = 'select * from file where "Date" = "2/2/2007"', sep = ";")

# combine tables to one
hec<-rbind(hec12, hec22)

# create file
png(file="Plot1.png")

# create plot in file
hist(hec$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()
