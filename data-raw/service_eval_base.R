## code to prepare `service_eval_base` dataset goes here

library(dplyr)
library(readxl)
library(janitor)

service_eval_base <- read_xlsx(path = "data-raw/service_eval_base.xlsx") %>%
  clean_names()


usethis::use_data(service_eval_base, overwrite = TRUE)
