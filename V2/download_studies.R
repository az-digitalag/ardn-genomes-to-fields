###### Read in libraries ######
library(jsonlite)

###### Specify study IDs ######
studies <- c(241)

###### Download, reformat, and save JSON file for each study ######
key <- readLines("V2/api_key.txt")
base_url <- "https://imagebreed.org"
study_base_url <- paste0(base_url, "/brapi/v2/studies")

for(study in studies){
  study_url <- paste0(study_base_url, "/", study, "?access_token=", key)
  study_list <- fromJSON(study_url)
  study_json <- list(studyDbId = as.character(study), data = study_list)
  study_json_final <- list(studies = list(study_json))
  write(toJSON(study_json_final, pretty = TRUE, auto_unbox = TRUE),
        file = paste0("V2/study_", study, ".json"))
}
