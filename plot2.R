#PLOT 2
if(!file.exists("data")){
    dir.create("data")
 }

unzip("exdata_data_household_power_consumption.zip",exdir="./data",unzip="internal")

data<-read.table("./data/household_power_consumption.txt",sep=";",header=T,na.string="")
data$Date<-as.Date(as.character(data$Date),format = "%d/%m/%Y")

require(dplyr)
dataN<-filter(data,Date >= "2007-02-01" & Date <= "2007-02-02")

dataN$day<- weekdays(as.Date(dataN$Date))

png(file="plot2.png",width = 480, height = 480, units = "px")
with(dataN, plot(as.numeric(as.character(Global_active_power)),type="l",
	ylab="Global Active Power (Kilowats)",
	xlab="",
      xaxt="n",
	lwd=1))

axis(1,at=c(1,nrow(dataN)/2,nrow(dataN)), labels=c("Thurs","Fri","Sat"))

dev.off()

