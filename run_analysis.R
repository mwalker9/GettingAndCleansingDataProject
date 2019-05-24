#combine test and training set
testFeatures <- read.table('./Dataset/test/X_test.txt')
trainingFeatures <- read.table('./Dataset/train/X_train.txt')
testLabels <- read.table('./Dataset/test/y_test.txt')
trainingLabels <- read.table('./Dataset/train/y_train.txt')
featureNames <- read.table('./Dataset/features.txt')
testFeatures[, 562] <- testLabels
trainingFeatures[, 562] <- trainingLabels
totalDataSet <- rbind(trainingFeatures, testFeatures)
colnames(totalDataSet) <- c(as.character(featureNames[,2]), 'activityLabel')

#part 2, extract only means/standard deviations for each measurement
columnsToKeep <- which(grepl('std\\(\\)', colnames(totalDataSet)) | grepl('mean\\(\\)', colnames(totalDataSet)))
prunedDataSet <- totalDataSet[,c(columnsToKeep, 562)]

#part 3, Descriptive Activity Names
labels <- read.table('./Dataset/activity_labels.txt', col.names = c('id', 'activity_name'))
prunedDataSet$activityLabel <- factor(prunedDataSet$activityLabel)
levels(prunedDataSet$activityLabel) <- labels$activity_name
prunedDataSet$activityLabel <- as.character(prunedDataSet$activityLabel)

names(prunedDataSet) <- gsub('tBody', 'time-domain-body-', names(prunedDataSet))
names(prunedDataSet) <- gsub('Acc', 'accelerometer', names(prunedDataSet))
names(prunedDataSet) <- gsub('mean\\(\\)', 'average', names(prunedDataSet))
names(prunedDataSet) <- gsub('std\\(\\)', 'st-deviation', names(prunedDataSet))
names(prunedDataSet) <- gsub('tGravity', 'time-domain-gravity-', names(prunedDataSet))
names(prunedDataSet) <- gsub('Mag', '-magnitude', names(prunedDataSet))
names(prunedDataSet) <- gsub('fBody', 'frequency-domain-body-', names(prunedDataSet))
names(prunedDataSet) <- gsub('Gyro', 'gyroscope', names(prunedDataSet))


