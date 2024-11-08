library("tidyverse")
library("terra")
library("lubridate")

police_districts_path<-"Police_Districts_2023/Police_Districts_2023.shp"
top_path<-"G:\\Shared drives\\2024 FIRE-SA\\DATA\\ERA5\\"
group_name<-c("Jan-Mar 2021 DataSet.zip",
              "Apr-June 2021 DataSet.zip",
              "July-Sept 2021 DataSet.zip",
              "Oct-Dec 2021 DataSet.zip",
              "Jan-Mar 2022 DataSet.zip",
              "Apr-June 2022 DataSet.zip",
              "July-Sept 2022 DataSet.zip",
              "Oct-Dec 2022 DataSet.zip",
              "Jan-Mar 2023 DataSet.zip",
              "Apr-June 2023 DataSet.zip",
              "July-Sept 2023 DataSet.zip",
              "Oct-Dec 2023 DataSet.zip")


# Get temp for each police district
pd<- vect(police_districts_path)
crop_utci <- function(utci) {
  pd_proj<-project(pd, crs(utci))
  utci_pd<-terra::crop(x=utci, y=pd_proj, snap="out", mask=TRUE)
  df<-terra::extract(utci_pd, pd_proj, fun="mean", na.rm=TRUE)
  return(df)
}

df_for_day<-function(fname) {
  path = paste0("tmp\\", fname)
  date<-ymd(substring(fname, 12, 19))
  print(sprintf("Day: %s", date))

  r <- rast(path)
  tmp_day_n<-crop_utci(r) %>%
    rowwise() %>%
    mutate(m= mean(c_across(starts_with("utci_")), na.rm=TRUE)) %>%
    ungroup() %>%
    select(ID, m) %>%
      rename(PD=ID, TEMP=m) %>%
      mutate(DATE=date) %>%
      relocate(DATE, .before=PD)
    return(tmp_day_n)
}

df_from_group<-function(group) {
  # Unzip group
  print(sprintf("unzipping %s", group))
  unzip(group, exdir="tmp")

  fnames<-list.files(path="tmp")
  df<-as_tibble(data.frame(DATE=as.Date(character()), PD=integer(), TEMP=double())) # create empty data frame
  for (fnm in fnames) {
    tmp_day_n<-df_for_day(fnm)
    df<-rbind(df, tmp_day_n)
  }
  # Cleanup
  unlink("tmp", recursive=TRUE)
  return(df)
}

dfs<-sapply(group_name, function(x) df_from_group(paste0(top_path,group_name)))
utci<-rbind(dfs)
export.csv(utci, "data\\temp_daily_by_pd.csv", row.names=FALSE)
