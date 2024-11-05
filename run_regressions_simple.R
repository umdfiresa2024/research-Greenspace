library("tidyverse")

df<-read.csv("panel.csv")
df2<-df %>%
  mutate(call_bin = ifelse(callscount>0, 1, 0)) %>%
  mutate(date = as.Date(date)) %>%
  mutate(month = month(date)) %>%
  mutate(dow = weekdays(date)) %>%
  mutate(year = year(date))

df3<-df2 %>%
  mutate(temp_over_100=ifelse(temp_F>100, 1, 0)) %>%
  mutate(temp_95_100=ifelse(temp_F> 95 & temp_F<=100, 1, 0)) %>%
  mutate(temp_90_95=ifelse(temp_F> 90 & temp_F<=95, 1, 0)) %>%
  mutate(temp_85_90=ifelse(temp_F> 85 & temp_F<=90, 1, 0)) %>%
  mutate(temp_80_85=ifelse(temp_F> 80 & temp_F<=85, 1, 0)) %>%
  mutate(temp_75_80=ifelse(temp_F> 75 & temp_F<=80, 1, 0)) %>%
  mutate(temp_70_75=ifelse(temp_F> 70 & temp_F<=75, 1, 0)) %>%
  mutate(temp_65_70=ifelse(temp_F> 65 & temp_F<=70, 1, 0)) %>%
  mutate(temp_60_65=ifelse(temp_F> 60 & temp_F<=65, 1, 0)) %>%
  mutate(temp_under_60=ifelse(temp_F<= 60, 1, 0))

holidays <- as.Date(c("2021-5-31", "2021-6-19", "2021-7-4","2021-9-6", "2021-11-2", 
                      "2021-11-25", "2021-11-26", "2021-12-24", "2021-12-25", 
                      "2021-12-26", "2021-12-27", "2021-12-28", "2021-12-29", 
                      "2021-12-30", "2021-12-31", "2022-1-1", "2022-1-2", 
                      "2022-1-17", "2022-2-18", "2022-2-21", "2022-3-18", 
                      "2022-4-11", "2022-4-12", "2022-4-13", "2022-4-14", 
                      "2022-4-15", "2022-4-16", "2022-4-17", "2022-4-18", 
                      "2022-5-30", "2022-6-19", "2022-7-4","2022-9-5", "2022-10-5", 
                      "2022-10-21", "2022-11-8", "2022-11-9", "2022-11-23", 
                      "2022-11-24", "2022-11-25", "2022-12-23", "2022-12-24", 
                      "2022-12-25", "2021-12-26", "2022-12-27", "2022-12-28", 
                      "2022-12-29", "2022-12-30", "2022-12-31", "2023-01-01", 
                      "2023-1-2", "2023-1-16", "2023-1-23", "2023-2-17", "2023-2-20", 
                      "2023-3-8", "2023-3-17", "2023-4-3", "2023-4-4", "2023-4-5", 
                      "2023-4-6", "2023-4-7", "2023-4-8", "2023-4-9", "2023-4-10", 
                      "2023-4-21", "2023-5-29",  "2023-6-19", "2023-7-4", 
                      "2023-9-4", "2023-10-20", "2023-11-22", "2023-11-23", 
                      "2023-11-24", "2023-12-22", "2023-12-23", "2023-12-24", 
                      "2023-12-25", "2023-12-26", "2023-12-27", "2023-12-28", 
                      "2023-12-29", "2023-12-30", "2023-12-31"))

df4 <- df3 %>%
  mutate(holiday_bin = ifelse(date %in% holidays, 1, 0)) %>%
  mutate(dow_month = paste0(dow, "-", as.character(month)))

library("lfe")

summary(model1<-felm(call_bin ~ temp_over_100 + temp_95_100 + temp_90_95 + temp_85_90 + 
                       temp_80_85 + temp_75_80 + temp_70_75 + temp_65_70 + temp_60_65 +
                       holiday_bin  | 
                       policeDistrict + year + dow_month, data=df4))

summary(model1<-felm(call_bin ~ temp_over_100 + temp_95_100 + temp_90_95 + temp_85_90 + 
                       temp_80_85 + temp_75_80 + temp_70_75 + temp_65_70 + temp_60_65 | 
                       policeDistrict + date, data=df4))

#regress by season
df5<-df4 |>
  filter(month>=4 & month<=9)

summary(m5 <- felm(call_bin ~ temp_over_100 + temp_95_100 + temp_90_95 + temp_85_90 + 
                      temp_80_85 + temp_75_80 + temp_70_75 + temp_65_70 + temp_60_65| 
                     policeDistrict + date, data=df5))

summary(model1<-felm(call_bin ~ temp_over_100 + temp_95_100 + temp_90_95 + temp_85_90 + 
                       temp_80_85 + temp_75_80 + temp_70_75 + temp_65_70 + temp_60_65 +
                       holiday_bin  | 
                       policeDistrict + year + dow_month, data=df5))

        