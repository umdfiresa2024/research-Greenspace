library("dplyr")
df_calls <- read.csv("911BehavioralHealthDiversion.csv")
#Entries are identified by police district, year, and month
#for each entry we observe call frequency, number of trees, and whether the month is peak fly activity

#identifying variables
pd_names <-c("Central","Eastern","Northeastern","Northern","Northwestern","Southeastern","Southern","Southwestern","Western")
time_y <- 2021:2024
time_m <- 1:12
df0 <- data.frame(policeDistrict=rep(pd_names, times=length(time_m)*length(time_y)),
		    year=rep(time_y, times=length(time_m), each=length(pd_names)),
		    month=rep(time_m, each=length(pd_names)*length(time_y))) %>%
	filter((year > 2021 | month >= 6) & (year < 2024 | month <= 1))
#attatch call data
df1 <- df_calls %>%
	mutate(year=as.numeric(substring(callDateTime,1,4)),
		month=as.numeric(substring(callDateTime,6,7))) %>%
	group_by(month,year,policeDistrict) %>%
	summarise(callFreq=n())
df2 <- merge(df0, df1,all.x=TRUE)
df3 <- df2 %>%
	mutate(callFreq=ifelse(is.na(callFreq),0,callFreq))
df3
write.csv(df3,"callFrequency.csv")
