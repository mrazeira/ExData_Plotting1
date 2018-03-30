#
# Peer Graded Assignment Week 1
#


# Deleting old variables

rm(list = ls())

# Loading Librarys

library(dplyr)

library(png)

#  Loading data

MyFile <- "./household_power_consumption.txt"

MyData <- read.table(MyFile, header = TRUE, sep = ";", na.strings = "?" ,stringsAsFactors = FALSE)

#
#  Organizing the data
#

names(MyData) <- gsub( "[[:punct:]]" , "",tolower(names(MyData)))

MyData_tbl <- tbl_df(MyData)

# Selecting only data from 1/2/2007 to 2/2/2007

MyData_tbl2<- filter(MyData_tbl, MyData_tbl$date == "1/2/2007" | MyData_tbl$date == "2/2/2007")

datetime <- strptime(paste(MyData_tbl2$date, MyData_tbl2$time), "%d/%m/%Y %H:%M:%S")

# Eliminating date and time colunms from teh data

MyData_tbl3<- select(MyData_tbl2, -c(date:time))

MyDataMod <- cbind(datetime,MyData_tbl3)

#

MyDataMod <-tbl_df(MyDataMod)

#  Seting LC time to get week names in english

Sys.setlocale("LC_TIME", "en_US.UTF-8")


#  Ploting the data

dev.copy(png,"plot4.png", width=480, height=480)

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0)  )

with(MyDataMod,{
        
        plot(globalactivepower~datetime,  type = "l", xlab = "",ylab = "Global Active Power (kilowatts)")
       
        plot(voltage~datetime,  type = "l", xlab = "",ylab = "Voltage")
        
        plot(submetering1~datetime, type = "l", xlab = "",ylab = "Global Active Power (kilowatts)")
        lines(datetime,submetering2,col='red')
        lines(datetime,submetering3,col='blue')})

        legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        plot(globalreactivepower ~ datetime,  type = "l", xlab = "",ylab = "Global Reactive Power (kilowatts)")
        

dev.off()
