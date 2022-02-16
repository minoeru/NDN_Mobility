source("dir.R")

for (number in 1:4) {
  df <- lapply(data_num, function(x){ read.csv(paste0(dir[number],"/result/ndn_csv/",x,"/nlsr_self.csv")) })
  for (i in data_num) {
    if(i == 0) my_df <- df[[1]][df[[1]]$name == "sum",]
    else my_df <- rbind(my_df,df[[i+1]][df[[i+1]]$name == "sum",])
  }
  my_df$name <- paste0("sum",data_num)
  tmp_result <- sapply(2:ncol(my_df), function(x) sum(my_df[,x]))
  tmp_result <- c(paste0("sum",dir[number]),tmp_result)
  
  ifelse(number == 1,result <- tmp_result,result <- rbind(result,tmp_result))
  if(number == 4) {
    result <- data.frame(result)
    names(result) <- names(my_df)
    write.csv(result,file="sum_all.csv",row.names = F)
  }
}


