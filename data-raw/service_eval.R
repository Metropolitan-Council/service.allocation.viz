## code to prepare `se` dataset series goes here

library(dplyr)
library(readxl)
library(janitor)
library(stringr)
library(tidyr)
library(data.table)
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
    scenario_short = factor(
      scenario_short,
      levels = c(
        "Scenario 1",
        "Scenario A",
        "Scenario B",
        "Scenario C",
        "Scenario D",
        "Scenario E",
        "Scenario 2",
        "Base"
      )
    ),
    service_type = case_when(
      stringr::str_detect(buffer_name, "HFT") ~ "High frequency",
      stringr::str_detect(buffer_name, "Local") ~ "Local",
      stringr::str_detect(buffer_name, "Basic") ~ "Basic",
      stringr::str_detect(buffer_name, "CE") ~ "Commuter express",
      stringr::str_detect(buffer_name, "DR") ~ "Demand response"
    ),
    time_type = case_when(stringr::str_detect(buffer_name, "All Day") ~ "All day", )
  )


se_all_day <- se_base %>%
  filter(time_type == "All day") %>%
  select(
    -objectid,
    -nn_id,
    everything()
  ) %>%
  group_by(
    scenario_short,
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
  ) %>%
  mutate(
    scenario_id = stringr::str_sub(scenario_short, start = -1L, end = -1L),
    service_type = factor(
      service_type,
      levels = c(
        "Local",
        "Basic",
        "High frequency",
        "Commuter express",
        "Demand response",
        NA
      )
    ),
    item_unit = case_when(
      item == "seniors" ~ "people age 65+",
      item == "poc" ~ "people of color",
      item == "zero_car_hh" ~ "households without a car",
      item == "afford_hous_units" ~ "affordable housing units",
      item == "jobs" ~ "jobs",
      item == "hi_inc_job" ~ "high-wage jobs",
      item == "low_inc_job" ~ "low-wage jobs",
      item == "pop_total" ~ "people",
      item == "pov185" ~ "people with income under 185% federal poverty threshold"
    ),
    item_unit = factor(item_unit,
                           levels = c("people",
                                      "people of color",
                                      "households without a car",
                                      "people with income under 185% federal poverty threshold",
                                      "people age 65+",
                                      "affordable housing units",
                                      "jobs",
                                      "high-wage jobs",
                                      "low-wage jobs")),
    hover_text = paste0(format(round(value), big.mark = ","), " ", item_unit),
  )


# usethis::use_data(se_base, overwrite = TRUE)




# By TMA ------------------------------------------------------------------

se_by_tma <- read_xlsx(path = "data-raw/service_eval_by_tma.xlsx") %>%
  clean_names()

se_by_tma_base <- se_by_tma %>%
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
  filter(
    scenario_short == "Base",
    is.na(time_type)
  ) %>%
  select(
    market_area,
    service_type,
    everything(),
    -buffer_name,
    -objectid,
    -shape_length,
    -shape_area,
    -expand_improve,
    -time_type,
    -scenario_short
  ) %>%
  group_by(
    market_area,
    service_type
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
    value = "value_base"
  )




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
  ) %>%
  mutate(
    scenario_id = stringr::str_sub(scenario_short, start = -1L, end = -1L),
    service_type = factor(
      service_type,
      levels = c(
        "Local",
        "Basic",
        "High frequency",
        "Commuter express",
        "Demand response",
        NA
      )
    ),
    item_unit = case_when(
      item == "seniors" ~ "people age 65+",
      item == "poc" ~ "people of color",
      item == "zero_car_hh" ~ "households without a car",
      item == "afford_hous_units" ~ "affordable housing units",
      item == "jobs" ~ "jobs",
      item == "hi_inc_job" ~ "high-wage jobs",
      item == "low_inc_job" ~ "low-wage jobs",
      item == "pop_total" ~ "people",
      item == "pov185" ~ "people with income under 185% federal poverty threshold"
    ),
    item_unit = factor(item_unit,
                       levels = c("people",
                                  "people of color",
                                  "households without a car",
                                  "people with income under 185% federal poverty threshold",
                                  "people age 65+",
                                  "affordable housing units",
                                  "jobs",
                                  "high-wage jobs",
                                  "low-wage jobs"))

  ) %>%
  as.data.table()




