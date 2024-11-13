library("tidyverse")
panel<-read.csv("panel.csv")

###Add UTCI ### {{{

district_names = c("Southwestern", "Southern", "Western", "Northern", "Eastern", "Northeastern", "Southeastern", "Central", "Northwestern")
utci<-read.csv("data/temp_daily_by_pd.csv") %>%
    mutate(policeDistrict = district_names[PD]) %>%
    rename(date=DATE, UTCI=TEMP) %>%
    select(date, policeDistrict, UTCI)
panel_utci<-left_join(x=panel, y=utci, by=c("date", "policeDistrict")) %>%
    filter(!is.na(UTCI))

### }}}

write.csv(panel_utci, "panel_utci.csv", row.names=FALSE)
