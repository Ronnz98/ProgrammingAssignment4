# load needed libraries
library(dplyr)

# read the training data 
myXtrain   <- read.table("./UCI HAR Dataset/train/X_train.txt")
myYtrain   <- read.table("./UCI HAR Dataset/train/Y_train.txt") 
mySubtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# read the test data 
myXtest   <- read.table("./UCI HAR Dataset/test/X_test.txt")
myYtest   <- read.table("./UCI HAR Dataset/test/Y_test.txt") 
mySubtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# read the features description file
myfeatures <- read.table("./UCI HAR Dataset/features.txt") 

# read the activity labels file
myactivity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt") 

# merge the training and test data sets (step 1)
myXtotal   <- rbind(myXtrain, myXtest)
myYtotal   <- rbind(myYtrain, myYtest) 
mySubtotal <- rbind(mySubtrain, mySubtest) 

#Rename the columns 
colnames(myXtotal)   <- myfeatures[,2]
colnames(myYtotal)   <- "activity"
colnames(mySubtotal) <- "subject"
colnames(myactivity_labels)<-c("activity","typeActivity")

# Select only columns with mean and standard deviation (step 2)
myFilteredColumns <- grepl("mean|std", colnames(myXtotal))
myFilteredData <- myXtotal[, myFilteredColumns]

# Uses descriptive activity names to name the activities in the data set (step 3)
myYtotal$activity <- factor(myYtotal$activity, 
                           levels = myactivity_labels[, 1], labels = myactivity_labels[, 2])
mySubtotal$subject  <- as.factor(mySubtotal$subject) 


#Appropriately labels the data set with descriptive variable names (step 4)
myDescColumns <- colnames(myFilteredData)
myDescColumns  <- gsub("[\\(\\)-]", "", myDescColumns )
myDescColumns  <- gsub("^f", "frequencyDomain", myDescColumns )
myDescColumns  <- gsub("^t", "timeDomain", myDescColumns )
myDescColumns  <- gsub("Acc", "Accelerometer", myDescColumns )
myDescColumns  <- gsub("Gyro", "Gyroscope", myDescColumns )
myDescColumns  <- gsub("Mag", "Magnitude", myDescColumns )
myDescColumns  <- gsub("Freq", "Frequency", myDescColumns )
myDescColumns  <- gsub("mean", "Mean", myDescColumns )
myDescColumns  <- gsub("std", "StandardDeviation", myDescColumns )
myDescColumns  <- gsub("BodyBody", "Body", myDescColumns )
colnames(myFilteredData) <- myDescColumns 

#Create a second, independent tidy data set with the average of each variable for each activity and each subject (step 5)
myTotal <- cbind(mySubtotal, myYtotal, myFilteredData)
myTotalMean <- myTotal %>% group_by(activity, subject) %>% summarize_all(mean)
write.table(myTotalMean, "output.txt", row.name=FALSE)
