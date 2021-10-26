###### Read in libraries ######
library(jsonlite)

###### Specify study IDs ######
studies <- c(241)

###### Download, reformat, and save JSON file for each study ######
key <- readLines("V2/api_key.txt")
base_url <- "https://imagebreed.org"
germplasm_base_url <- paste0(base_url, "/brapi/v2/germplasm")

for(study in studies){
  germplasm_url <- paste0(germplasm_base_url, "?studyDbId=", study, "&access_token=", key)
  germplasm_list <- fromJSON(germplasm_url)
  germplasm_json <- list(studyDbId = as.character(study), data = germplasm_list)
  germplasm_json_final <- list(germplasms = list(germplasm_json))
  write(toJSON(germplasm_json_final, pretty = TRUE, auto_unbox = TRUE),
        file = paste0("V2/germplasm_", study, ".json"))
}
