library(httr)
library(foreign)

shorten_puf <- function(full_puf) {
  stage_1 <- gsub("C-0", "", full_puf)
  stage_2 <- gsub("C-", "", stage_1)
  
  tolower(stage_2)
}

download_puf <- function(short_puf) {
  puf_base <- "http://meps.ahrq.gov/mepsweb/data_files/pufs/"
  puf_suffix <- "ssp.zip"
  
  zip_filename <- paste0(short_puf, "ssp.zip")
  filename <- paste0(short_puf, ".ssp")
  puf_url <- paste0(puf_base, zip_filename)
  download.file(puf_url, zip_filename)
  
  # unzip
  unzip(zip_filename, files = filename)
  saveName <- paste0(short_puf, ".csv")
  
  # read sas file and return as csv file
  mydata <- read.xport(filename)
  write.table(mydata, file = saveName, sep = ",")
}