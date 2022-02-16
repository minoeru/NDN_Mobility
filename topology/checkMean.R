library(magrittr)
source("dir.R")
par(family= "HiraKakuProN-W3")

makeResult <- function(number){
  for (x in data_num) {
    for (i in 0:file_num[number]) {
      ifelse(i == 0, df <- read.csv(paste0(dir[number],"/result/ndn_csv/",x,"/nlsr_pc.csv")), df <- read.csv(paste0(dir[number],"/result/ndn_csv/",x,"/nlsr_",i,".csv")))
      names(df) <- c("No.","Time","Source","Destination","Protocol","Length","Info")
      ndn <- df[df$Protocol == "UDP (NDN)",] 
      my_address <- ifelse(i == 0,paste0("172.17.0.",file_num[number]+2),paste0("172.17.0.",i+1))
      ndn <- ndn[ndn$Source == my_address,]
      tmp_ndn <- ndn[240 <= ndn$Length ,]
      sync <- tmp_ndn[grep("sync",tmp_ndn$Info),]
      LSA_data <- tmp_ndn[grep("LSA",tmp_ndn$Info),]
      
      ifelse(i==0,result_sync <- sync,result_sync <- rbind(result_sync,sync))
      ifelse(i==0,result_lsa <- LSA_data,result_lsa <- rbind(result_lsa,LSA_data))
    }
    result_sync_interest <- result_sync[grep("Interest",result_sync$Info),]
    result_sync_data <- result_sync[grep("Data",result_sync$Info),]
    if(x == 0){
      all_result_lsa <- result_lsa
      all_result_sync_interest <- result_sync_interest
      all_result_sync_data <- result_sync_data
    }else{
      all_result_lsa <- rbind(all_result_lsa,result_lsa)
      all_result_sync_interest <- rbind(all_result_sync_interest,result_sync_interest)
      all_result_sync_data <- rbind(all_result_sync_data,result_sync_data)
    }
  }
  write.csv(all_result_lsa,paste0(dir[number],"/result/lsa.csv"))
  write.csv(all_result_sync_interest,paste0(dir[number],"/result/sync_interest.csv"))
  write.csv(all_result_sync_data,paste0(dir[number],"/result/sync_data.csv"))
}

checkMean <- function(my_flag){
  lsa <- lapply(1:4, function(i) read.csv(paste0(dir[i],"/result/lsa.csv")))
  sync_i <- lapply(1:4, function(i) read.csv(paste0(dir[i],"/result/sync_interest.csv")))
  sync_d <- lapply(1:4, function(i) read.csv(paste0(dir[i],"/result/sync_data.csv")))
  
  for (i in 1:4) {
    lsa[[i]]$Length %>% mean() %>%    paste0(dir[i]," LSA           ",.) %>% print()
    sync_i[[i]]$Length %>% mean() %>% paste0(dir[i]," Sync Interest ",.) %>% print()
    sync_d[[i]]$Length %>% mean() %>% paste0(dir[i]," Sync Data     ",.) %>% print()
  }
  
  if (my_flag == "interest"){
    t <- sapply(1:4, function(x) sync_i[[x]]$Length %>% sort() )
    num <- c(min(sync_i[[1]]$Length), max(sync_i[[4]]$Length))
  }else{
    t <- sapply(1:4, function(x) sync_d[[x]]$Length %>% sort() )
    num <- c(min(sync_d[[1]]$Length), max(sync_d[[4]]$Length))
  }
  
  plot(t[[1]], rank(t[[1]])/length(t[[1]]), type="l",xlim=c(num[1], num[2]),ylim=c(0, 1),ylab="累積確率",xlab="パケット長 (Byte)", col="red")
  par(new=T)
  plot(t[[2]], rank(t[[2]])/length(t[[2]]), type="l",xlim=c(num[1], num[2]),ylim=c(0, 1),ylab="",xlab="", col="blue")
  par(new=T)
  plot(t[[3]], rank(t[[3]])/length(t[[3]]), type="l",xlim=c(num[1], num[2]), ylim=c(0, 1),ylab="",xlab="", col="green")
  par(new=T)
  plot(t[[4]], rank(t[[4]])/length(t[[4]]), type="l",xlim=c(num[1], num[2]), ylim=c(0, 1),ylab="",xlab="", col="pink")
}

# for (number in 1:4) makeResult(number)
# checkMean("interest")
# checkMean("Data")