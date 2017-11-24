library(tidyverse)

# download and unzip data
setwd("C:/Workarea/R/Data Science")
temp <- temp
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp, mode="wb")
unzip(temp, exdir = "UCI Data")

# read activity and feature ids and names
activity <- read_delim("UCI Data/UCI HAR Dataset/activity_labels.txt", delim = " ", col_names = FALSE)
(activity <- activity %>% rename(activity_id = X1, activity_name = X2))
feature <- read_delim("UCI Data/UCI HAR Dataset/features.txt", delim = " ", col_names = FALSE)
(feature <- feature %>% rename(feature_id = X1, feature_name = X2))
# caution: feature names are not unique!
feature_name_duplicates <- feature %>% 
  count(feature_name) %>% 
  filter(n > 1)
View(feature_name_duplicates) # no duplicates in relevant features
n_features <- nrow(feature)
# get relevant features
relevant_feature <- filter(feature, grepl("mean()",feature_name) | grepl("std()",feature_name))
View(relevant_feature)

# function to prepare activity, subject and measurements
prepare_data <- function (input_file, X1_rename = NULL) {
  out_table <- read_delim(input_file, delim = " ", col_names = FALSE)
  if (!is.null(X1_rename)) {
    out_table <- rename_(out_table, .dots = setNames("X1", X1_rename))
    # rename_ and .dots needed because X1_rename get passed as parameter
  }
  out_table <- mutate(out_table, row_id = seq.int(nrow(out_table)))
}
train_label <- prepare_data("UCI Data/UCI HAR Dataset/train/y_train.txt", "activity_id")
train_subject <- prepare_data("UCI Data/UCI HAR Dataset/train/subject_train.txt", "subject_id")
train_measure <- prepare_data("UCI Data/UCI HAR Dataset/train/X_train.txt")
test_label <- prepare_data("UCI Data/UCI HAR Dataset/test/y_test.txt", "activity_id")
test_subject <- prepare_data("UCI Data/UCI HAR Dataset/test/subject_test.txt", "subject_id")
test_measure <- prepare_data("UCI Data/UCI HAR Dataset/test/X_test.txt")

# the first two columns of the measurements are empty and there are superfluous columns at the end
offset <- 2
cols <- paste("X", relevant_feature$feature_id + offset, sep = "")

# clean measurements
clean_measure <- function (in_table, cols, col_names) {
  out_table <- select(in_table, one_of(cols))
  colnames(out_table) = as.character(col_names)
  out_table <- mutate(out_table, row_id = seq.int(nrow(out_table)))
}
train_measure_clean <- clean_measure (train_measure, cols, relevant_feature$feature_name)
test_measure_clean <- clean_measure (test_measure, cols, relevant_feature$feature_name)

# join data
join_data <- function (label, activity, subject, measure, train_test) {
  label_names <- left_join(label, activity, by = "activity_id")
  label_subject <- left_join(label_names, subject, by = "row_id")
  label_measure <- left_join(label_subject, measure, by = "row_id")
  label_measure <- label_measure %>%
    select(-row_id) %>%
    mutate(train_test = train_test)    
}
train_data <- join_data (train_label, activity, train_subject, train_measure_clean, "train")
test_data <- join_data (test_label, activity, test_subject, test_measure_clean, "test")

# append test to train
data_mean_sd <- rbind(train_data, test_data)

# get means for each subject and activity
grouped_means <- data_mean_sd %>%
  select(-train_test) %>%
  group_by(activity_id, activity_name, subject_id) %>%
  summarise_each(funs(mean(., na.rm=TRUE)))
dim(grouped_means)

# export grouped means
write.table(grouped_means, "03_04_project_export.txt", row.names = FALSE)
