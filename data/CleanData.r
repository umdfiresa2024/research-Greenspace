setwd("data")
library("dplyr")

# Entries are identified by police district, year, and month
# for each entry we observe call frequency, number of trees,
# and whether the month is peak fly activity

# identifying variables
pd_names <- c(
  "Central",
  "Eastern",
  "Northeastern",
  "Northern",
  "Northwestern",
  "Southeastern",
  "Southern",
  "Southwestern",
  "Western"
)
time_y <- 2021:2024
time_m <- 1:12

df_calls0 <- read.csv("911BehavioralHealthDiversion.csv")

## I. attach call data
df_calls1 <- df_calls0 %>%
  mutate(
    year = as.numeric(substring(callDateTime, 1, 4)),
    month = as.numeric(substring(callDateTime, 6, 7))
  ) %>%
  group_by(month, year, policeDistrict) %>%
  summarise(callFreq = n())

df_call_freq0 <- data.frame(
  policeDistrict = rep(pd_names, times = length(time_m) * length(time_y)),
  year = rep(time_y, times = length(time_m), each = length(pd_names)),
  month = rep(time_m, each = length(pd_names) * length(time_y))
) %>%
  filter((year > 2021 | month >= 6) & (year < 2024 | month <= 1))

df_call_freq1 <- merge(df_call_freq0, df_calls1, all.x = TRUE)
df_call_freq2 <- df_call_freq1 %>%
  mutate(callFreq = ifelse(is.na(callFreq), 0, callFreq))

df_call_freq <- df_call_freq2

## II. add park data
df_parks0 <- read.csv("Parks.csv")

df_parks1 <- df_parks0 %>%
  mutate(policeDistrict = policeDstrct) %>%
  group_by(policeDistrict) %>%
  tally()

df_split_distr <-df_parks1 %>%
	filter(!(df_parks1$policeDistrict %in% pd_names))
#there are only 5 entries, dataframe will be updated manually
df_parks2 <-df_parks1
df_parks2$n[2] <-df_parks1$n[2] + 1 #Eastern
df_parks2$n[4] <-df_parks1$n[4] + 1 #Northeastern
df_parks2$n[5] <-df_parks1$n[5] + 3 #Northern
df_parks2$n[8] <-df_parks1$n[8] + 4 #Northwestern
df_parks2$n[10] <-df_parks1$n[10] + 1 #Southeastern
df_parks2$n[11] <-df_parks1$n[11] + 1 #Southern
df_parks2$n[12] <-df_parks1$n[12] + 3 #Southwestern
df_parks2$n[13] <-df_parks1$n[13] + 2 #Western
df_parks <-df_parks2 %>%
	filter(policeDistrict %in% pd_names) %>%
	rename(nParks = n)
## Combine columns
df_final <- merge(df_call_freq, df_parks)
write.csv(df_final, "ParkCall.csv")
