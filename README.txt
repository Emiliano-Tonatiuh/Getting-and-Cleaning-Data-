Inside this file i´ll try to explain what i did in run_analysis.R 

In the discussion forum I read that the files of Inertial Signals were not important.
(https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project/discussions/threads/REMOGUNiEeag-Q7qt7iPGQ)

actually the ones that had to be joined were 'Xtrain.tex', 'ytrain.tex' and also in 'Xtest' 'ytest', in addition to the 'features' file which contains the names of the variables

the observations were in X and in 'y' were the activities, so the corresponding columns had to be joined

Xtrain <-cbind (TypeOfActivity, Xtrain)
Equivalently it is done with 'Xtest', where the features file for the names of the columns must also be added

After that the two data sets must be joined

mergedata <- rbind (Xtest, Xtrain)
dim (mergedata) ### dim (mergedata) 10299 562


Subsequently, those columns that have the word average or standard deviation must be filtered, as these parameters will be requested,

this is done by


Variables = colnames (mergedata)
Promedio <- (grepl ("V1", Variables) | grepl ("mean ..", Variables) | grepl ("std ..", Variables))

Only those columns containing those words are added to the ordered data.

tidydata <- mergedata [, Promedio == TRUE]

the averages are requested to be obtained for each activity, filter () is used to select those rows with a common characteristic.

tidybyActivity <-tbl_df (tidydata)
Walking <-filter (tidybyActivity, V1 == as.integer (1))

Remembering that
1 == WALKING
2 == WALKING_UPSTAIRS
3 == WALKING_DOWNSTAIRS
4 == SITTING
5 == STANDING
6 == LAYING

And finally obtaining the average by Activity

WalkingMean <-sapply (Walking, mean)


