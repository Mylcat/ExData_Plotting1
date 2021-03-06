## Function to Read the data from the txt file 10/01/2015

readFile<-function(filename) {
        
        # Read the file with header and seperator ; strings for null ? decimal val ="."
        electricpower<-read.table("household_power_consumption.txt",sep = ";",header = TRUE,dec=".",na.strings="?",colClasses = "character")
        # Set the date in proper format for comparison
        electricpower$Date<-as.Date(electricpower$Date,format="%d/%m/%Y")
        # set the datetime column with proper Data for plotting. concatinate date and time and convert to POSIXct 
        electricpower["dt"]<-as.POSIXct(strptime(paste(electricpower$Date,electricpower$Time),"%Y-%m-%d %H:%M:%S"))
        # find the differnce between the date from data to 2007-02-01 and limit it to 0 and 1 days for 2007-02-02
        electricpower["diff"]<-as.numeric(difftime(electricpower$Date,as.Date("2007-02-01",format="%Y-%m-%d"),units="days"))
        electricpowertempRq<-electricpower[(electricpower$diff>=0 & electricpower$diff<2),]
        electricpowertempRq
        
}

elecPwr<-readFile("household_power_consumption.txt")

#set the plot size and file name
png("plot3.png",width = 480,height=480,units="px")

# plot the first reading submetering 1 and add the points for metering 2 and 3 and add the legend
plot(elecPwr$dt,as.numeric(elecPwr$Sub_metering_1),ylab = "Energy sub metering",xlab = "",type = "l")
points(elecPwr$dt,as.numeric(elecPwr$Sub_metering_2),ylab = "Energy sub metering",xlab = "",type = "l",col="red")
points(elecPwr$dt,as.numeric(elecPwr$Sub_metering_3),ylab = "Energy sub metering",xlab = "",type = "l",col="blue")
legend("topright",lty=1,c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))
dev.off()
