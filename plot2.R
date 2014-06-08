#Read the text file
#2007-02-01 starts at line 66638 in the text file
#2007-02-02 ends at line 69517 in the text file
fileName <- "household_power_consumption.txt"
colHeaders <- c("Date","Time","Global_active_power","Global_reactive_power",
                "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                "Sub_metering_3")
columnType <- c("character", "character", "numeric", "numeric", "numeric", 
                "numeric", "numeric", "numeric", "numeric")
consumptionData <- read.csv( fileName, 
                             sep = ";", dec = ".",
                             col.names = colHeaders,
                             colClasses = columnType,
                             nrows = 2880, skip = 66636)

#Transform the Date and Time column from character into 
#Date/Time classes in R using the strptime() and as.Date() functions.
consumptionData$Date <- as.Date(consumptionData$Date, format="%d/%m/%Y")
consumptionData$Time <- strptime(paste(consumptionData$Date ,consumptionData$Time),
                                 format="%Y-%m-%d %H:%M:%S")

#GENERATE the LINE GRAPH
png("plot2.png", width=480, height=480)
plot(consumptionData$Time, consumptionData$Global_active_power, 
     xlab="", ylab = "Global Active Power (Kilowatts)",
     type="l" )
dev.off()