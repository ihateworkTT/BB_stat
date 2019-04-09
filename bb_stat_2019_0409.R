#file importing
library(RCurl)
x<-getURL("https://raw.githubusercontent.com/ihateworkTT/BB_stat/master/bb_ind_hitter_stat.csv")
bb_stat <- read.csv(text=x)
names(bb_stat)[1] <- c("Year")
head(bb_stat)

#AVG < 0.3
bb_stat1 <- bb_stat[bb_stat$AVG<0.3,]

#regual AB
nrow(bb_stat)
#the numbe of the hitter, Average < 0.3
nrow(bb_stat1)

transform(bb_stat, PorC = ifelse(OBP>SLG,1,-1))

bb_stat[c(order(bb_stat$HR, decreasing=TRUE)),]
max(bb_stat$SLG)
min(bb_stat$SLG)

library(ggplot2)
