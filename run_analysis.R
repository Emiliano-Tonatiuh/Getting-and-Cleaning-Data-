
setwd('C:\\Users\\emili\\OneDrive\\Escritorio\\R\\Coursera R')
url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile ='C:\\Users\\emili\\OneDrive\\Escritorio\\R\\Coursera R\\Getting and Cleaning Data\\dataproject\\Datos.zip')
unzip(zipfile=".\\Getting and Cleaning Data\\dataproject\\Datos.zip", exdir=".\\Getting and Cleaning Data\\dataproject")
archivos<-list.files(".\\Getting and Cleaning Data\\dataproject") %>% print

      ###The files of the project are inside 'UCI HAR Dataset'

direccion = ".\\Getting and Cleaning Data\\dataproject\\UCI HAR Dataset" 
archivo2 = list.files(direccion,recursive = TRUE) %>% print

      ###We can see that from 1:4 they are informative feature files , from 5:16 they are test files meanwhile 17:28 they are train files

DireccionTrain='.\\Getting and Cleaning Data\\dataproject\\UCI HAR Dataset\\train\\X_train.txt'
DireccionTrainy='.\\Getting and Cleaning Data\\dataproject\\UCI HAR Dataset\\train\\y_train.txt'



Xtrain <- read.table(DireccionTrain, header = FALSE,stringsAsFactors = TRUE) #                      ### dim(Xtrain)=7352 561
features <- read.table(".\\Getting and Cleaning Data\\dataproject\\UCI HAR Dataset\\features.txt" ) ### dim(features)= 561 2 this means that we need to bind the second 
                                                                                                    ### column of features as headers of Xtrain (number of columns 561)
#featuresheaders<-features[,2]
colnames(Xtrain) = features[,2]

TypeOfActivity<-read.table(DireccionTrainy,header=FALSE,stringsAsFactors = TRUE) #          ### dim(TypeOfActivity)   7352 1 wich means that it has to be append as activity label 
Xtrain<-cbind(TypeOfActivity,Xtrain)

      ###up to this point everything that has been done is just with train file, so the test files is just a copy-paste
      ###note :Activity Label is a numeric value between 1:6 something that has to be change later

DireccionTest='.\\Getting and Cleaning Data\\dataproject\\UCI HAR Dataset\\test\\X_test.txt'
DireccionTesty='.\\Getting and Cleaning Data\\dataproject\\UCI HAR Dataset\\test\\y_test.txt'
Xtest <- read.table(DireccionTest,header = FALSE,stringsAsFactors = TRUE) #
View(Xtest)
dim(Xtest)
colnames(Xtest) = features[,2]
TypeOfActivity2<-read.table(DireccionTesty,header=FALSE,stringsAsFactors = TRUE) #
dim(TypeOfActivity2)          
Xtest<-cbind(TypeOfActivity2,Xtest)
mergedata<- rbind(Xtest,Xtrain)
dim(mergedata)                                                  ### dim(mergedata)  10299 562           



Variables = colnames(mergedata)
Promedio <-(  grepl("V1" , Variables)| grepl("mean.." , Variables) | grepl("std.." , Variables)) 
tidydata=data.frame()
tidydata <- mergedata[ , Promedio == TRUE]
library(dplyr)
tidybyActivity <-tbl_df(tidydata)
Walking<-filter(tidybyActivity,V1==as.integer(1)) 
write.table(Walking,row.names = TRUE,col.names = TRUE,file ='tidybyWALKING.txt' )
#1 WALKING #2 WALKING_UPSTAIRS #3 WALKING_DOWNSTAIRS #4 SITTING #5 STANDING #6 LAYING
WalkingMean<-sapply(Walking,mean)

#if we want to calculate another activity, we ony need to change in filter V1== # of Activity
write.table(WalkingMean,row.names = TRUE,col.names = TRUE,file ='tidybyWALKING-Mean.txt' )


