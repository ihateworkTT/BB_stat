#file importing
library(RCurl)
x<-getURL("https://raw.githubusercontent.com/ihateworkTT/BB_stat/master/bb_ind_hitter_stat.csv")
bb_stat <- read.csv(text=x)
names(bb_stat)[1] <- c("Year")
head(bb_stat)

#calculate basic stat (AVG, OBP, SLG, OPS)
bb_stat <- transform(bb_stat, AVG = round(H/AB,3), OBP=round((H+BB+HBP)/(AB+BB+HBP+SH+SF),3), SLG=round(((H-B2-B3-HR)+B2*2+B3*3+HR*4)/AB,3))
bb_stat <- transform(bb_stat, OPS = OBP + SLG)

#AVG < 0.3
bb_stat1 <- bb_stat[bb_stat$AVG<0.3,]
bb_stat1


transform(bb_stat, PorC = ifelse(OBP>SLG,1,-1))

bb_stat[c(order(bb_stat$HR, decreasing=TRUE)),]
max(bb_stat$SLG)
min(bb_stat$SLG)

library(ggplot2)
