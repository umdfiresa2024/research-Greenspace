# Extends the exising panel by adding pollution, weather, and greeness

library("tidyverse")
panel<-read.csv("panel.csv")

###Add PM2.5 ### {{{

pm21<-read.csv("data/EPA/pm25_2021.csv")
pm22<-read.csv("data/EPA/pm25_2022.csv")
pm23<-read.csv("data/EPA/pm25_2023.csv")

pollution <- rbind(pm21, pm22, pm23) %>%
    mutate(date=sapply(mdy(Date), function(d) sprintf("%s", d))) %>% # trust
    select(date, Daily.Mean.PM2.5.Concentration) %>%
    rename("PM25" = "Daily.Mean.PM2.5.Concentration")
panel_ext<-left_join(x=panel, y=pollution, by="date")
### }}}

### Add Weather ### {{{
weather<-read.csv("data/NCDC_weather.csv") %>%
    select(everything() & !(STATION | NAME)) %>% # remove irrelvent columns
    rename("date"="DATE") 
    weather[is.na(weather)] <-0 # clear NAs
panel_ext2<-left_join(x=panel_ext, y=weather, by="date")

### }}}

### TODO: Add Green Coverage ###

write.csv(panel_ext2, "panel_ext.csv", row.names=FALSE)
