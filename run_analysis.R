Init<-function(workDir="/WD/MyWorkshops/Coursera_Udacity/Data_Science_Specialization_Track/Getting_and_Cleaning_Data/Getting-and-Cleaning-Data-Course-Project"){
        setwd(workDir)
}
Init()

# Load all necessary files first
features.df<-read.table("features.txt",stringsAsFactors=FALSE)
activity.df<-read.table("activity_labels.txt",stringsAsFactors=FALSE)

X_test<-read.table("test/X_test.txt")
Y_test<-read.table("test/y_test.txt")
Subject_test<-read.table("test/subject_test.txt")

X_train<-read.table("train/X_train.txt")
Y_train<-read.table("train/y_train.txt")
Subject_train<-read.table("train/subject_train.txt")

# Compile data frames (in the specified order) for test & train dataset, respectively 
test.df<-data.frame(Subject_test, Y_test, X_test)
train.df<-data.frame(Subject_train, Y_train, X_train)

# Merge the test and train datasets to create one data set. Then make annotate header names
full.df<-rbind(train.df, test.df) 
colnames(full.df)<-c("SubjectID", "ActivityID", features.df[,2])

# Now extracts only the measurements on the mean and standard deviation for each measurement
extracted.features.df<-full.df[,grepl("\\b-mean()\\b|\\b-std()\\b", names(full.df),perl=TRUE)] #use perl syntax to anchor the beginning/end of a word

#Uses descriptive activity names to name the activities in the data set
activity<-full.df[,2]  
for (i in 1:dim(activity.df)[1]){
        activity[activity==activity.df[i,1]]=activity.df[i,2] 
}

#Appropriately labels the data set with descriptive variable names. 
extracted.df<-cbind(full.df[,1],activity,extracted.features.df) #piece the whole thing together first
colnames(extracted.df)<-c("SubjectID", "Activity", names(extracted.features.df))

#Now make the variable name even more descriptive than already is
pattern=c("^t","^f","Body","Gravity","Acc","Gyro","Jerk-","Mag-","JerkMag-","mean","std","-X","-Y","-Z","[()]","-")
replacement=c("Time_","Frequency_","Body_","Gravity_","Acceleration_","Gyroscopic_","Jerk_","Magnitude_","JerkMagnitude_","Mean","StandardDeviation","_Xaxis","_Yaxis","_Zaxis","","")

DescriptiveName<-OriginalName<-colnames(extracted.df)
for (i in 1:length(pattern)){
        DescriptiveName<-gsub(pattern[i],replacement[i],DescriptiveName)
}

colnames(extracted.df)<-DescriptiveName
write.table(data.frame(OriginalName,DescriptiveName),file="My_VariableNameComparison.txt")

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidy.df<-aggregate(extracted.df[,c(3:ncol(extracted.df))], by=list(extracted.df$SubjectID,extracted.df$Activity), mean,simplify=TRUE)
modified.name<-paste("MEAN__[",names(extracted.df)[3:ncol(extracted.df)],"]",sep="")
colnames(tidy.df)<-c("SubjectID", "Activity", modified.name)
write.table(tidy.df,file="My_Tidy_Output.txt")

