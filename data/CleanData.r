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

# attach call data
df_calls1 <- df_calls %>%
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

df_call_freq1 <- merge(df_callFreq0, df_calls1, all.x = TRUE)
df_call_freq2 <- df_call_freq1 %>%
  mutate(callFreq = ifelse(is.na(callFreq), 0, callFreq))

df_call_freq <- df_call_freq2

df_parks0 <- read.csv("Parks.csv")

df_parks1 <- df_parks0 %>%
  mutate(policeDistrict = policeDstrct) %>%
  group_by(policeDistrict) %>%
  tally()

# TODO: split the strings here
df_parks2 <- df_parks1 %>%
  mutate()

# write.csv(df_call_freq, "callFrequency.csv")
