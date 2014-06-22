#README for CourseProject:

### (Instruction: You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.)

##My run_analysis.R does the following steps:

*1. Loads all necessary files first

*2. Compile data frames for test & train dataset, respectively

*3. Merge the test and train datasets to create one data set (named "full.df"). Also genearate interim header names for the dataset.

*4. Per instruction, extract only the measurements on the mean (name containing "-mean()") and standard deviation (name containing "-std()") for each measurement.

*5. Given the info in activity_labels.txt, descriptive activity names (e.g. "WALKING") now replace the original non-descriptive (numerical) activity labels (e.g. "1")

*6. Next, I piece together the entire extracted data set (including SubjectID, Activity, and selected mean/std measurements), along with descriptive variable names. The data set is named "extracted.df"

*7. I now make the descriptive variable names even that more descriptive by replacing abbreviated terms with its full descriptive term! Detailed info on descriptive names are included in the CodeBook.md.   Also, a chart comparing the "descriptive names (derived from features.txt)" & the "more descriptive names" is included in the repo, named "My_VariableNameComparison.txt" 

*8. Lastly, I create a separate tidy dataset (named "tidy.df") with the average of each variable for each activity and each subject. (Corresponding variable names are modified to "MEAN__[original_descriptive_name_here]"). This tidy dataset is also output to a text file named "My_Tidy_Output.txt", included in the repo.


