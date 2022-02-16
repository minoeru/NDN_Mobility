library(magrittr)

makeResult <- function(x){
  for (i in 0:10) {
    ifelse(i == 0, df <- read.csv(paste0(x,"/nlsr_pc.csv")), df <- read.csv(paste0(x,"/nlsr_",i,".csv")))
    names(df) <- c("No.","Time","Source","Destination","Protocol","Length","Info")
    arp <- df[df$Protocol == "ARP",] %>% nrow()
    other <- df[df$Protocol != "ARP" & df$Protocol != "UDP (NDN)" ,] %>% nrow()
    ndn <- df[df$Protocol == "UDP (NDN)",] 
    
    sync <- grep("sync",ndn[240 <= ndn$Length ,]$Info) %>% length()
    LSA_data <- grep("LSA",ndn[240 <= ndn$Length ,]$Info) %>% length()
    info_reply <- grep("INFO",ndn[240 <= ndn$Length ,]$Info) %>% length()
    data <- ndn[220 <= ndn$Length & ndn$Length < 240,]　%>% nrow()
    info_interest <- ndn[130 <= ndn$Length & ndn$Length < 160,]　%>% nrow()
    LSA_interest <- ndn[100 <= ndn$Length & ndn$Length < 130,]　%>% nrow()
    interest <- ndn[ndn$Length < 100,]　%>% nrow()
    checksum <- arp + other + sync + LSA_data + info_reply + data + info_interest + LSA_interest + interest
    
    if(i == 0) result <- data.frame(name="nlsr_pc",all=nrow(df),interest,data,info_interest,info_reply,LSA_interest,LSA_data,sync,arp,other,checksum)
    else result <- data.frame(name=paste0("nlsr",i),all=nrow(df),interest,data,info_interest,info_reply,LSA_interest,LSA_data,sync,arp,other,checksum) %>% rbind(result,.)
  }
  tmp_result <- sapply(2:ncol(result), function(x) sum(result[,x]))
  rbind(result,c("sum",tmp_result)) %>% return()
}

for (i in 1:4) write.csv(makeResult(i),file = paste0(i,"/nlsr.csv"),row.names = F)