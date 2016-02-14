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

#Generar grafico 1
png("plot1.png",width=480,height=480)

hist(muestra$Global_active_power,col = "red",main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()




