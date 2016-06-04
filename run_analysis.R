# specify train and test file locations
test.file<-"U:/R/Course3/Week4/UCI HAR Dataset/test/x_test.txt"
train.file<-"U:/R/Course3/Week4/UCI HAR Dataset/train/x_train.txt"

# read test and train files  into a dataframes
test.data<-read.table(test.file)
train.data<-read.table(train.file)

# append test and train dataframes
data<-rbind(test.data, train.data)

# specify location of features file(column names)
features.file<-"U:/R/Course3/Week4/UCI HAR Dataset/features.txt"

# read column name file and create column vector
features<-read.table(features.file, header=FALSE)
colnames(data)<-features$V2

# locate columns with mean and std measures and keep only the located columns
keep.columns<-grep("-mean\\(\\)|-std\\(\\)", colnames(data))
data<-data[keep.columns]

# specify location of the activity lable file
activity.file<-"U:/R/Course3/Week4/UCI HAR Dataset/activity_labels.txt"

# read activity lable file into a dataframe 
activity.data<-read.table(activity.file)

# specify and read row name lable files for test file
test.label.file<-"U:/R/Course3/Week4/UCI HAR Dataset/test/y_test.txt"
test.label.data<-read.table(test.label.file)

# specify and read row name lable files for train file
train.label.file<-"U:/R/Course3/Week4/UCI HAR Dataset/train/y_train.txt"
train.label.data<-read.table(train.label.file)

# append row lable files
label.data<-rbind(test.label.data, train.label.data)

# add row lables(activity) to main dataframe
data<-cbind(label.data, data)

# merge to add descriptive activity lables
data<-merge(activity.data, data, by.x="V1", by.y="V1")

names(data)[2]<-paste("Activity")
data<-data[-c(1)]

# create summary file of selected measures by Activity
summary.data<-summarise_each(group_by(data, Activity), funs(mean))
