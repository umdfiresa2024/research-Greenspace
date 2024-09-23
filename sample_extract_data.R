install.packages('terra')
install.packages('tidyverse')
library("terra")
library("tidyverse")

#makes of list of files in that folder
files<-dir("G:/Shared drives/2024 FIRE Light Rail/DATA/GLDAS/")
filename<-substr(files, 1,8)

for(i in 1:length(files)){
  r<-rast(paste0("G:/Shared drives/2024 FIRE Light Rail/DATA/GLDAS/", files[i]))
  
  names(r)
  
  control_buffers<-vect("G:/Shared drives/2024 FIRE Light Rail/DATA/Control Shapefiles/interstate_buffers/interstate_buffers.shp")
  cb_proj<-project(control_buffers, crs(r))
  int<-crop(r, cb_proj,
            snap="in",
            mask=TRUE)
  
  #convert cropped raster into dataframe and find average value
  metdf<-terra::extract(int, control_buffers, fun="mean", na.rm=TRUE) 
  
  metdf$date<-files[i]
  
  
  
  write.csv(metdf, 
            paste0("G:/Shared drives/2024 FIRE Light Rail/DATA/cntrl_met_data/", 
                   filename[i],".csv"), 
            row.names = F)
  
}
