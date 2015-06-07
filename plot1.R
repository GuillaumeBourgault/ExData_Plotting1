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
png(file = 'plot1.png') #opening the png file
hist(d[,'Global_active_power'], 
	xlab = 'Global active power (kilowatts)', 
	col = 'red', main = 'Global Active Power')
dev.off() #closing the png file