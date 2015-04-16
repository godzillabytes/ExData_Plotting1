# read file
hpc_data = read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                    colClasses = c("character", "character", rep("numeric", 7)), 
                    nrow = 2075259)

# filter the lines of interest
hpc_data <- hpc_data[ which(hpc_data$Date=='1/2/2007' | hpc_data$Date=='2/2/2007'), ]

# make date and time into time stamp, remove them and re-order
hpc_data <- within(hpc_data, timestamp  <- as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))[,c(10,3:9)]

# set background color
par(bg="gray91")

# plot data
hist(hpc_data$Global_active_power,xlab="Global Active Power (kilowatts)", ylim=c(0,1200), col = "red", main="Global Active Power")

# sage to file
dev.copy(png,'plot1.png',width=654,height=654, units="px",res=72)
dev.off()