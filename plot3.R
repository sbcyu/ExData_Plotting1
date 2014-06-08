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
#http://www.packtpub.com/article/creating-line-graphs-r
# Define colors to be used for sub meter 1 , 2, 3
plot_colors <- c("black","red","blue")
ranges <- range(consumptionData$Sub_metering_1,
                consumptionData$Sub_metering_2,
                consumptionData$Sub_metering_3)
# Start PNG device driver to save output to figure.png
png("plot3.png", width=480, height=480)
plot(consumptionData$Time, consumptionData$Sub_metering_1,
     type="l", col=plot_colors[1],
     #xlab="", ylab="Energy sub metering", 
     xlab="", ylab="Energy sub metering"
     #, 
#     ylim=ranges,
 #    axes=FALSE, ann=FALSE, 
#     xaxt="n"
)

#axis(1, at=1:3 , lab=c("Thur", "Fri", "Sat"))
#axis.POSIXct(1, consumptionData$Time ,at=consumptionData$Time, labels=T)
#axis(2, las=1 ,at=c(0, 10, 20, 30))

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
dev.off()