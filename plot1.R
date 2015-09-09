#PLOT 1

if(!file.exists("data")){
    dir.create("data")
 }

unzip("exdata_data_household_power_consumption.zip",exdir="./data",unzip="internal")
data<-read.table("./data/household_power_consumption.txt",sep=";",header=T,na.string="")

data$Date<-as.Date(as.character(data$Date),format = "%d/%m/%Y")

require(dplyr)
dataN<-filter(data,Date >= "2007-02-01" & Date <= "2007-02-02")

png(file="plot1.png",width = 480, height = 480, units = "px")
with(dataN,hist(as.numeric(as.character(Global_active_power)),
	xlab="Global Active Power (Kilowats)",
	main="Global Active Power",
	border="blue",
	col="red",
      breaks=13),na.rm=T)

dev.off()
