library("ggplot2")
library("dplyr")

df_parkcalls <- read.csv("../data/ParkCall.csv")
df_meanCallSeason<- df_parkcalls %>%
	group_by(policeDistrict, Season) %>%
	summarise(nParks = median(nParks),
		  avgCallM = mean(callFreq),
		  subgroupSize = n(),
		  sdCallM = sd(callFreq))
groups <- unique(sprintf("%s (%s)",df_meanCallSeason$policeDistrict, df_meanCallSeason$nParks))
ggplot(data = df_meanCallSeason,
       aes(x=Season, y=avgCallM, fill = policeDistrict)) +
	geom_bar(stat="identity", position ="dodge") +
	scale_fill_discrete(name="District (#Parks)", labels=groups) +
	labs(x="Season", y="Mean Emergency Calls per Month",
	     title = "Call Frequency on Season and District")
write.csv(df_meanCallSeason, "plot_dataset.csv")
