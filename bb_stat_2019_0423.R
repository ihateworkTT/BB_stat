#file importing
library(RCurl)
x<-getURL("https://raw.githubusercontent.com/ihateworkTT/BB_stat/master/bb_team_stat.csv")
bb_stat <- read.csv(text=x)
names(bb_stat)[1] <- c("Year")
head(bb_stat)
tail(bb_stat)

#KMG... Select the team he coached hitting...
bb_stat1 <- bb_stat[bb_stat$Year>=2006&bb_stat$Year<=2011&bb_stat$Team=="LD",]
bb_stat2 <- bb_stat[bb_stat$Year>=2012&bb_stat$Year<=2013&bb_stat$Team=="LG",]
bb_stat3 <- bb_stat[bb_stat$Year>=2018&bb_stat$Year<=2019&bb_stat$Team=="SK",]

bb_stat_KMG <- rbind(bb_stat1, bb_stat2, bb_stat3)
bb_stat_KMG <- transform(bb_stat_KMG, PostYear=Year-2005)

bb_stat_KMG[c(7,9),32] <- 1
bb_stat_KMG[c(8,10),32] <- 2

bb_stat_KMG$PostYear  

#Let's see, the hitting performance accross the time
library(ggplot2)

ggplot(bb_stat_KMG, aes(x=PostYear, y=AVG, group=Team, colour=Team))+geom_line()+geom_point()

#regual AB
nrow(bb_stat)
#the numbe of the hitter, Average < 0.3
nrow(bb_stat1)
bb_stat1
bb_stat2
bb_stat3



transform(bb_stat, PorC = ifelse(OBP>SLG,1,-1))

bb_stat[c(order(bb_stat$HR, decreasing=TRUE)),]
max(bb_stat$SLG)
min(bb_stat$SLG)