se_by_tma_long <- left_join(se_by_tma_long, se_by_tma_base) %>%
  mutate(val_increase = value - value_base) %>%
  filter(scenario_short != "Base") %>%
  mutate(
    scenario_short = factor(
      scenario_short,
      levels = c(
        "Scenario 1",
        "Scenario A",
        "Scenario B",
        "Scenario C",
        "Scenario D",
        "Scenario E",
        "Scenario 2"
      )
    ),
    scenario_id = stringr::str_sub(scenario_short, start = -1L, end = -1L),
    hover_text = paste0(
      "<b>",
      scenario_short,
      "</b>",
      " will increase ",
      "<b>",
      stringr::str_to_lower(service_type),
      "</b>",
      " service ",
      "<br>",
      " in ",
      "<b>",
      " TMA ",
      market_area,
      "</b>",
      " by ",
      "<b>",
      format(trunc(signif(val_increase, digits = 3)), big.mark = ","),
      "</b> ",
      item_unit
    )
  ) %>%
  as.data.table()


se_high_low_freq_summary <- se_by_tma_long %>%
  filter(item_unit == "people",
         item == "pop_total",
         service_type %in% c("High frequency",
                             "Local")) %>%
  select(-market_area) %>%
  group_by(scenario_short, service_type, item, scenario_id, item_unit) %>%
  summarize(total_increase = sum(val_increase, na.rm = T)) %>%
  mutate(    hover_text = paste0(
    "<b>",
    scenario_short,
    "</b>",
    " will increase ",
    "<b>",
    stringr::str_to_lower(service_type),
    "</b>",
    " service ",
    " by ",
    "<b>",
    format(trunc(signif(total_increase, digits = 3)), big.mark = ","),
    "</b> ",
    item_unit
  )
  ) %>%
  as.data.table()

usethis::use_data(se_by_tma_long, overwrite = T)
usethis::use_data(se_high_low_freq_summary, overwrite = T)

## service type  ----
se_service_type <- se_by_tma %>%
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
    scenario_short,
    expand_improve,
    service_type,
    time_type,
    everything(),
    -market_area,
    -buffer_name,
    -objectid,
    -shape_length,
    -shape_area
  ) %>%
  group_by(
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
  ) %>%
  mutate(
    scenario_id = stringr::str_sub(scenario_short, start = -1L, end = -1L),
    service_type = factor(
      service_type,
      levels = c(
        "Local",
        "Basic",
        "High frequency",
        "Commuter express",
        "Demand response",
        NA
      )
    ),
    item_unit = case_when(
      item == "seniors" ~ "people age 65+",
      item == "poc" ~ "people of color",
      item == "zero_car_hh" ~ "households without a car",
      item == "afford_hous_units" ~ "affordable housing units",
      item == "jobs" ~ "jobs",
      item == "hi_inc_job" ~ "high-wage jobs",
      item == "low_inc_job" ~ "low-wage jobs",
      item == "pop_total" ~ "people",
      item == "pov185" ~ "people with income under 185% federal poverty threshold"
    ),
    item_unit = factor(item_unit,
                       levels = c("people",
                                  "people of color",
                                  "households without a car",
                                  "people with income under 185% federal poverty threshold",
                                  "people age 65+",
                                  "affordable housing units",
                                  "jobs",
                                  "high-wage jobs",
                                  "low-wage jobs")),
    hover_text = paste0(service_type, ", ", format(round(value), big.mark = ","), " ", item_unit),
  ) %>%
  filter(
    !is.na(service_type),
    item == "pop_total"
  ) %>%
  ungroup() %>%
  select(
    -expand_improve,
    -time_type
  ) %>%
  group_by(scenario_id, service_type, scenario_short, item, item_unit) %>%
  summarize(total_value = sum(value)) %>%
  mutate(
    service_type = factor(
      service_type,
      levels = c(
        "Commuter express",
        "Basic",
        "High frequency",
        "Local"
      )
    ),
    hover_text = paste0(
      format(round(total_value), big.mark = ","),
      " ",
      item_unit
    )
  ) %>%
  filter(!is.na(service_type)) %>%
  as.data.table()


usethis::use_data(se_service_type, overwrite = TRUE)

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
    ),
    expand_improve_sen = case_when(
      stringr::str_detect(scenario, "Expand") ~ "expand acess to",
      stringr::str_detect(scenario, "Improve") ~ "improve service for"
    ),
  )

