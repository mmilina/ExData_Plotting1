# Reading and subsetting data
data <- read.table(file = "/Users/maria.milina/Documents/Courses/Course_4/Week_1/household_power_consumption.txt", skip=1,sep=";")
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
sub_data <- subset(data,data$Date == "1/2/2007" | data$Date == "2/2/2007")

# Plot 4

# produce a PNG file with a width of 480 pixels and a height of 480 pixels
png("plot4.png", width=480, height=480)

# Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
sub_data$Date <- as.Date(sub_data$Date, format="%d/%m/%Y")
sub_data$Time <- strptime(sub_data$Time, format="%H:%M:%S")
sub_data[1:1440,"Time"] <- format(sub_data[1:1440,"Time"],"2007-02-01 %H:%M:%S")
sub_data[1441:2880,"Time"] <- format(sub_data[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# initiating a composite plot with many graphs
par(mfrow=c(2,2))

# calling the basic plot function that calls different plot functions to build the 4 plots that form the graph
with(sub_data,{
  plot(sub_data$Time,as.numeric(as.character(sub_data$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(sub_data$Time,as.numeric(as.character(sub_data$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(sub_data$Time,sub_data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(sub_data,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(sub_data,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(sub_data,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(sub_data$Time,as.numeric(as.character(sub_data$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

dev.off()