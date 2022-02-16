library(magrittr)
source("dir.R")
# number <- 1
# 
# for (i in paste0(dir[number],"/result/pcap/pcap",c(0:10))) scan(paste0(i,"/result.txt"),what=character(),sep="\n") %>% grep("NoRoute",.) %>% length() %>% print()

result <- lapply(1:11, function(number){
  sapply(0:10, function(x){
    paste0(dir[number],"/result/pcap/pcap",x) %>% paste0(.,"/result.txt") %>%  scan(.,what=character(),sep="\n") %>% grep("NoRoute",.) %>% length()
  })
}) %>% data.frame()

colnames(result) <- paste0("edge",c(0:10))
rownames(result) <- paste0("center",c(0:10))

write.csv(result,"result.csv")