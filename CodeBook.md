### Description of data origin

>Human Activity Recognition Using Smartphones Dataset
>Version 1.0
>Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
>Smartlab - Non Linear Complex Systems Laboratory
>DITEN - Università degli Studi di Genova.
>Via Opera Pia 11A, I-16145, Genoa, Italy.
>activityrecognition@smartlab.ws
>www.smartlab.ws

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


### Variables in the output data set

Data set name: 03_04_project_export.csv

Dimensions: 82 columns, 180 rows

* subject: ID of subject performing an activity (1-30)
* activity_id: ID of performed activity
* activity_name: name of performed activity
  * \[activity_id\]: \[activity_name\]
  * 1: WALKING
  * 2: WALKING_UPSTAIRS
  * 3: WALKING_DOWNSTAIRS
  * 4: SITTING
  * 5: STANDING
  * 6: LAYING
* feature measurements: The following measurements got transformed in 2 steps. In the first step the measurements themselves got transformed as indicated by -mean() or -std(). In the second step the mean of each measurement within each specified group of subject-activity was calculated. -X, -Y, -Z at the end of a variable name indicate the axial signal direction.
 * tBodyAcc
 * tGravityAcc
 * tBodyAccJerk
 * tBodyGyro
 * tBodyGyroJerk
 * tBodyAccMag
 * tBodyGyroMag
 * fBodyAcc
 * fBodyAccJerk
 * fBodyGyro
 * fBodyAccMag
 * fBodyBodyAccJerkMag
 * fBodyBodyGyroMag
 * fBodyBodyGyroJerkMag


### Performed data transformations

To produce to tidy output data set the following steps were taken in the script 03_04_project_script.R. The script makes use of the tidyverse library. As most of the steps need to be taken multiple times, functions were writen to execute the common steps.

* read in raw text files
* add descriptive column headers
* select only relevant columns
* add row ids
* merge data based on row ids or specific ids
* append testing data to training data
* group data by subject and activity
* calculate the mean of each measurement within each group
