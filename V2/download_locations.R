###### Read in libraries ######
library(jsonlite)

###### Specify study IDs ######
studies <- c(241)

###### Download, reformat, and save JSON file for each study ######
key <- readLines("V2/api_key.txt")
base_url <- "https://imagebreed.org"
study_base_url <- paste0(base_url, "/brapi/v2/studies")
location_base_url <- paste0(base_url, "/brapi/v2/locations")

for(study in studies){
  study_url <- paste0(study_base_url, "/", study, "?access_token=", key)
  study_list <- fromJSON(study_url)
  study_json <- list(studyDbId = as.character(study), data = study_list)
  location_id <- study_json$data$result$locationDbId
  location_url <- paste0(location_base_url, "/", location_id, "?access_token=", key)
  location_list <- fromJSON(location_url)
  location_json <- list(locationDbId = as.character(location_id), data = location_list)
  location_json_final <- list(locations = list(location_json))
  write(toJSON(location_json_final, pretty = TRUE, auto_unbox = TRUE), 
        file = paste0("V2/location_", study, ".json"))
}
