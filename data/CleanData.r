library("dplyr")
df_calls <- read.csv("911BehavioralHealthDiversion.csv")
#Entries are identified by police district, year, and month
#for each entry we observe call frequency, number of trees, and whether the month is peak fly activity
df <- df_calls %>%
	mutate(Year=as.numeric(substring(callDateTime,1,4)),
		Month=as.numeric(substring(callDateTime,6,7))) %>%
	group_by(policeDistrict, Year, Month) %>%
	summarise(callFreq=n())
write.csv(df,"callFrequency.csv")
