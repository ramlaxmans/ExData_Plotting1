#library(datasets)
# plot2.R - To plot Gloabl Active Power Line Drawing
# Read the file "household_power_consumption.txt" and select data
# corresponding to dates 01/02/2007 and 02/02/2007

# Read the file and store to hpc
hpc<-read.table("./household_power_consumption.txt", sep=";", na.strings="?",skip=1)
colnames(hpc) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
hpc$Date<-as.Date(hpc$Date,"%d/%m/%Y")
hpcs <- hpc[hpc$Date== as.Date("01/02/2007","%d/%m/%Y"),]
hpcs1 <- hpc[hpc$Date== as.Date("02/02/2007","%d/%m/%Y"),]
hpcs<-rbind(hpcs,hpcs1)
head(hpcs)
hpcs$Global_active_power <-as.numeric(hpcs$Global_active_power)
hpcsdt<- paste(hpcs$Date, hpcs$Time) # Join Date and Time together
hpcsdts<-strptime(hpcsdt,"%Y-%m-%d %H:%M:%S") # Convert into Day and seconds format
plot(hpcsdts, hpcs$Global_active_power,xlab=" Date", ylab="Global Active Power (kiloWatts)", 
     col="black", main="Global Active Power", type="l")
dev.copy(png,"./plot2.png")  # Copy the plot to png file
dev.off() # Close the plot device