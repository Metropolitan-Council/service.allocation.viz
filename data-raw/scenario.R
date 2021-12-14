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
  mutate(scenario = paste0("Scenario ", LETTERS[1:7])) %>%
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
  mutate(
    ridership_increase_percent = ridership_increase * 100,
    scenario = c(
      "Scenario A",
      "Scenario B",
      "Scenario C",
      "Scenario D",
      "Scenario E",
      "Scenario F",
      "Scenario G"
    ),
    scenario_short = factor(
      scenario,
      levels = c(
        "Scenario A",
        "Scenario B",
        "Scenario C",
        "Scenario D",
        "Scenario E",
        "Scenario F",
        "Scenario G"
      )
    ),
    scenario_id = stringr::str_sub(scenario, start = -1L, end = -1L),
    hover_text = paste0(
      "<b>",
      scenario,
      "</b>",
      " will increase ridership by approximately ",
      "<b>",
      ridership_increase_percent,
      "%",
      "</b> "
    )
  ) %>%
  as.data.table()

usethis::use_data(scenario_rdrshp, overwrite = T)
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
  mutate(
    scenario_text = stringr::str_replace_all(improvement_type, "_", " ") %>%
      stringr::str_to_sentence(),
    value = case_when(
      improvement_type %in% c("expanded_on_demand_service") & value == 0 ~ "No",
      improvement_type %in% c("expanded_on_demand_service") & value == 1 ~ "Yes",
      TRUE ~ as.character(value)
    )
  ) %>%
  as.data.table()



# Save final data ---------------------------------------------------------

improvement_examples <- tibble(
  improvement_type = unique(scenario_def_long$improvement_type),
  improvement_example = c(
    "Route that was already high frequency provided with even higher frequency (e.g. 15 minute service to 10 minute service)",
    "Route with service between every 15 to 30 minutes increased to service at least every 15 minutes",
    "Route with service frequencies greater than every 30 minutes improved to service frequencies between every 15 to 30 minutes",
    "Increased number of trips on commuter routes",
    "New routes that provide service to suburban job centers and new routes that operate entirely outside of Transit Market Areas 1 and 2",
    "New local routes",
    "New commuter routes",
    "Additional resources dedicated to on-demand, flexible service to serve low ridership demand areas"
  )
)


scenario_def_long <- scenario_def_long %>%
  left_join(improvement_examples)

usethis::use_data(scenario_def, overwrite = TRUE)
usethis::use_data(scenario_def_long, overwrite = TRUE)

write.csv(scenario_def_long, "data-raw/scenario_def_long.csv")
