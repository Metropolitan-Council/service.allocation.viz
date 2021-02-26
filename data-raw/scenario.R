## code to prepare `scenario_` dataset series goes here

library(dplyr)
library(readxl)
library(janitor)
library(data.table)


# Scenario def ------------------------------------------------------------

scenario_def <- read_xlsx(
  path = "data-raw/scenario_def.xlsx",
  col_types = c(
    "text",
    rep("numeric", 7),
    "text"
  )
) %>%
  clean_names() %>%
  rename(scenario = x1) %>%
  rowwise() %>%
  mutate(
    expanded_on_demand_service =
      case_when(
        expanded_on_demand_service == "Yes" ~ 1,
        TRUE ~ 0
      ),
    scenario_id = stringr::str_sub(scenario, start = -1L, end = -1L)
  ) %>%
  as.data.table()






# Ridership ---------------------------------------------------------------


scenario_rdrshp <- read_xlsx(path = "data-raw/scenario_rdrshp.xlsx") %>%
  clean_names() %>%
  mutate(ridership_increase_percent = ridership_increase * 100)

# scenario_def$ridership_increase_percent <- scenario_rdrshp$ridership_increase_percent

scenario_def_long <- scenario_def %>%
  # group_by(scenario) %>%
  tidyr::gather(
    high_frequency_routes_improved,
    local_routes_improved_to_high_frequency,
    basic_routes_improved_to_local,
    commuter_routes_improved,
    new_reverse_commute_and_suburb_to_suburb_routes,
    new_local_routes,
    new_commuter_routes,
    expanded_on_demand_service,
    # scenario_rdrshp,
    # ridership_increase_percent,
    # scenario,
    key = "improvement_type",
    value = value
  ) %>%
  mutate(scenario_text = stringr::str_replace_all(improvement_type, "_", " ") %>%
    stringr::str_to_sentence()) %>%
  as.data.table()



# Save final data ---------------------------------------------------------



usethis::use_data(scenario_def, overwrite = TRUE)
usethis::use_data(scenario_def_long, overwrite = TRUE)

write.csv(scenario_def_long, "data-raw/scenario_def_long.csv")
