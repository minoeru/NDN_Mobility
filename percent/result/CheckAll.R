par(family= "HiraKakuProN-W3")

result_df <- read.csv("result.csv")
sum_df <- read.csv("sum.csv")

core <- c(1:11)
edge <- c(1:11)
# packetNum <- matrix(as.matrix(sum_df[,2:12]), 11, 11)
# persp(core, edge, packetNum,theta = 30, phi = 30, expand = 1, col = "lightblue",ticktype = "detailed")

# NoRoute <- matrix(as.matrix(result_df[,2:12]), 11, 11)
# persp(core, edge, NoRoute,theta = 30, phi = 30, expand = 1, col = "lightblue",ticktype = "detailed")

mix_df <- sum_df[,2:12] * result_df[,2:12]
value <- matrix(as.matrix(mix_df), 11, 11)
persp(core, edge, value,theta = 140, phi = 30, expand = 1, col = "lightblue",ticktype = "detailed",xlab = "コアルータの広告確率 (%)",ylab = "エッジルータの広告確率 (%)",zlab = "影響度")