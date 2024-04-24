library("dplyr")
df_calls <- read.csv("911BehavioralHealthDiversion.csv")
df <- df_calls %>%
	mutate(Year=substring(callDateTime,1,4), #extract month and year from calls
		Month=substring(callDateTime,6,7))
write.csv(df,"data.csv")
