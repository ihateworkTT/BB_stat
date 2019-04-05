#Set working directory
setwd("~/R")

#file importing
bb_stat <- read.csv("bb_stat.csv")
names(bb_stat)[1] <- c("Year")

bb_stat

library(ggplot2)

#Average by team
ggplot(data=bb_stat, aes(x=Team, y=AVG, fill=Team))+geom_bar(stat="identity")+ggtitle("2018, Average")+coord_cartesian(ylim=c(0.25,0.31))

#On base Plus Slugging team
ggplot(data=bb_stat, aes(x=Team, y=OPS, fill=Team))+geom_bar(stat="identity")+ggtitle("2018, OPS")+coord_cartesian(ylim=c(0.65,0.9))

#OPS = OBP + SLG by team
library("tidyr")
bb_stat1 <- bb_stat[,c(1,2,4,5,6)]
bb_stat1_long <- gather(bb_stat1, Type, Stat, OBP:SLG, factor_key=TRUE)
head(bb_stat1_long)
ggplot(data=bb_stat1_long, aes(x=Team, y=Stat, fill=Type))+geom_bar(position=position_dodge(), stat="identity")+ggtitle("OBP=On Base Percentage, SLG=Slugging Average")+coord_cartesian(ylim=c(0.3,0.5))
#or stacked bar graph
ggplot(data=bb_stat1_long, aes(x=Team, y=Stat, fill=Type))+geom_bar(position="stack", stat="identity")+ggtitle("OBP=On Base Percentage, SLG=Slugging Average")

#ERA by team
ggplot(data=bb_stat, aes(x=Team, y=ERA, fill=Team))+geom_bar(stat="identity")+ggtitle("2018, ERA")+coord_cartesian(ylim=c(4.5,5.5))

#FIP by team
ggplot(data=bb_stat, aes(x=Team, y=FIP, fill=Team))+geom_bar(stat="identity")+ggtitle("2018, FIP")+coord_cartesian(ylim=c(4.5,5.75))

#ERA vs FIP
bb_stat2 <- bb_stat[,c(1,2,7,8)]
bb_stat2_long <- gather(bb_stat2, Type, Stat, ERA:FIP, factor_key=TRUE)
head(bb_stat2_long)
ggplot(data=bb_stat2_long, aes(x=Team, y=Stat, fill=Type))+geom_bar(position=position_dodge(), stat="identity")+ggtitle("2018 ERA vs FIP")+coord_cartesian(ylim=c(4.5,5.75))+geom_rect(mapping=aes(xmin=8.5, xmax=9.5, ymin=0, ymax=5.2), color="red", fill=NA, size=1.5)
	, alpha=0.03)

#WHIP by Team
ggplot(data=bb_stat, aes(x=Team, y=WHIP, fill=Team))+geom_bar(stat="identity")+ggtitle("2018, WHIP")+coord_cartesian(ylim=c(1.2,1.6))