source("dir.R")
number <- 1

for (i in data_num) {
  for (j in 0:file_num[number]) {
    file <- ifelse(j == 0,"pc",j)
    filename_in <- paste0(dir[number],"/result/pcap/pcap",i,"/nlsr_",file,".pcap")
    filename_out <- paste0(dir[number],"/result/ndn_csv/",i,"/nlsr_",file,".csv")
    my_tshark <- paste0("tshark -n -E quote=d -E header=y -r ",filename_in," -T fields -E separator=,  -e frame.number -e frame.time_epoch -e ip.src -e ip.dst -e _ws.col.Protocol -e frame.len  -e _ws.col.Info > ",filename_out)
    system(my_tshark)
  }
}