setwd("~/Documents/Learning/Coursera/Exploratory Data Analysis/Week 01/Weekly Project/ExData_Plotting1/mySourceCode")
# To set the locale to English in Ubuntu
Sys.setlocale("LC_TIME", "C")

# Reading the raw data from a local file in my Working Directory
powerConsumptionData <- read.csv2("../../household_power_consumption.txt",sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

# Converting the first column to Date
powerConsumptionData$Date <- as.Date(powerConsumptionData$Date,"%d/%m/%Y")
# Filtering the data to have only the three days to explore
subPowerConsumptionData <- subset(powerConsumptionData, Date >= "2007-02-01" & Date <= "2007-02-03")
# Dropping the full read data set
rm(powerConsumptionData)
# Converting the Time column to POSIXlt
subPowerConsumptionData$Time <- strptime(paste(subPowerConsumptionData$Date,subPowerConsumptionData$Time, sep = " "),"%Y-%m-%d %H:%M:%S")
# Filtering the data to have only one measurement for Saturday Feb 3rd, 2007
subPowerConsumptionData <- subset(subPowerConsumptionData, Time <= "2007-02-03 00:00:00")

# Converting the rest of the columns to numeric
subPowerConsumptionData$Global_active_power <- as.numeric(subPowerConsumptionData$Global_active_power)
subPowerConsumptionData$Global_reactive_power <- as.numeric(subPowerConsumptionData$Global_reactive_power)
subPowerConsumptionData$Voltage <- as.numeric(subPowerConsumptionData$Voltage)
subPowerConsumptionData$Global_intensity <- as.numeric(subPowerConsumptionData$Global_intensity)
subPowerConsumptionData$Sub_metering_1 <- as.numeric(subPowerConsumptionData$Sub_metering_1)
subPowerConsumptionData$Sub_metering_2 <- as.numeric(subPowerConsumptionData$Sub_metering_2)
subPowerConsumptionData$Sub_metering_3 <- as.numeric(subPowerConsumptionData$Sub_metering_3)

####################################### Plot 4 #################################################

# Establishing the multiple frame dimensions
par(mfrow = c(2, 2), mar = c(4, 4, 2, 2), oma = c(2, 2, 2, 2))

# Creating the plots
with(subPowerConsumptionData,{
    # First Plot
    plot(Time,Global_active_power, type = "l", xlab= " ", ylab = "Global Active Power")
    # Second Plot
    plot(Time,Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
    # Third Plot
    plot(Time,Sub_metering_1, type = "l", xlab = " ", ylab = "Energy Sub metering")
    lines(Time,Sub_metering_2, type = "l", col = "red")
    lines(Time,Sub_metering_3, type = "l", col = "blue")
        # Annotating the legend for the Third Plot
    legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), lwd = c(2, 2, 2), col = c("black","red","blue"), cex = .3 , y.intersp = 0.2)
    # Fourth Plot
    plot(Time,Global_reactive_power, type = "l", xlab = "datetime")
})

# Copying the plot to a PNG file in its corresponding folder
dev.copy(png, file = "plot4.png", width = 480, height = 480)
# Closing the PNG device
dev.off()