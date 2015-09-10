#PLOT 3

fileUrl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("data")){
  dir.create("data")
}
temp=tempfile()

setInternet2(use=TRUE)

#downloading file and unzip 
download.file(fileUrl,temp, method="internal")
unzip(temp,exdir="./data",unzip="internal")

#clear now the connection
unlink(temp)

#read table
data<-read.table("./data/household_power_consumption.txt",sep=";",header=T,na.string="")

#change date format
data$Date<-as.Date(as.character(data$Date),format = "%d/%m/%Y")

#we filter out the data from the dates 2007-02-01 and 2007-02-02
require(dplyr)
dataN<-filter(data,Date >= "2007-02-01" & Date <= "2007-02-02")

#set data=NULL
data<-NULL

#add one column with days 
dataN$day<- weekdays(as.Date(dataN$Date))

#save the plot directly on a .png file  
png(file="plot3.png",width = 480, height = 480, units = "px")
with(dataN, plot(as.numeric(as.character(Sub_metering_1)),type="l",
	ylab="Energy sub metering",
	xlab="",
      xaxt="n",
	lwd=1,
	col="black"
	))
	lines(as.numeric(as.character(dataN$Sub_metering_2)),col="red")
	lines(dataN$Sub_metering_3,col="blue")


axis(1,at=c(1,nrow(dataN)/2,nrow(dataN)), labels=c("Thurs","Fri","Sat"))
legend("topright",lwd=2,cex=1, col=c("black","red","blue"),
legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#clear device
dev.off()
