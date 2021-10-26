https://imagebreed.org/brapi/v2/observationunits?studyDbId=241&access_token=uzuibmdinprjdbrmihidccugrjrudlcctgjayrujrltfozsouwthbrpajxqubmtwbhvpywz
https://imagebreed.org/brapi/v2/observations?studyDbId=241&access_token=uzuibmdinprjdbrmihidccugrjrudlcctgjayrujrltfozsouwthbrpajxqubmtwbhvpywz

###### Read in libraries ######
library(jsonlite)

###### Specify study IDs ######
studies <- c(241)

###### Download, reformat, and save JSON file for each study ######
key <- readLines("V2/api_key.txt")
base_url <- "https://imagebreed.org"
observation_base_url <- paste0(base_url, "/brapi/v2/observations")

for(study in studies){
  observation_url <- paste0(observation_base_url, "?studyDbId=", study, "&pageSize=2", "&access_token=", key)
  #observation_list <- fromJSON(observation_url)
  # observation_json <- list(studyDbId = as.character(study), data = observation_list)
  # observation_json_final <- list(studies = list(observation_json))
  # write(toJSON(observation_json_final, pretty = TRUE, auto_unbox = TRUE),
  #       file = paste0("V2/observation_", study, ".json"))
}
