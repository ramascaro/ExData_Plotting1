#Read File
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}
power_consumption <- read.table(file, header=T, sep=";")

#Subsetting by Dates, Converting formats & creating a new data frame df
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")
df <- power_consumption[(power_consumption$Date=="2007-02-01") | (power_consumption$Date=="2007-02-02"),]
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# PLOT 2
plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Save png file.
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
# Message
cat("plot2.png has been saved in", getwd())
