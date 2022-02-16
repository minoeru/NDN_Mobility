library(magrittr)
source("dir.R")
number <- 4
SELF_FLAG <- TRUE

makeResult <- function(x){
  for (i in 0:file_num[number]) {
    ifelse(i == 0, df <- read.csv(paste0(dir[number],"/result/ndn_csv/",x,"/nlsr_pc.csv")), df <- read.csv(paste0(dir[number],"/result/ndn_csv/",x,"/nlsr_",i,".csv")))
    names(df) <- c("No.","Time","Source","Destination","Protocol","Length","Info")
    arp <- df[df$Protocol == "ARP",] %>% nrow()
    other <- df[df$Protocol != "ARP" & df$Protocol != "UDP (NDN)" ,] %>% nrow()
    ndn <- df[df$Protocol == "UDP (NDN)",] 
    
    if(SELF_FLAG){
      my_address <- ifelse(i == 0,paste0("172.17.0.",file_num[number]+2),paste0("172.17.0.",i+1))
      ndn <- ndn[ndn$Source == my_address,]
    }
    
    tmp_ndn <- ndn[240 <= ndn$Length ,]
    sync <- tmp_ndn[grep("sync",tmp_ndn$Info),]
    sync_interest <- grep("Interest",sync$Info) %>% length()
    sync_interest_len <- sync[grep("Interest",sync$Info),]$Length %>% sum()
    sync_data <- grep("Data",sync$Info) %>% length()
    sync_data_len <- sync[grep("Data",sync$Info),]$Length %>% sum()
    sync_len <- sync$Length %>% sum()
    sync <- nrow(sync)
    
    LSA_data <- grep("LSA",tmp_ndn$Info) %>% length()
    info_reply <- grep("INFO",tmp_ndn$Info) %>% length()
    data <- ndn[220 <= ndn$Length & ndn$Length < 240,]　%>% nrow()
    info_interest <- ndn[130 <= ndn$Length & ndn$Length < 160,]　%>% nrow()
    LSA_interest <- ndn[100 <= ndn$Length & ndn$Length < 130,]　%>% nrow()
    interest <- ndn[ndn$Length < 100,]　%>% nrow()
    
    if(i == 0) result <- data.frame(name="nlsr_pc",all=nrow(df),interest,data,info_interest,info_reply,LSA_interest,LSA_data,sync_interest,sync_data,arp,other,sync,sync_len,sync_interest_len,sync_data_len)
    else result <- data.frame(name=paste0("nlsr",i),all=nrow(df),interest,data,info_interest,info_reply,LSA_interest,LSA_data,sync_interest,sync_data,arp,other,sync,sync_len,sync_interest_len,sync_data_len) %>% rbind(result,.)
  }
  tmp_result <- sapply(2:ncol(result), function(x) sum(result[,x]))
  rbind(result,c("sum",tmp_result)) %>% return()
}

makeCSV <- function(my_arg){
  file_name <- ifelse(SELF_FLAG,"/nlsr_self.csv","/nlsr.csv") 
  df <- lapply(data_num, function(x){ read.csv(paste0(dir[number],"/result/ndn_csv/",x,file_name)) })
  name <- c(df[[1]]$name,"ave","r_sum","r_ave")
  tmp <- nrow(df[[1]]) -1
  tmp_data <- sapply(1:length(data_num), function(x){
    c(df[[x]][,my_arg],mean(df[[x]][,my_arg][1:tmp]),sum(df[[x]][,my_arg][2:tmp]),mean(df[[x]][,my_arg][2:tmp]))
  })
  tmp_result <- data.frame(name,tmp_data)
  names(tmp_result) <- c("name",paste0(my_arg,data_num))
  file_name <- ifelse(SELF_FLAG,"_self.csv",".csv") 
  write.csv(tmp_result,file = paste0(dir[number],"/result/statis/nlsr_",my_arg,file_name),row.names = F)
}

file_name <- ifelse(SELF_FLAG,"/nlsr_self.csv","/nlsr.csv") 
for (i in data_num) write.csv(makeResult(i),file = paste0(dir[number],"/result/ndn_csv/",i,file_name),row.names = F)
for (i in c("sync_interest","sync_data","LSA_data","sync_interest_len","sync_data_len")) makeCSV(i)