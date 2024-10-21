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
    rename("Daily.Mean.PM25.ug/m3.LC" = "Daily.Mean.PM2.5.Concentration")
# TODO: handle NA, because pollution is not reported sometimes for some reason
panel_ext<-left_join(x=panel, y=pollution, by="date")
### }}}

### TODO: Add Weather ### {{{
weather<-read.csv("data/NCDC_weather.csv") %>%
    select(everything() & !(STATION | NAME)) %>% # remove irrelvent columns
    rename("date"="DATE", #TODO: rename the rest of the columns
           "avg. daily windspeed (mi/hr)"="AWND") 
    # TODO: make the top wind vars better, and handle NAs
panel_ext<-left_join(x=panel, y=weather, by="date")

### }}}

### TODO: Add Green Coverage ###

write.csv(panel_ext, "panel_ext.csv", row.names=FALSE)
