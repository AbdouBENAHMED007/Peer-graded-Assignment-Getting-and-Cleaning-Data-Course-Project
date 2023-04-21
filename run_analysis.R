
   features<-read.table(file.choose(),col.names = c("n","functions"))
   activities<-read.table(file.choose(),col.names=c("code","activities"))
   x_test <- read.table(file.choose(), col.names = features$functions)
   y_test<-read.table(file.choose(),col.names="code")
   subject_test<-read.table(file.choose(),col.names = "s")
   
   x_train<-read.table(file.choose(),col.names = features$functions)
   y_train<-read.table(file.choose(),col.names = "code")
   subject_train<-read.table(file.choose(),col.names="s")
   
   
   
   X<-rbind(x_test,x_train)
   Y<-rbind(y_test,y_train)
   subject<-rbind(subject_train,subject_test)
   merged_data<-cbind(X,Y,subject)
   
   library(dplyr)
   
   TidyData <- merged_data %>% select(s,code, contains("mean"), contains("std"))
   TidyData$code <- activities[TidyData$code, 2]
   L<-names(TidyData)   
   
   library(tidyr)
   
   FinalData <- TidyData %>%
      group_by(s, code) %>%
      summarise_all(mean) %>%
      gather(key = "functions", value = "Mean", -c("s", "code")) %>%
      arrange(s, code, functions)
   
   write.table(FinalData, "FinalData.txt",
               sep="       |  ",
               quote=FALSE,
               na="-",
               fileEncoding="UTF-8",
               row.names=FALSE)
   