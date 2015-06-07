#my default is in French, so I need to change it to English
Sys.setenv(LANG='en')
Sys.setlocale('LC_TIME', 'English')
read_data <- function() {
	filename <- 'household_power_consumption.txt' #the filename
	#Starting with character for class column for Date and Time
	colClasses <-c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric')
	initial<-read.table(filename, sep = ';', na.string = c('?'), colClasses = colClasses, header = TRUE)
	#merging Date and Time in a new column DateTime, and making it into a DateTime object for the plotting
	initial$DateTime <- as.POSIXct(paste(initial$Date, initial$Time), 
		format = '%d/%m/%Y %H:%M:%S')
	#Making the date a Date object
	initial$Date <- as.Date(initial$Date, format = '%d/%m/%Y')
	#keeping only dates up to 2007-02-02
	initial <- initial[initial$Date <= as.Date('2007-02-02'),]
	#keeping only dates later than 2007-02-01
	initial <- initial[initial$Date >= as.Date('2007-02-01'),]
	initial #returning the filtered table
}
d<-read_data() #reading the table
png(file = 'plot4.png') #opening the png file
par(mfcol = c(2,2)) #initializing the 2x2 grid

#graph top left
plot(d[,'DateTime'], d[,'Global_active_power'], ylab = 'Global active power (kilowatts)', 
	xlab = '', type = 'l')

#graph bottom left
plot(d[,'DateTime'], d[,'Sub_metering_1'], ylab = 'Energy sub metering', xlab = '', type = 'l')
lines(d[,'DateTime'], d[,'Sub_metering_2'], col = 'red', )
lines(d[,'DateTime'], d[,'Sub_metering_3'], col = 'blue')
legend('topright', col=c('black', 'red', 'blue'), lty = 1, 
	legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

#graph top right
plot(d[,'DateTime'], d[,'Voltage'], ylab = 'Voltage', xlab = 'datetime', type = 'l')

#graph bottom right
plot(d[,'DateTime'], d[,'Global_reactive_power'], ylab = 'Global_reactive_power', xlab = 'datetime', type = 'l')

dev.off() #closing the png file