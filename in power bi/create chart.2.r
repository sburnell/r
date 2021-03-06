chartTitle <- paste("Top 5 Reject Rates for",format(sum(dataset$OpportunityCount,na.rm=TRUE),big.mark=",",scientific=FALSE));
chartTitle <- paste(chartTitle,"optys");
dataset$OpportunityRejectedCount[is.na(dataset$OpportunityRejectedCount)] <- 0;
library(ggplot2);
library(gridExtra);
library(dplyr);
df1 <- dataset[,c("Region","OpportunityRejectedCount","OpportunityCount")];
g1 <- group_by(df1,Region);
df1_2 <- (g1 %>% summarise_each(funs(sum))); 
df1_2$RejectedRate <- (df1_2$OpportunityRejectedCount / df1_2$OpportunityCount) * 100;
df1_2 <- df1_2[with(df1_2,order(-RejectedRate)),];
df1_3 <- head(df1_2,5);
c1 <- ggplot(df1_3,aes(x=RejectedRate,y=reorder(Region,RejectedRate))) + 
geom_point(size=3) + 
xlab("Rejection Rate") + 
ylab("Region") + 
labs(title = chartTitle)  + 
theme_bw() + 
theme(axis.text.x = element_text(angle=60, hjust=1),panel.grid.major.y = element_blank(),panel.grid.minor.y = element_blank(),panel.grid.major.x = element_line(colour="grey60", linetype="dashed")) + 
geom_segment(aes(yend=Region), xend=0, colour="red");
c1;
df2 <- dataset[,c("Program","OpportunityRejectedCount","OpportunityCount")];
g2 <- group_by(df2,Program);
df2_2 <- (g2 %>% summarise_each(funs(sum)));  
df2_2$RejectedRate <- (df2_2$OpportunityRejectedCount / df2_2$OpportunityCount) * 100;
df2_2 <- df2_2[with(df2_2,order(-RejectedRate)),];
df2_3 <- head(df2_2,5);
c2 <- ggplot(df2_3,aes(x=RejectedRate,y=reorder(Program,RejectedRate))) + 
geom_point(size=3) + 
xlab("Rejection Rate") + 
ylab("Program") + 
labs(title = " ")  + 
theme_bw() + 
theme(axis.text.x = element_text(angle=60, hjust=1),panel.grid.major.y = element_blank(),panel.grid.minor.y = element_blank(),panel.grid.major.x = element_line(colour="grey60", linetype="dashed")) + 
geom_segment(aes(yend=Program), xend=0,colour=c("red"));
c2;
df3 <- dataset[,c("OpportunityTeam","OpportunityRejectedCount","OpportunityCount")];
g3 <- group_by(df3,OpportunityTeam);
df3_2 <- (g3 %>% summarise_each(funs(sum)));  
df3_2$RejectedRate <- (df3_2$OpportunityRejectedCount / df3_2$OpportunityCount) * 100;
df3_2 <- df3_2[with(df3_2,order(-RejectedRate)),];
df3_3 <- head(df3_2,5);
c3 <- ggplot(df3_3,aes(x=RejectedRate,y=reorder(OpportunityTeam,RejectedRate))) + 
geom_point(size=3) + 
xlab("Rejection Rate") + 
ylab("Opportunity Team") + 
labs(title = " ")  + 
theme_bw() + 
theme(axis.text.x = element_text(angle=60, hjust=1),panel.grid.major.y = element_blank(),panel.grid.minor.y = element_blank(),panel.grid.major.x = element_line(colour="grey60", linetype="dashed")) + 
geom_segment(aes(yend=OpportunityTeam), xend=0, colour="red");
c3;
grid.arrange(c1,c2,c3, ncol = 3, nrow = 1);
