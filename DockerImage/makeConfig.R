library(magrittr)

CONF_NAME <- "ndnpeek"
df <- paste0("configuration/",CONF_NAME,".csv") %>% read.csv()

makeConfiguration <- function(){
  dir <- paste0("./my_conf/",CONF_NAME)
  if(system(paste0("test -d ",dir)) == 1) system(paste0("mkdir ",dir))
  
  for (i in 1:nrow(df)) {
    my_dir <-  paste0(dir,"/",df$X[i])
    if(system(paste0("test -d ",my_dir)) == 1) system(paste0("mkdir ",my_dir))
    my_file <- paste0(my_dir,"/nlsr.conf")
    paste0("cp ./configuration/material/nlsr.conf ",my_file) %>% system()
    
    paste0("sed -i \"\" -e 's@<router_name>@",df$router_name[i],"@g' ",my_file) %>% system()
    paste0("sed -i \"\" -e 's@<state_dir>@",df$state_dir[i],"@g' ",my_file) %>% system()
    
    neighbor <- strsplit(df$neighbors[i],",")  %>% unlist()
    for (j in 1:length(neighbor)) {
      tmp_data <- paste("neighbor",
                        "  {",
                        paste0("    name /ndn/edu/usalp",df[df$ip_address == neighbor[j],]$router_name),
                        paste0("    face-uri  udp://",neighbor[j]),
                        "    link-cost 25",
                        "  }",
                        sep = "\\\n")
      data <- ifelse(j == 1,tmp_data,paste(data,tmp_data,sep = "\\\n  "))
    }
    paste0("sed -i \"\" -e 's@<neighbor>@",data,"@g' ",my_file) %>% system()
    
    advertising <- strsplit(df$advertise_content[i],"\\{") %>% unlist()
    if(length(advertising) != 0){
      advertising_raw <- advertising[1]
      ad_length <- strsplit(advertising[2],"\\}") %>% unlist() %>% strsplit(.,"\\.\\.") %>% unlist() %>% as.numeric()
      for (j in ad_length[1]:ad_length[2]) {
        tmp_data <- paste( paste0("  prefix ",advertising_raw,j),sep = "\\\n")
        data <- ifelse(j == 1,tmp_data,paste(data,tmp_data,sep = "\\\n"))
      }
      data <- paste("advertising","{",data,"}",sep = "\\\n")
      paste0("sed -i \"\" -e 's@#<advertising> # advertise content@",data,"@g' ",my_file) %>% system()
    }
  }
}

makeDockerfile <- function(){
  dir <- paste0("./Dockerfiles/",CONF_NAME)
  if(system(paste0("test -d ",dir)) == 1) system(paste0("mkdir ",dir))
  paste0("cp ./configuration/material/Dockerfile ",dir) %>% system()
  my_file <- paste0(dir,"/Dockerfile")
  paste0("sed -i \"\" -e 's@<name>@",CONF_NAME,"@g' ",my_file) %>% system()
  for (i in 1:nrow(df)) {
    tmp_data <- paste(paste0("mkdir ",df$state_dir[i],ifelse(i!=nrow(df)," \\&\\& \\\\","")))
    data <- ifelse(i == 1,tmp_data,paste(data,tmp_data,sep = "\\\n"))
  }
  paste0("sed -i \"\" -e 's@#<mkdir>@",data,"@g' ",my_file) %>% system()
  
}

makeAppleScript <- function(){
  dir <- paste0("./appleScript/",CONF_NAME)
  if(system(paste0("test -d ",dir)) == 1) system(paste0("mkdir ",dir))
  paste0("cp ./configuration/material/prepare.txt ",dir) %>% system()
  my_file <- paste0(dir,"/prepare.txt")
  (max_num <- nrow(df)) %>% paste0("sed -i \"\" -e 's@<max_num>@",.,"@g' ",my_file) %>% system()
  (max_num - 5)         %>% paste0("sed -i \"\" -e 's@<edge_num2>@",.,"@g' ",my_file) %>% system()
  (max_num - 8)         %>% paste0("sed -i \"\" -e 's@<edge_num>@",.,"@g' ",my_file) %>% system()
  (max_num - 9)         %>% paste0("sed -i \"\" -e 's@<center_num2>@",.,"@g' ",my_file) %>% system()
  paste0("sed -i \"\" -e 's@<center_num>@",2,"@g' ",my_file) %>% system()
  for (i in 1:nrow(df)) {
    face_create <- strsplit(df$neighbors[i],",")  %>% unlist() %>% paste0("nfdc face create udp://", .,collapse = " ; ")
    tmp_data <- paste(
      paste0(ifelse(i==1,"if","\t\telse if")," num = ",i," then"),
      paste0("\t\t\tdo script \"",face_create," \\&\\& nlsr -f my_conf/",df$X[i],"/nlsr.conf\" in front window"),
      sep = "\\\n")
    data <- ifelse(i == 1,tmp_data,paste(data,tmp_data,sep = "\\\n  "))
  }
  data <- paste(data,"end if",sep = "\\\n  ")
  paste0("sed -i \"\" -e 's@<processing>@",data,"@g' ",my_file) %>% system()
}

makeConfiguration()
makeDockerfile()
makeAppleScript()