se_summary_long <- se_population_type %>%
  filter(!is.na(expand_improve)) %>%
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
    scenario_id = stringr::str_sub(scenario_short, start = -1L, end = -1L),
    item_unit = case_when(
      item_category == "seniors" ~ "people age 65+",
      item_category == "senior" ~ "people age 65+",
      item_category == "poc" ~ "people of color",
      item_category == "zero_car_hh" ~ "households without a car",
      item_category == "afford_hous_units" ~ "affordable housing units",
      item_category == "aff_hu" ~ "affordable housing units",
      item_category == "jobs" ~ "jobs",
      item_category == "emp" ~ "jobs",
      item_category == "hi_inc_job" ~ "high-wage jobs",
      item_category == "hi_emp" ~ "high-wage jobs",
      item_category == "low_inc_job" ~ "low-wage jobs",
      item_category == "lo_emp" ~ "low-wage jobs",
      item_category == "pop" ~ "people",
      item_category == "pov" ~ "people with income under 185% federal poverty threshold",
      item_category == "pov185" ~ "people with income under 185% federal poverty threshold"
    ),
    item_unit = factor(item_unit,
                       levels = c("people",
                                  "people of color",
                                  "households without a car",
                                  "people with income under 185% federal poverty threshold",
                                  "people age 65+",
                                  "affordable housing units",
                                  "jobs",
                                  "high-wage jobs",
                                  "low-wage jobs")),
    type = ifelse(item_category %in% c(
      "emp",
      "hi_emp",
      "lo_emp",
      "jobs"
    ), "Jobs", "People"),
    type = factor(type,
                  levels = c("People",
                             "Jobs")),
    item_unit_label = case_when(
      item_category == "seniors" ~ "Older Population",
      item_category == "senior" ~ "Older Population",
      item_category == "poc" ~ "BIPOC",
      item_category == "zero_car_hh" ~ "households without a car",
      item_category == "afford_hous_units" ~ "Affordable Housing Units",
      item_category == "aff_hu" ~ "Affordable Housing Units",
      item_category == "jobs" ~ "Jobs",
      item_category == "emp" ~ "Jobs",
      item_category == "hi_inc_job" ~ "High-Wage Jobs",
      item_category == "hi_emp" ~ "High-Wage Jobs",
      item_category == "low_inc_job" ~ "Low-Wage Jobs",
      item_category == "lo_emp" ~ "Low-Wage Jobs",
      item_category == "pop" ~ "People",
      item_category == "pov" ~ "Low-Income Population",
      item_category == "pov185" ~ "Low-Income Population"
    ),
    lab = paste0(
      "+",
      round(pct * 100),
      "% ",
      item_unit_label
    ),
    hover_text = paste0(
      "<b>",
      scenario_short,
      "</b>",
      " will ",
      expand_improve_sen,
      "<br>",
      " an additional ",
      "<b>",
      format(trunc(signif(total, digits = 3)), big.mark = ","),
      "</b> ",
      item_unit
    ),
    summary_title = case_when(
      expand_improve == "Expand" ~ "Expanded Access",
      TRUE ~ "Improved Transit Service"
    ),
    item_unit_factor = factor(
      item_unit_label,
      levels = c(
        "People",
        "Low-Income Population",
        "BIPOC",
        "Affordable Housing Units",
        "Older Population",
        "Jobs",
        "High-Wage Jobs",
        "Low-Wage Jobs"
      )
    ),
    scenario_short = factor(
      scenario_short,
      levels = c(
        "Scenario 1",
        "Scenario A",
        "Scenario B",
        "Scenario C",
        "Scenario D",
        "Scenario E",
        "Scenario 2"
      )
    )
  ) %>%
  data.table::as.data.table()


usethis::use_data(se_summary_long, overwrite = T)

