library("ggplot2")
library("dplyr")

df_parkcalls <- read.csv("../data/ParkCall.csv")
df_meanCallSeason<- df_parkcalls %>%
	group_by(policeDistrict, Season) %>%
	summarise(nParks = median(nParks),
		  avgCallM = mean(callFreq))

ggplot(df_meanCallSeason, aes(x=Season, y=avgCallM, color=nParks)) +
	geom_point() + 
	labs(title = "Parks and Season on Emergency Calls",
	     x="Month Group", 
	     y="Mean monthly calls")
