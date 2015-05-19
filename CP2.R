#########
#Coursera project 2 in Reproducible research 

setwd("C:/Users/gissurj/R/Coursera/Reproducible research/RepData_PeerAssessment2")

############
#Download data and get it ready

download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", "Storm.bz2")

Storm <- read.csv("Storm.bz2")

tmpdir=unzip("Storm.zip")

#install.packages("sqldf")
#install.packages("lubridate")
#install.packages("timeDate")
#install.packages("reshape2")
#library("sqldf")
#library("timeDate")
#library(lattice) 
#library("lubridate")
#library(reshape2)
#analyze the data little 

str(Storm)

summary(Storm)

tail(Storm)

num_obs <- dim(Storm)[1]
num_variables <- dim(Storm)[2]

#analyze observations over year 
names(Storm)

# Reconstruct the date field 

a <-colsplit(Storm$BGN_DATE," ",c("Date","Time"))[1]
Storm[,"DATE"] <- a
Storm$YEAR <- year(Storm$DATE)
Storm$MONTH <- month(Storm$DATE)

#Lets minimize the dataset while we explore it to this century
S <- sqldf("select * from Storm where year > 1999")
S_2011 <- sqldf("select * from Storm where year = 2011")

# The columns names are not self explanatory but with digging here are some discoveries 
# DMG - Stands for damange 
# Prop - Are properties 
# PROPDMGEXP -> here are numbers stored in number e.g. M stands for million and T stands for thousund 
# CropDMG stands for crop damange 
# I believe that the MAG column stands for magnitude 
# The fatalities and injuries columns are self explained. 


######
#Extra analysis
num_obs_on_day[,"DAGS"] <- a

a <- as.Date(a$Date,format = "%m/%d/%Y")


num_obs_on_day <- sqldf("select BGN_DATE, count(*) obs from Storm group by BGN_DATE")

a <-colsplit(num_obs_on_day$BGN_DATE," ",c("Date","Time"))[1]

num_obs_on_day[,"dags"] <- a

num_obs_on_day$BGN_DATE <- as.Date(a$Date,format = "%m/%d/%Y")

num_obs_on_day$dags<-as.Date(num_obs_on_day$dags,format = "%m/%d/%Y")

num_obs_on_day$year <- year(num_obs_on_day$dags)

summary(num_obs_on_day)




