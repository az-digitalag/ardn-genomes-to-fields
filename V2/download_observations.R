###### Read in libraries ######
library(jsonlite)

###### Specify study IDs ######
studies <- c(241)
vars <- c(92193) #Grain Yield [bu/acre]

###### Download, reformat, and save JSON file for each study ######
key <- readLines("V2/api_key.txt")
base_url <- "https://imagebreed.org"
obs_base_url <- paste0(base_url, "/brapi/v2/observations")

for(study in studies){
  observations_json <- list()
  for(var in vars){
    pagesize_url <- paste0(obs_base_url, "?studyDbId=", study,
                           "&observationVariableDbId=", var, "&pageSize=2", 
                           "&access_token=", key)
    pagesize_download <- fromJSON(pagesize_url)
    pagesize_count <- 30 #pagesize_download$metadata$pagination$totalCount
    if (pagesize_count != 0) {
      observation_url <- paste0(obs_base_url, "?studyDbId=", study,
                                "&observationVariableDbId=", var, "&pageSize=", 
                                pagesize_count, "&access_token=", key)
      observation_list <- fromJSON(observation_url)
      observation_json <- list(studyDbId = as.character(study),
                               observationVariableDbId = as.character(var),
                               data = observation_list)
    }
    observations_json <- append(observations_json, list(observation_json))
    observations_json_final <- list(observed = observations_json)
  }
  write(toJSON(observations_json_final, pretty = TRUE, auto_unbox = TRUE),
        file = paste0("V2/observations_", study, ".json"))
}
