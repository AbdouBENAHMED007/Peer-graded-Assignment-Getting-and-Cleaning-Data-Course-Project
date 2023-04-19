
   features<-read.table(file.choose(),col.names = c("n","functions"))
   acivities<-read.table(file.choose(),col.names=c("code","activities"))
   x_test <- read.table(file.choose(), col.names = features$functions)
   y_test<-read.table(file.choose(),col.names="code")
   subject_test<-read.table(file.choose(),col.names = "s")
   
   x_train<-read.table(file.choose(),col.names = features$functions)
   y_train<-read.table(file.choose(),col.names = "code")
   subject_train<-read.table(file.choose(),col.names="s")
   
   features<-read.table(file.choose(),col.names = c("n","function"))
   
   X<-rbind(x_test,x_train)
   Y<-rbind(y_test,y_train)
   subject<-rbind(subject_train,subject_test)
   merged_data<-cbind(X,Y,subject)
   
   TidyData <- merged_data %>% select(code, contains("mean"), contains("std"))
   TidyData$code <- acivities[TidyData$code, 2]
   L<-names(TidyData)   

   FinalData <- TidyData %>%
      group_by("s", "code") %>%
      summarise_all(mean)
   
   write.table(FinalData, "FinalData.txt", row.name=FALSE)
   