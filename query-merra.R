
library(httr)

#read list of links to download from a text file
files<-read.table("G:/My Drive/2023 FIRE-SA/Lectures/2023 FIRE298 Week 4/merra-filelinks.txt")
files<-files$V1

#set folder to store the downloaded files
dl_dir <- "G:/My Drive/2023 FIRE-SA/Lectures/2023 FIRE298 Week 4/merra/"                                 
setwd(dl_dir)                                                

i<-1
files[i]

for (i in 1:length(files)) {
  
  #make the downloaded filename an abbreviated version of the original file name
  filename <-  tail(strsplit(files[i], "tavgM_2d_flx_Nx.")[[1]], n = 1) 
  
  # write file to disk 
  response <- GET(files[i], write_disk(filename, overwrite = TRUE), progress(),
                  authenticate("truangmas1812", "VulcanRoom#2207"), set_cookies("LC" = "cookies"))
  
  # Check to see if file downloaded correctly
  if (response$status_code == 200) {
    print(sprintf("%s downloaded at %s", filename, dl_dir))
  } else {
    print(sprintf("%s not downloaded. Verify that your username and password are correct in %s", filename, netrc))
  }
}

