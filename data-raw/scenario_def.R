## code to prepare `scenario_def` dataset goes here

library(dplyr)
library(readxl)
library(janitor)

scenario_def <- read_xlsx(path = "data-raw/scenario_def.xlsx", col_types = c("text",
                                                                             rep("numeric", 7),
                                                                             "text")) %>%
  clean_names() %>%
  rename(scenario = x1) %>%
  rowwise() %>%
  mutate(expanded_on_demand_service = case_when(expanded_on_demand_service == "Yes" ~ 1,
                                        TRUE ~ 0))





usethis::use_data(scenario_def, overwrite = TRUE)
