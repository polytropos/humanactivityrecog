# humanactivityrecog
Assignment of Course "Getting and Cleaning Data"

This repo contains the R-script run_analysis.R to produce a summary table of data collected by smartlab.ws on the subject "Human Activity Recognition Using Smartphones". Besides the script you find the code book CodeBook.md with background information detailing all the variables in the output data set of the script.

### Explanation of run_analysis.R

To produce to tidy output data set the following steps were taken in the script 03_04_project_script.R. The script makes use of the tidyverse library. As most of the steps need to be taken multiple times, functions were writen to execute the common steps.

For further information please refer to the code book CodeBook.md.

* read in raw text files
* add descriptive column headers
* select only relevant columns
* add row ids
* merge data based on row ids or specific ids
* append testing data to training data
* group data by subject and activity
* calculate the mean of each measurement within each group
