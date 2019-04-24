#file importing
library(RCurl)
x<-getURL("https://raw.githubusercontent.com/ihateworkTT/BB_stat/master/bb_team_stat.csv")
bb_stat <- read.csv(text=x)
names(bb_stat)[1] <- c("Year")
head(bb_stat)

#KMG... Select the team he coached hitting...
bb_stat1 <- bb_stat[bb_stat$Year>=2006&bb_stat$Year<=2011&bb_stat$Team=="LD",]
bb_stat2 <- bb_stat[bb_stat$Year>=2012&bb_stat$Year<=2013&bb_stat$Team=="LG",]
bb_stat3 <- bb_stat[bb_stat$Year>=2017&bb_stat$Year<=2019&bb_stat$Team=="SK",]

bb_stat_KMG <- rbind(bb_stat1, bb_stat2, bb_stat3)
bb_stat_KMG <- transform(bb_stat_KMG, PostYear=Year-2005)

a <- ncol(bb_stat_KMG)

bb_stat_KMG[c(7,11),a] <- 1
bb_stat_KMG[c(8,9),a] <- 2
bb_stat_KMG[10,a] <-3

bb_stat_KMG$PostYear 
bb_stat_KMG

#Let's see, the hitting performance accross the time
library(ggplot2)
plot_AVG <- ggplot(bb_stat_KMG, aes(x=PostYear, y=AVG, group=Team, colour=Team, label=Year))+geom_line()+geom_point(size=3)+scale_colour_manual(values=c("#FF9900", "#000000", "#FF3333"))+ggtitle("Average")+geom_text(nudge_y=0.003)
plot_AVG

#Let's see in detail
#1. Fourtune? BABIP = (H-HR)/(AB-K-HR+SF)
plot_AVG <- plot_AVG + coord_cartesian(ylim=c(0.24,0.34))
plot_BABIP <- ggplot(bb_stat_KMG, aes(x=PostYear, y=BABIP, group=Team, colour=Team, label=Year))+geom_line()+geom_point(size=3)+ggtitle("BABIP")+scale_colour_manual(values=c("#FF9900", "#000000", "#FF3333"))+geom_text(nudge_y=0.003)+coord_cartesian(ylim=c(0.24,0.34))

library(gridExtra)
grid.arrange(plot_AVG, plot_BABIP, ncol=2)

#2. BB/K
bb_stat_KMG <- transform(bb_stat_KMG, BBperK=BB/K)
ggplot(bb_stat_KMG, aes(x=PostYear, y=BBperK, group=Team, colour=Team, label=Year))+geom_line()+geom_point(size=3)+geom_text(nudge_y=0.015)+ggtitle("BB/K")+scale_colour_manual(values=c("#FF9900", "#000000", "#FF3333"))

#3. Homerun? Fly ball? decreasing Sulgging?
plot_slg<-ggplot(bb_stat_KMG, aes(x=PostYear, y=SLG, group=Team, colour=Team, label=Year))+geom_line()+geom_point(size=3)+ggtitle("SLG: Slugging percentage")+scale_colour_manual(values=c("#FF9900", "#000000", "#FF3333"))+geom_text(nudge_y=0.005)

bb_stat_KMG <- transform(bb_stat_KMG, HRperAB=HR/AB)
plot_HRperAB <- ggplot(bb_stat_KMG, aes(x=PostYear, y=HRperAB, group=Team, colour=Team, label=Year))+geom_line()+geom_point(size=3)+ggtitle("HomeRun / At Bat")+geom_text(nudge_y=0.003)+scale_colour_manual(values=c("#FF9900", "#000000", "#FF3333"))

grid.arrange(plot_slg, plot_HRperAB, ncol=2)

# Why decreasing HR????
#3-1. tooooooo much fast swing?
bb_stat_KMG[1:2,]

plot_NPperPA <- ggplot(bb_stat_KMG, aes(x=PostYear, y=NPperPA, group=Team, colour=Team, label=Year))+geom_line()+geom_point(size=3)+ggtitle("the Number of pitching / Plate apperances")+geom_text(nudge_y=0.015)+scale_colour_manual(values=c("#FF9900", "#000000", "#FF3333"))+ylim(3.7,4)
plot_NPperPA_2018 <- ggplot(bb_stat[bb_stat$Year==2018,], aes(x=Team, y=NPperPA, group=Team, fill=Team, Label=Team))+geom_bar(stat="identity")+coord_cartesian(ylim=c(3.7,4))+geom_hline(yintercept=mean(bb_stat[bb_stat$Year==2018,]$NPperPA))+ggtitle("the Number of pitching/Plate appearance on 2018")

grid.arrange(plot_NPperPA, plot_NPperPA_2018, ncol=2)

mean(bb_stat[bb_stat$Year==2018,]$NPperPA)

#3-2. the fly distance of hittings is decreasing?
plot_ivso <- ggplot(bb_stat_KMG, aes(x=PostYear, group=Team, colour=Team))+ylab("%")+scale_colour_manual(values=c("#FF9900", "#000000", "#FF3333")) +geom_point(aes(y=Infield), size=3)+geom_line(aes(y=Infield))+annotate("text", x=2, y=43, label="Infield") + geom_point(aes(y=Outfield), size=3)+geom_line(aes(y=Outfield))+annotate("text", x=2, y=57, label="Outfield") + ggtitle("Infield vs Outfield")
plot_FOperGO <- ggplot(bb_stat_KMG, aes(x=PostYear, y=FOperGO, group=Team, colour=Team))+geom_point(size=3)+geom_line() + ggtitle("FlyOut/GroundOut")+scale_colour_manual(values=c("#FF9900", "#000000", "#FF3333"))

grid.arrange(plot_ivso, plot_FOperGO, ncol=2)