#PLOT 2

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
png(file="plot2.png",width = 480, height = 480, units = "px")
with(dataN, plot(as.numeric(as.character(Global_active_power)),type="l",
	ylab="Global Active Power (Kilowats)",
	xlab="",
      xaxt="n",
	lwd=1))

axis(1,at=c(1,nrow(dataN)/2,nrow(dataN)), labels=c("Thurs","Fri","Sat"))

#clear device
dev.off()

