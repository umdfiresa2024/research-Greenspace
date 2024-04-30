library("ggplot2")
library("dplyr")

df_parkcalls <- read.csv("../data/ParkCall.csv")
#update time column (months since January 2021)
df_timecall<- df_parkcalls %>%
	mutate(time=(12*(year-2021)+month))
#the plot examines the corralation between time and calls
ggplot(df_timecall, aes(x=time, y=callFreq, color=policeDistrict)) +
	geom_line() +
	labs(x = "Months since January 2021", y="Call frequency for each police district")
