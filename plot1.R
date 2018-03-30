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


#  Ploting the data

dev.copy(png,"plot1.png", width=480, height=480)

hist(MyDataMod$globalactivepower, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

dev.off()




