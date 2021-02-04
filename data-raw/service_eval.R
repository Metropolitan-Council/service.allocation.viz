## code to prepare `se` dataset series goes here

library(dplyr)
library(readxl)
library(janitor)
library(stringr)
options(scipen = 99999)


# Base --------------------------------------------------------------------

## code to prepare `se_base` dataset goes here

se_base <- read_xlsx(path = "data-raw/service_eval_base.xlsx") %>%
  clean_names() %>%
  mutate(
    scenario_short = case_when(
      stringr::str_detect(buffer_name, "Base") ~ "Base",
      stringr::str_detect(buffer_name, "Regional") ~ "Regional Total",
      TRUE ~ stringr::str_sub(buffer_name, end = 10L)
    ),
    pop_type = case_when(
      stringr::str_detect(buffer_name, "Expand") ~ "Expand",
      stringr::str_detect(buffer_name, "Improve") ~ "Improve"
    )
  ) %>%
  mutate(
    service_type = case_when(
      stringr::str_detect(buffer_name, "HFT") ~ "High frequency",
      stringr::str_detect(buffer_name, "Local") ~ "Local",
      stringr::str_detect(buffer_name, "Basic") ~ "Basic",
      stringr::str_detect(buffer_name, "CE") ~ "Commuter express",
      stringr::str_detect(buffer_name, "DR") ~ "Demand response"
    ),
    time_type = case_when(stringr::str_detect(buffer_name, "All Day") ~ "All day", )
  )


# usethis::use_data(se_base, overwrite = TRUE)




# By TMA ------------------------------------------------------------------

se_by_tma <- read_xlsx(path = "data-raw/service_eval_by_tma.xlsx") %>%
  clean_names()

se_by_tma %>%
  mutate(
    scenario_short = case_when(
      stringr::str_detect(buffer_name, "Base") ~ "Base",
      TRUE ~ stringr::str_sub(buffer_name, end = 10L)
    ),
    pop_type = case_when(
      stringr::str_detect(buffer_name, "Expand") ~ "Expand",
      stringr::str_detect(buffer_name, "Improve") ~ "Improve"
    )
  ) %>%
  mutate(
    service_type = case_when(
      stringr::str_detect(buffer_name, "HFT") ~ "High frequency",
      stringr::str_detect(buffer_name, "Local") ~ "Local",
      stringr::str_detect(buffer_name, "Basic") ~ "Basic",
      stringr::str_detect(buffer_name, "CE") ~ "Commuter express",
      stringr::str_detect(buffer_name, "DR") ~ "Demand response"
    ),
    time_type = case_when(stringr::str_detect(buffer_name, "All Day") ~ "All day", )
  ) %>%
  View()





# Clean -------------------------------------------------------------------

se_population_type <- read_xlsx("data-raw/service_eval_clean.xlsx") %>%
  clean_names() %>%
  rename(scenario = x1) %>%
  mutate(
    scenario_short = case_when(
      stringr::str_detect(scenario, "Base") ~ "Base",
      TRUE ~ stringr::str_sub(scenario, end = 10L)
    ),
    pop_type = case_when(
      stringr::str_detect(scenario, "Expand") ~ "Expand",
      stringr::str_detect(scenario, "Improve") ~ "Improve"
    )
  ) %>%
  filter(!is.na(pop_type))


se_level_of_service <- read_xlsx("data-raw/service_eval_clean.xlsx") %>%
  clean_names() %>%
  rename(scenario = x1) %>%
  mutate(
    scenario_short = stringr::str_sub(scenario, end = 10L),
    pop_type = case_when(
      stringr::str_detect(scenario, "Expand") ~ "Expand",
      stringr::str_detect(scenario, "Improve") ~ "Improve"
    )
  ) %>%
  filter(is.na(pop_type)) %>%
  mutate(service_type = case_when(
    stringr::str_detect(scenario, "High Freq") ~ "High frequency",
    stringr::str_detect(scenario, "Local") ~ "Local",
    stringr::str_detect(scenario, "Basic") ~ "Basic",
    stringr::str_detect(scenario, "CE") ~ "Commuter express"
  ))
