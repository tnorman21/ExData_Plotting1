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

png("plot2.png", width = 480, height = 480)
# Plotting code goes here
dev.off()

#Plot 2
png("plot2.png", width = 480, height = 480)
plot(data_subset$DateTime, data_subset$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()
