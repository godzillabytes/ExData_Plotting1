

# read file
hpc_data = read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                    colClasses = c("character", "character", rep("numeric", 7)), 
                    nrow = 2075259)

# filter the lines of interest
hpc_data <- hpc_data[ which(hpc_data$Date=='1/2/2007' | hpc_data$Date=='2/2/2007'), ]

# make date and time into time stamp, remove them and re-order
hpc_data <- within(hpc_data, timestamp  <- as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))[,c(10,3:9)]

# 2 x 2 plots and setting background color
par(mfrow=c(2,2), bg="gray91")

# top left
plot(hpc_data$Global_active_power ~ hpc_data$timestamp,type="l",lwd=2, xlab="", ylab="Global Active Power (kilowatts)")
# top right
plot(hpc_data$Voltage ~ hpc_data$timestamp,type="l",lwd=2, ylab="Voltage", xlab = "datetime")
# lower left
plot(hpc_data$Sub_metering_1 ~ hpc_data$timestamp,type="l", col="black", lwd=2, xlab="", ylab="Energy sub-metering")
lines(hpc_data$Sub_metering_2 ~ hpc_data$timestamp, col="red",type="l",lwd=2)
lines(hpc_data$Sub_metering_3 ~ hpc_data$timestamp, col="blue",type="l",lwd=2)
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black", "red", "blue"), lty=1, lwd=1, bty = "n")
# lower right
plot(hpc_data$Global_reactive_power ~ hpc_data$timestamp,type="l",lwd=2, ylab="Global_reactive_power", xlab = "datetime")

# sage to file
dev.copy(png,'plot4.png',width=654,height=654, units="px",res=72)
dev.off()