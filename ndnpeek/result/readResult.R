library(magrittr)


for (i in paste0("pcap",c(1:4))) scan(paste0(i,"/result.txt"),what=character(),sep="\n") %>% grep("NoRoute",.) %>% length() %>% print()