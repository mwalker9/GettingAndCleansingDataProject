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
