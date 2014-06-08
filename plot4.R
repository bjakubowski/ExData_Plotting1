### First, read in the data from the .txt file. Then subset by the two dates (read in as day/month/year)
### with no leading "0"s on dates. Then rbind the two target dates to obtain the desired data set.

energydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses= c("character","character", rep("numeric",7))) 
day1 <- energydata[energydata$Date=="1/2/2007",]
day2<- energydata[energydata$Date=="2/2/2007",]
target <- rbind(day1, day2)

### Now convert the "Date" column to a Date class column.

targetdates <- cbind(as.Date(target[,1], format = "%d/%m/%Y"),target[,2:9])

### Now use strptime to combine the proper date variable and time using the paste function.

datetime <- strptime(paste(targetdates[,1],targetdates[,2], sep = " "), format = "%Y-%m-%d %H:%M:%S")
finaldata <- cbind(datetime, target[,3:9])

### Now make png output four plots.

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
## first plot
plot(finaldata$Global_active_power ~ finaldata$datetime, type = "n", xlab = NA, ylab= "Global Active Power (kilowatts)")
lines(finaldata$datetime,finaldata$Global_active_power)

## second plot
plot(finaldata$Voltage ~ finaldata$datetime, type = "n", xlab = "datetime", ylab= "Voltage")
lines(finaldata$datetime,finaldata$Voltage)

## third plot
plot(finaldata$Sub_metering_1 ~ finaldata$datetime, type = "n", xlab = NA, ylab= "Energy sub metering")
lines(finaldata$datetime,finaldata$Sub_metering_1, col = "black")
lines(finaldata$datetime,finaldata$Sub_metering_2, col = "red")
lines(finaldata$datetime,finaldata$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1, bty = "n")

## fourth plot
plot(finaldata$Global_reactive_power ~ finaldata$datetime, type = "n", xlab = "datetime", ylab= "Global_reactive_power")
lines(finaldata$datetime,finaldata$Global_reactive_power)

dev.off()
