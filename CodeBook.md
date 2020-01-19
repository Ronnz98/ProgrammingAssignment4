Code Book: Getting and Cleaning Data - Week 4 Course Project

Source data:

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data was loadand and cleaned by running the run_analysis.R script.

The following files were loaded:

Training sets: X_train.txt / Y_train.txt / subject_train.txt

Test sets: X_test.txt / Y_test.txt / subject_test.txt

activity_labels.txt / features.txt

How data cleaning was done:

    1 - Merges the training and the test sets to create one data set.
    2 - Extracts only the measurements on the mean and standard deviation for each measurement.
    3 - Uses descriptive activity names to name the activities in the data set
    4 - Appropriately labels the data set with descriptive variable names.
    5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The 30 subject are numbered with the following Activity Labels:

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

The final output.txt consists of activity, Subject and filtered mean / standard deviation columns