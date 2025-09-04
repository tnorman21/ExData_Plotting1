# Assuming each column is numeric (8 bytes per numeric)
rows <- 2075259
cols <- 9
memory_bytes <- rows * cols * 8
memory_mb <- memory_bytes / (1024^2)
memory_mb

library(data.table)

# Read full dataset as data.table (fast)
data <- fread("household_power_consumption.txt", na.strings = "?")

# Convert Date column to Date type
data[, Date := as.Date(Date, "%d/%m/%Y")]

# Subset only the required dates
data_subset <- data[Date %in% as.Date(c("2007-02-01", "2007-02-02"))]

# Combine Date and Time into a datetime column
data_subset[, DateTime := as.POSIXct(paste(Date, Time))]

png("plot4.png", width = 480, height = 480)
# Plotting code goes here
dev.off()

#Plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# 1st plot
plot(data_subset$DateTime, data_subset$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# 2nd plot
plot(data_subset$DateTime, data_subset$Voltage, type="l", xlab="datetime", ylab="Voltage")

# 3rd plot
plot(data_subset$DateTime, data_subset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data_subset$DateTime, data_subset$Sub_metering_2, col="red")
lines(data_subset$DateTime, data_subset$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty="n")

# 4th plot
plot(data_subset$DateTime, data_subset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()