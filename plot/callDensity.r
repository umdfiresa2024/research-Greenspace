library("ggplot2")
library("dplyr")

df_parkcalls <- read.csv("../data/ParkCall.csv")
df_perCallSeason <- df_parkcalls %>%
	mutate(callsOnSeason=ifelse(isFlySeason,callFreq,0),
	       callsOffSeason=ifelse(!isFlySeason,callFreq,0)) %>%
	group_by(policeDistrict) %>%
	summarise(nCallsOnSn=sum(callsOnSeason),
		  nCallsOffSn=sum(callsOffSeason),
		  nParks=median(nParks)) %>%
	mutate(perCallSn=(nCallsOnSn/(nCallsOffSn+nCallsOnSn)))

ggplot(df_perCallSeason, aes(x=nParks, y=perCallSn)) +
	geom_point() + 
	labs(title = "Number of Parks on proportion of emergency calls during Lantern Fly Season",
	     x="Number of Parks", 
	     y="% Calls during Lantern Fly Season")
