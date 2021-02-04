## code to prepare `scenario_` dataset series goes here

library(dplyr)
library(readxl)
library(janitor)


# Scenario def ------------------------------------------------------------

scenario_def <- read_xlsx(path = "data-raw/scenario_def.xlsx", col_types = c(
  "text",
  rep("numeric", 7),
  "text"
)) %>%
  clean_names() %>%
  rename(scenario = x1) %>%
  rowwise() %>%
  mutate(expanded_on_demand_service = case_when(
    expanded_on_demand_service == "Yes" ~ 1,
    TRUE ~ 0
  ))





# Ridership ---------------------------------------------------------------


scenario_rdrshp <- read_xlsx(path = "data-raw/scenario_rdrshp.xlsx") %>%
  clean_names() %>%
  mutate(ridership_increase_percent = ridership_increase * 100)

scenario_def$ridership_increase_percent <- scenario_rdrshp$ridership_increase_percent

scenario_def_long <- scenario_def %>%
  # group_by(scenario) %>%
  tidyr::gather(high_frequency_routes_improved,
    local_routes_improved_to_high_frequency,
    basic_routes_improved_to_local,
    commuter_routes_improved,
    new_reverse_commute_and_suburb_to_suburb_routes,
    new_local_routes,
    new_commuter_routes,
    expanded_on_demand_service,
    # scenario_rdrshp,
    ridership_increase_percent,
    # scenario,
    key = "improvement_type",
    value = value
  )



# Save final data ---------------------------------------------------------



usethis::use_data(scenario_def, overwrite = TRUE)
usethis::use_data(scenario_def_long, overwrite = TRUE)