# # level of service -------------------------------------------------------------
#
# se_level_of_service <- read_xlsx("data-raw/service_eval_clean.xlsx") %>%
#   clean_names() %>%
#   rename(scenario = x1) %>%
#   mutate(
#     scenario_short = stringr::str_sub(scenario, end = 10L),
#     expand_improve = case_when(
#       stringr::str_detect(scenario, "Expand") ~ "Expand",
#       stringr::str_detect(scenario, "Improve") ~ "Improve"
#     )
#   ) %>%
#   filter(expand_improve == "Expand") %>%
#   select(
#     scenario_short,
#     expand_improve,
#     everything(),
#     -scenario,
#     -pop_tma_1,
#     -pop_tma_2,
#     -pop_tma_3,
#     -pop_tma_4,
#     -pop_tma_5,
#     -emp_tma_1,
#     -emp_tma_2,
#     -emp_tma_3,
#     -emp_tma_4,
#     -emp_tma_5
#   ) %>%
#   group_by(scenario_short, expand_improve) %>%
#   tidyr::gather(
#     pop_total,
#     pop_pct,
#     emp_total,
#     emp_pct,
#     poc_total,
#     poc_pct,
#     pov_total,
#     pov_pct,
#     aff_hu_total,
#     aff_hu_pct,
#     senior_total,
#     senior_pct,
#     lo_emp_total,
#     lo_emp_pct,
#     hi_emp_total,
#     hi_emp_pct,
#     key = "item",
#     value = "value"
#   ) %>%
#   mutate(
#     item_category = stringr::str_remove_all(item, "_total") %>%
#       stringr::str_remove_all("_pct"),
#     item_unit = case_when(
#       item_category == "seniors" ~ "people age 65+",
#       item_category == "senior" ~ "people age 65+",
#
#                           item_category == "poc" ~ "people of color",
#                           item_category == "zero_car_hh" ~ "households without a car",
#                           item_category == "afford_hous_units" ~ "affordable housing units",
#                           item_category == "aff_hu" ~ "affordable housing units",
#                           item_category == "jobs" ~ "jobs",
#                           item_category == "emp" ~ "jobs",
#                           item_category == "hi_inc_job" ~ "high-income jobs",
#       item_category == "hi_emp" ~ "high-income jobs",
#
#                           item_category == "low_inc_job" ~ "low-income jobs",
#       item_category == "lo_emp" ~ "low-income jobs",
#
#                           item_category == "pop" ~ "people",
#                           item_category == "pov" ~ "people with income under 185% federal poverty threshold",
#                           item_category == "pov185" ~ "people with income under 185% federal poverty threshold"),
#   ) %>%
# mutate(value_unit = ifelse(value > 1, "total", "pct")) %>%
#   select(-item) %>%
#   spread(value_unit, value) %>%
#   mutate(
#     lab = paste0(
#       "+",
#       round(pct * 100),
#       "% "
#     ),
#     scenario_id = stringr::str_sub(scenario_short, start = -1L, end = -1L)  )%>%
#   mutate(hover_text = paste0(
#     "<b>", scenario_short, "</b>", " will ", expand_improve_sen, "<br>",
#     " an estimated ", "<b>", format(round(total), big.mark = ","), "</b>",
#     ifelse(item_category == "emp", " jobs ", " people ")
#   )) %>%
#   data.table::as.data.table()
#
# job access ------------------------------------------------------------
#
job_access <- readxl::read_xlsx("data-raw/job_access.xlsx") %>%
  clean_names() %>%
  mutate(
    scenario = factor(
      scenario,
      levels = c(
        "Scenario 1",
        "Scenario A",
        "Scenario B",
        "Scenario C",
        "Scenario D",
        "Scenario E",
        "Scenario 2"
      )
    ),
    scenario_id = stringr::str_sub(scenario, start = -1L, end = -1L),
  ) %>%
  gather(
    x15_minutes,
    x30_minutes,
    x45_minutes,
    x60_minutes,
    key = "time",
    value = "pct"
  ) %>%
  mutate(
    minute_improvement = stringr::str_replace(time, "_", " ") %>%
      stringr::str_remove("x") %>%
      factor(levels = c(
        "15 minutes",
        "30 minutes",
        "45 minutes",
        "60 minutes"
      )),
    hover_text = paste0(
      "<b>",
      scenario,
      "</b>",
      " will increase the number of jobs",
      "<br>",
      " accessibile within ",
      "<b>",
      minute_improvement,
      "</b>",
      " by ",
      "<b>",
      round(pct * 100, digits = 1),
      "%",
      "</b> "
    )
  ) %>%
  as.data.table()

# job_access %>% View

usethis::use_data(job_access, overwrite = T)
