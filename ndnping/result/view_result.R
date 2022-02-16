library("magrittr")

makePingResult <- function(x){
  pingData <- paste0(x,"/ping.txt") %>%  readLines()
  seqData <-  paste0(x,"/sequence.txt") %>%  readLines() %>% as.numeric()
  
  n_tmp <- 0
  c_tmp <- 0
  count <- 1
  nack_data <- length(seqData) %>% numeric()
  content_data <- length(seqData) %>% numeric()
  
  for (i in 2:length(pingData)){
    if(length(grep("nack",pingData[i])) == 1){
      n_tmp <- n_tmp + 1
      if (c_tmp != 0){
        content_data[count] <- c_tmp
        c_tmp <- 0
        count <- count + 1
      }
    } 
    else{
      c_tmp <- c_tmp + 1
      if (n_tmp != 0){
        count <- count + n_tmp %/% 110
        nack_data[count] <- n_tmp
        n_tmp <- 0
      }
    }
  }
  
  cbind(nack_data,content_data,seqData) %>% write.csv(.,paste0(x,"/result.csv"),row.names = F)
  max(nack_data[3:length(nack_data)]) %>% paste0("最大値:",.)　%>% write(.,file=paste0(x,"/result.txt"))
  min(nack_data[3:length(nack_data)]) %>% paste0("最小値:",.)　%>% write(.,file=paste0(x,"/result.txt"),append = T)
  mean(nack_data[3:length(nack_data)]) %>% paste0("平均値:",.)　%>% write(.,file=paste0(x,"/result.txt"),append = T)
}

dir <- c("connectAfterLeave","connectBeforeLeave","simulateCache")
for (i in 1:3) makePingResult(dir[i])