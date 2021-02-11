## code to prepare `se` dataset series goes here

library(dplyr)
library(readxl)
library(janitor)
library(stringr)
library(tidyr)
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
    expand_improve = case_when(
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

se_by_tma_long <- se_by_tma %>%
  mutate(
    scenario_short = case_when(
      stringr::str_detect(buffer_name, "Base") ~ "Base",
      TRUE ~ stringr::str_sub(buffer_name, end = 10L)
    ),
    expand_improve = case_when(
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
    time_type = case_when(stringr::str_detect(buffer_name, "All Day") ~ "All day")
  ) %>%
  select(
    market_area,
    scenario_short,
    expand_improve,
    service_type,
    time_type,
    everything(),
    -buffer_name,
    -objectid,
    -shape_length,
    -shape_area
  ) %>%
  group_by(
    market_area,
    scenario_short,
    expand_improve,
    service_type,
    time_type
  ) %>%
  gather(
    pop_total,
    pov185,
    poc,
    seniors,
    zero_car_hh,
    afford_hous_units,
    jobs,
    low_inc_job,
    hi_inc_job,
    key = "item",
    value = "value"
  )





# Clean -------------------------------------------------------------------

se_population_type <- read_xlsx("data-raw/service_eval_clean.xlsx") %>%
  clean_names() %>%
  rename(scenario = x1) %>%
  mutate(
    scenario_short = case_when(
      stringr::str_detect(scenario, "Base") ~ "Base",
      TRUE ~ stringr::str_sub(scenario, end = 10L)
    ),
    expand_improve = case_when(
      stringr::str_detect(scenario, "Expand") ~ "Expand",
      stringr::str_detect(scenario, "Improve") ~ "Improve"
    )
  ) %>%
  filter(!is.na(expand_improve))


se_population_type_long <-
  se_population_type %>%
  select(
    scenario_short,
    expand_improve,
    everything(),
    -scenario,
    -pop_tma_1,
    -pop_tma_2,
    -pop_tma_3,
    -pop_tma_4,
    -pop_tma_5,
    -emp_tma_1,
    -emp_tma_2,
    -emp_tma_3,
    -emp_tma_4,
    -emp_tma_5
  ) %>%
  group_by(scenario_short, expand_improve) %>%
  tidyr::gather(
    pop_total,
    pop_pct,
    emp_total,
    emp_pct,
    poc_total,
    poc_pct,
    pov_total,
    pov_pct,
    aff_hu_total,
    aff_hu_pct,
    senior_total,
    senior_pct,
    lo_emp_total,
    lo_emp_pct,
    hi_emp_total,
    hi_emp_pct,
    key = "item",
    value = "value"
  ) %>%
  mutate(
    item_category = stringr::str_remove_all(item, "_total") %>%
      stringr::str_remove_all("_pct"),
    item_unit = ifelse(
      stringr::str_detect(item, "pct"),
      "pct",
      "total"
    )
  ) %>%
  select(-item) %>%
  spread(item_unit, value) %>%
  mutate(
    lab = paste0(
      "+",
      round(pct * 100),
      "% ",
      format(round(total), big.mark = ",")
    ),
    scenario_id = stringr::str_sub(scenario_short, start = -1L, end = -1L)
  ) %>%
  data.table::as.data.table()


usethis::use_data(se_population_type_long, overwrite = T)

se_level_of_service <- read_xlsx("data-raw/service_eval_clean.xlsx") %>%
  clean_names() %>%
  rename(scenario = x1) %>%
  mutate(
    scenario_short = stringr::str_sub(scenario, end = 10L),
    expand_improve = case_when(
      stringr::str_detect(scenario, "Expand") ~ "Expand",
      stringr::str_detect(scenario, "Improve") ~ "Improve"
    )
  ) %>%
  filter(!is.na(expand_improve)) %>%
  mutate(service_type = case_when(
    stringr::str_detect(scenario, "High Freq") ~ "High frequency",
    stringr::str_detect(scenario, "Local") ~ "Local",
    stringr::str_detect(scenario, "Basic") ~ "Basic",
    stringr::str_detect(scenario, "CE") ~ "Commuter express"
  )) %>%
  select(
    scenario_short,
    service_type,
    everything(),
    -scenario
  )
