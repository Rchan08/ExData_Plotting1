tempo<-tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, method="curl")
archivozip<-unz(temp, "household_power_consumption.txt")

HousPowCons<-read.table(archivozip,header = TRUE,stringsAsFactors = FALSE,sep = ";",
                        na.strings = "?")

#clases para las columnas
HousPowCons$datetime<-as.POSIXct(paste(HousPowCons$Date,HousPowCons$Time),format="%d/%m/%Y %H:%M:%S")
HousPowCons$Date<-as.Date(HousPowCons$Date,format = "%d/%m/%Y")
HousPowCons$Time<-strptime(HousPowCons$Time,format = "%H:%M:%S")
HousPowCons$Global_active_power<-as.numeric(HousPowCons$Global_active_power)
HousPowCons$Global_reactive_power<-as.numeric(HousPowCons$Global_reactive_power)
HousPowCons$Voltage<-as.numeric(HousPowCons$Voltage)
HousPowCons$Global_intensity<-as.numeric(HousPowCons$Global_intensity)
HousPowCons$Sub_metering_1<-as.numeric(HousPowCons$Sub_metering_1)
HousPowCons$Sub_metering_2<-as.numeric(HousPowCons$Sub_metering_2)
HousPowCons$Sub_metering_3<-as.numeric(HousPowCons$Sub_metering_3)

#Generar subconjunto
muestra<-HousPowCons[HousPowCons$Date>="2007-02-01"&HousPowCons$Date<="2007-02-02",]

#Genear grafico 4
png("plot4.png",width=480,height=480)

par(mfcol=c(2,2))
plot(muestra$datetime,muestra$Global_active_power,ylab="Global Active Power (Kilowatts)",type = "l",xlab = "")

plot(muestra$datetime,muestra$Sub_metering_1,ylab="Energy sub metering",type = "l",xlab="")
lines(muestra$datetime,muestra$Sub_metering_2,col="red")
lines(muestra$datetime,muestra$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lwd = 1,cex=0.5,bty="n",
       y.intersp = 1,xjust = 0,yjust = 0)

plot(muestra$datetime,muestra$Voltage,xlab="datetime",type="l",ylab = "Voltage")

plot(muestra$datetime,muestra$Global_reactive_power,xlab="datetime",type = "l")

dev.off()