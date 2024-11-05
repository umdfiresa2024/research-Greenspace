#install.packages("tidyverse")
library("tidyverse")

days<-read_table("terra-files.txt", col_names = FALSE)

#X is the column with the full file URL
day2<-days %>%
  mutate(actual_date= substr(X1, 84, 90)) |>
  mutate(filename=substr(X1, 145, 164))

lst<- read.csv("terra_lst.csv") 

library("terra")
pdshape<-vect("Police_Districts_2023/Police_Districts_2023.shp")
pdf<-as.data.frame(pdshape) |>
  select(OBJECTID, Dist_Name) |>
  rename(ID=OBJECTID)

lst2<-merge(lst, pdf, by="ID")

df<- merge(day2, lst2, by="filename") |>
  select(LST_Day_1km, LST_Night_1km, actual_date, Dist_Name) |>
  mutate(year=as.numeric(substr(actual_date, 1, 4))) |>
  mutate(doy=as.numeric(substr(actual_date, 5, 7))) 

df21<-df |>
  filter(year==2021) |>
  mutate(date=as.Date(doy, origin="2021-01-01"))

df22<-df |>
  filter(year==2022) |>
  mutate(date=as.Date(doy, origin="2022-01-01"))

df23<-df |>
  filter(year==2023) |>
  mutate(date=as.Date(doy, origin="2023-01-01"))

dfall<-rbind(df21, df22, df23)

df_long<-dfall |>
  mutate(temp_day_K=ifelse(is.na(LST_Day_1km), LST_Night_1km, LST_Day_1km)) |>
  mutate(temp_night_K=ifelse(is.na(LST_Night_1km), LST_Day_1km, LST_Night_1km)) |>
  filter(!is.na(temp_day_K)) |>
  rename(policeDistrict=Dist_Name) |>
  group_by(policeDistrict, date) |>
  summarize(temp_K=(temp_day_K+temp_night_K)/2)

######aggregate calls by date, day, night##########################################

calls<-read.csv("data/911BehavioralHealthDiversion.csv") |>
  mutate(time=as.numeric(substr(callDateTime, 12, 13))) |>
  mutate(date=as.Date(substr(callDateTime, 1, 10), format="%Y/%m/%d")) |>
  group_by(policeDistrict, date) |>
  tally() |>
  rename(callscount=n)

#########merge data#############################################################

dfm<-merge(df_long, calls, by=c("policeDistrict", "date"), all.x=TRUE) |>
  mutate(callscount=ifelse(is.na(callscount),0, callscount)) |>
  mutate(temp_F=(temp_K-273.15)*1.8+32)

write.csv(dfm, "panel.csv", row.names = F)
