
path<-"G:/Shared drives/2024 FIRE-SA/DATA/ERA5/"

folders<-dir(path)

library("terra")

f<-1 #folder number
i<-1 #file number

files<-dir(paste0(path, folders[f]))

utci <- rast(paste0(path, folders[f],"/", files[i]))
crs(utci)<-"WGS84"

pd <- vect("Police_Districts_2023/Police_Districts_2023.shp")
pd_proj<-project(pd, crs(utci))

d <- terra::crop(x = utci, y=pd_proj, snap="in", mask=TRUE)

d_df<-extract(d, pd_proj, "mean", na.rm=TRUE)

plot(pd_proj)
plot(d, "utci_2", add=TRUE, alpha=0.5)
