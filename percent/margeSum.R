source("dir.R")
number <- 4
SELF_FLAG <- TRUE

file_name <- ifelse(SELF_FLAG,"/nlsr_self.csv","/nlsr.csv")
file_name2 <- ifelse(SELF_FLAG,"/sum_all_self.csv","/sum_all.csv")

for (number in 1:11) {
  df <- lapply(data_num, function(x){ read.csv(paste0(dir[number],"/result/ndn_csv/",x,file_name)) })
  for (i in data_num) {
    if(i == 0) my_df <- df[[1]][df[[1]]$name == "sum",]
    else my_df <- rbind(my_df,df[[i+1]][df[[i+1]]$name == "sum",])
  }
  my_df$name <- paste0("sum",data_num)
  write.csv(my_df,file = paste0(dir[number],"/result",file_name2),row.names = F)
}

result <- sapply(1:11, function(number){
  df <- read.csv(paste0(dir[number],"/result",file_name2))
  return(df$all)
}) %>% data.frame()
colnames(result) <- paste0("edge",c(0:10))
rownames(result) <- paste0("center",c(0:10))

write.csv(result,"sum.csv")