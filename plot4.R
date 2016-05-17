# plot4.R - To plot multiple plots -  Line Drawing
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
par(mfrow=c(2,2))   # plot 2 plots for 2 rows each
par(mar=c(2,4,2,2))  # set margin 
# plot1 - Globl active Power
plot(hpcsdts, hpcs$Global_active_power,xlab=" Date", ylab="Global Active Power (kiloWatts)", 
     col="black", type="l")
#plot 2 - voltage
plot(hpcsdts, hpcs$Voltage,xlab="DateTime", ylab="Voltage", 
     col="black", type="l")
# plot 3 - Start composing the plots for Sub metering 1,2& 3
plot(hpcsdts, hpcs$Sub_metering_1, type="n", ylab="Energy Sub Metering")
lines(hpcsdts, hpcs$Sub_metering_1, col="black")
lines(hpcsdts, hpcs$Sub_metering_2, col="red")
lines(hpcsdts, hpcs$Sub_metering_3, col="blue")
# build sub metering legend
submlgnd<-c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Build color for legend lines
collgnd<-c("black","red", "blue")

# put the legends 
legend("topright", legend=submlgnd, col=collgnd,lty=1, bty="n")

# plot 4 - Global Reactive Power 
plot(hpcsdts, hpcs$Global_reactive_power,xlab="DateTime", ylab="Global Reactive Power", col="black", type="l")
dev.copy(png,"./plot4.png")  # Copy the plots to png file
dev.off() # Close the plot device