## code to prepare `scenario_rdrshp` dataset goes here

library(dplyr)
library(readxl)
library(janitor)

scenario_rdrshp <- read_xlsx(path = "data-raw/scenario_rdrshp.xlsx") %>%
  clean_names()



usethis::use_data(scenario_rdrshp, overwrite = TRUE)
