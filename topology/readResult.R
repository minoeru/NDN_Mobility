library(magrittr)
source("dir.R")
number <- 1

for (i in paste0(dir[number],"/result/pcap/pcap",data_num)) scan(paste0(i,"/result.txt"),what=character(),sep="\n") %>% grep("NoRoute",.) %>% length() %>% print()