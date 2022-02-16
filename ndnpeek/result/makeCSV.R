for (i in 1:4) {
  for (j in 0:10) {
    file <- ifelse(j == 0,"pc",j)
    filename_in <- paste0("pcap",i,"/nlsr_",file,".pcap")
    filename_out <- paste0(i,"/nlsr_",file,".csv")
    my_tshark <- paste0("tshark -n -E quote=d -E header=y -r ",filename_in," -T fields -E separator=,  -e frame.number -e frame.time_epoch -e ip.src -e ip.dst -e _ws.col.Protocol -e frame.len  -e _ws.col.Info > ",filename_out)
    system(my_tshark)
  }
}