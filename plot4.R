

if(!file.exists("data")){
    dir.create("data")
 }

unzip("exdata_data_household_power_consumption.zip",exdir="./data",unzip="internal")

data<-read.table("./data/household_power_consumption.txt",sep=";",header=T,na.string="")

data$Date<-as.Date(as.character(data$Date),format = "%d/%m/%Y")

require(dplyr)
dataN<-filter(data,Date >= "2007-02-01" & Date <= "2007-02-02")


png(file="plot4.png",width = 480, height = 480, units = "px")

par(mfrow=c(2,2),mar=c(6,4,4,2))

with(dataN, plot(as.numeric(as.character(Global_active_power)),type="l",
	ylab="Global Active Power (Kilowats)",
	xlab="",
      xaxt="n",
	lwd=1
	))
axis(1,at=c(1,nrow(dataN)/2,nrow(dataN)), labels=c("Thurs","Fri","Sat"))

with(dataN, plot(as.numeric(as.character(Voltage)),type="l",
	ylab="Voltage",
	xlab="datetime",
      xaxt="n",
	lwd=1
	))
axis(1,at=c(1,nrow(dataN)/2,nrow(dataN)), labels=c("Thurs","Fri","Sat"))


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

with(dataN, plot(as.numeric(as.character(Global_reactive_power)),type="l",
	ylab=" Global_reactive_power",
	xlab="datetime",
      xaxt="n",
	lwd=1
	))
axis(1,at=c(1,nrow(dataN)/2,nrow(dataN)), labels=c("Thurs","Fri","Sat"))

dev.off()

