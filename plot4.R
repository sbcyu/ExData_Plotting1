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

#----------Generate all 4 plots----------
png("plot4.png", width=480, height=480)
# setup the layout for plot4.png
par(mfcol=c(2,2))

#plot all 4 plots
with( consumptionData, {
  #Plot 1
  plot(consumptionData$Time, consumptionData$Global_active_power, 
       xlab="", ylab = "Global Active Power",
       type="l", lwd=0.1)
  #Plot 2
  # Define colors to be used for sub meter 1 , 2, 3
  plot_colors <- c("black","red","blue")
  ranges <- range(consumptionData$Sub_metering_1,
                  consumptionData$Sub_metering_2,
                  consumptionData$Sub_metering_3)
  plot(consumptionData$Time, consumptionData$Sub_metering_1,
       type="l", col=plot_colors[1],
       xlab="", ylab="Energy sub metering"
  ) 
  box()
  lines(consumptionData$Time, consumptionData$Sub_metering_2,type="l",
        col=plot_colors[2])
  lines(consumptionData$Time, consumptionData$Sub_metering_3,type="l",
        col=plot_colors[3])
  
  legend("topright", 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lty=1,lwd=2,pch=21,
         cex=0.8, inset=0.01,
         col=plot_colors)
  #Plot 3
  plot(consumptionData$Time, consumptionData$Voltage, 
       xlab="datetime", ylab = "Voltage",
       type="l", lwd=0.1)
  #Plot 4
  plot(consumptionData$Time, consumptionData$Global_reactive_power, 
       xlab="datetime", ylab = "Global_reactive_power",
       type="l", lwd=0.1)
})

dev.off()