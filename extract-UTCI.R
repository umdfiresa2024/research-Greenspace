library("tidyverse")
library("terra")
library("lubridate")

police_districts_path<-"Police_Districts_2023/Police_Districts_2023.shp"
top_path<-"G:/Shared drives/2024 FIRE-SA/DATA/ERA5/"
group_name<-"Oct-Dec 2023 DataSet.zip"

# Get temp for each police district
pd<- vect(police_districts_path)
crop <- function(utci) {
    proj<-project(pd, crs(utci))
    slice<-terra::crop(x=utci, y=project, snap="in", mask=TRUE)
    df<-extract(slice, utci, "mean", na.rm=TRUE)
    return(df)
}

# Unzip group
# unzip(group_name, exdir="./tmp")

cd<-paste0(getwd(), "/tmp")
setwd(cd)
fnames<-list.files()

# Cleanup
# unlink("tmp", recursive=TRUE)


