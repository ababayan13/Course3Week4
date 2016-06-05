# specify train and test file locations

setwd <- "U:/R/Course3/Week4/UCI HAR Dataset/"

test.file <- "test/x_test.txt"
train.file <- "train/x_train.txt"

#specify subject identifier file locations
test.subject.file <- "test/subject_test.txt"
train.subject.file <- "train/subject_train.txt"

# specify lable file locations
test.label.file <- "test/y_test.txt"
train.label.file <- "train/y_train.txt"

# read test and train files  into a dataframes
test.data <- read.table(test.file)
train.data <- read.table(train.file)

# read subject identifier files into dataframes
test.subject <- read.table(test.subject.file, col.names = "Subject")
train.subject <- read.table(train.subject.file, col.names = "Subject")

# specify and read row name lable files for test file
test.label.data <- read.table(test.label.file, col.names = "Label")
train.label.data <- read.table(train.label.file, col.names = "Label")


# append test and train dataframes
data <- rbind(
      cbind(test.subject, test.label.data, test.data),
      cbind(train.subject, train.label.data, train.data)
)

# specify location of features file(column names)
features.file <- "features.txt"

# read column name file and create column vector
features <- read.table(features.file, header = FALSE)
colnames(data) <- c("Subject", "Label", as.vector(features$V2))

# locate columns with mean and std measures and keep only the located columns
keep.columns <- grep("-mean\\(\\)|-std\\(\\)", colnames(data))
data <- data[c(1, 2, keep.columns)]

# specify location of the activity lable file
activity.file <- "activity_labels.txt"

# read activity lable file into a dataframe
activity.data <- read.table(activity.file, col.names = c("Label", "Activity"))

# merge to add descriptive activity lables
data <- merge(activity.data, data, by = "Label")
data <- data[-c(1)]

# create summary file of selected measures by Activity
summary.data <- summarise_each(group_by(data, Activity, Subject), funs(mean))


write.table(data, file = "U:/R/Course3/Week4/tidy_table.txt", row.name =
                  FALSE)
write.table(summary.data, file = "U:/R/Course3/Week4/summary_table.txt", row.name =
                  FALSE)