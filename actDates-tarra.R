install.packages("tidyverse")
library("tidyverse")

days<-read.csv("terra-files.txt")

#X is the column with the full file URL
day2<-days %>%
  mutate(actual_date= substr(days, 87, 93)) |>
  mutate(filename=substr(days, 148, 164))

write.csv(day2, "datesTerra.csv", row.names = FALSE)

