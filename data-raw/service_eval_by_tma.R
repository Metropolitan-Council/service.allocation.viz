## code to prepare `service_eval_by_tma` dataset goes here

library(dplyr)
library(readxl)
library(janitor)
library(stringr)

service_eval_by_tma <- read_xlsx(path = "data-raw/service_eval_by_tma.xlsx") %>%
  clean_names()

service_eval_by_tma %>%
  mutate(scenario_short = stringr::str_sub(buffer_name, end = 10L)) %>% View




usethis::use_data(service_eval_by_tma, overwrite = TRUE)
