
library("dplyr")
library("reshape2")

filepath <- "./" #Relative path of the dataset


#Make feature labels more readable
features <- read.csv(paste0(filepath,"features.txt"), sep=" ", header = FALSE, col.names = c("index","label"), colClasses = c("character", "character"))
features_sub <- sub('(f)(Body|Gravity)','frequency\\2', features$label)
features_sub <- sub('(t)(Body|Gravity)','time\\2',features_sub)

features_sub <- sub('(meanFreq\\(\\))','MnFrq',features_sub) #to avoid confusion with mean()
features_sub <- sub('(mean\\(\\))','_Mean',features_sub)
features_sub <- sub('(std\\(\\))','_Stdev',features_sub)
features_sub <- sub('(Gyro)','Gyroscope',features_sub)
features_sub <- sub('(Acc)','Accelerometer',features_sub)
features_sub <- sub('(Mag)','Magnitude',features_sub)


#Remove undesirable characters
features_sub <- gsub('(-)', '_', features_sub )
features_sub <- gsub('(\\(|\\))', '', features_sub )
features_sub <- gsub('(,)', '', features_sub )

#Keep 'raw' feature names for comparison
features$raw <- features$label
features$label <- features_sub

#Load training and test data 
x_train <- read.table(paste0(filepath,"train/X_train.txt"),col.names = features$label)
x_test <- read.table(paste0(filepath,"test/X_test.txt"),col.names = features$label)
y_train <- read.table(paste0(filepath,"train/Y_train.txt"), col.names = ("activity"))
y_test <- read.table(paste0(filepath,"test/Y_test.txt"), col.names = ("activity"))

#Merge columns
train <- mutate(x_train, activity=y_train$activity)
test <- mutate(x_test, activity=y_test$activity)

#Add subject column
subject_train <- read.table(paste0(filepath,"train/subject_train.txt"), col.names =c("subject"))
subject_test <- read.table(paste0(filepath,"test/subject_test.txt"), col.names =c("subject"))
train <- mutate(train, subject=subject_train$subject)
test <- mutate(test, subject=subject_test$subject)

#Merge rows
combined <- rbind(train, test)

#Throw out irrelevant columns
combined <- select(combined, matches("^(.*_Mean.*|.*_Stdev.*|activity|subject)$"))

#Add activity labels to make it human-readable
activity_labels <- read.table(paste0(filepath, "activity_labels.txt"), col.names=c("index", "label"))
combined$activity <- factor(combined$activity, labels = activity_labels$label)



final <- melt(combined, id.vars = c("subject","activity"))

#Extract additional columns to make it more readable

#Domain: time or frequency
final$domain <- sub("(frequency|time)(.*)", "\\1", final$variable)
final$domain <- as.factor(final$domain)
final$variable <- sub("(frequency|time)(.*)", "\\2", final$variable)

#Device: accelerometer or gyroscope
final$device <- sub("(.*)(Accelerometer|Gyroscope)(.*)", "\\2", final$variable)
final$variable <- sub("(.*)(Accelerometer|Gyroscope)(.*)", "\\1\\3", final$variable)


#Dimension: X,Y,Z (if applicable)
final$dimension <- sub("(.*)(X|Y|Z)(.*)", "\\2", final$variable)
final$dimension <- factor(final$dimension, levels = c("NoDimension", "X","Y","Z"))
final$dimension[is.na(final$dimension)] = "NoDimension"

final$variable <- sub("(.*)(X|Y|Z)(.*)", "\\1\\3", final$variable)

#Summary type: Mean or Standard deviation
final$sumtype <- sub("(.*)(_)(Mean|Stdev)(.*)","\\3", final$variable)
final$variable <- sub("(.*)(_)(Mean|Stdev)(.*)","\\1\\4", final$variable)

#Clean up the variable and make it nominal
final$variable <- gsub("(_)","", final$variable)
final$varcategory <- as.factor(final$variable)
final$variable <- NULL


aggfinal = aggregate(final, by = list(Group.subject=final$subject, 
                                      Group.activity=final$activity, 
                                      Group.domain=final$domain, 
                                      Group.varcategory=final$varcategory,
                                      Group.device = final$device,
                                      Group.dimension = final$dimension,
                                      Group.sumtype = final$sumtype
                                      ), FUN = mean)

rename(aggfinal,meanvalue=value)

aggfinal$subject <- NULL
aggfinal$activity <- NULL
aggfinal$domain <- NULL
aggfinal$varcategory <- NULL
aggfinal$device <- NULL
aggfinal$dimension <- NULL
aggfinal$sumtype <- NULL

write.table(aggfinal, "tidy_sum.txt", row.names=FALSE)


