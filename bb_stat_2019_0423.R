#file importing
library(RCurl)
x<-getURL("https://raw.githubusercontent.com/ihateworkTT/BB_stat/master/bb_ind_pitcher_stat.csv")
bb_stat <- read.csv(text=x)
names(bb_stat)[1] <- c("Year")
head(bb_stat)
bb_stat[14,]

#ERA
library(ggplot2)

#ERA accross the time
ggplot(bb_stat[-15,], aes(x=Year, y=ERA, label=Year, color="#F20017")) + geom_line() + geom_point() + geom_text(nudge_y = 0.1) + ggtitle("ERA")+theme_minimal()+theme(legend.position = "none")

#BB/9 vs SO/9
bb_stat <- transform(bb_stat, BBper9=BB/IP*9, SOper9=K/IP*9)

plot_BBper9 <- ggplot(bb_stat[-15,], aes(x=Year, y=BBper9, label=Year, color="#F20017"))+geom_point()+geom_line()+geom_text(nudge_y=0.1)+ggtitle("BB/9") + theme(legend.position = "none")+coord_cartesian(ylim=c(2,9))
plot_SOper9 <- ggplot(bb_stat[-15,], aes(x=Year, y=SOper9, label=Year, color="#F20017"))+geom_point()+geom_line()+geom_text(nudge_y=0.1)+ggtitle("K/9") + theme(legend.position = "none")+coord_cartesian(ylim=c(2,9))

library(gridExtra)
grid.arrange(plot_BBper9, plot_SOper9, ncol=2)


bb_stat[bb_stat$Year==2013,]
