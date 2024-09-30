#install.packages("tidyverse")
library("tidyverse")

days<-read_table("terra-files.txt", col_names = FALSE)

#X is the column with the full file URL
day2<-days %>%
  mutate(actual_date= substr(X1, 87, 93)) |>
  mutate(filename=substr(X1, 145, 164))

write.csv(day2, "datesTerra.csv", row.names = FALSE)

lst<- read.csv("terra_lst.csv") |>
  filter(!is.na(LST_Day_1km))

df<- merge(day2, lst, by="filename") 

olddata<-read.csv("data/callFrequency.csv")
