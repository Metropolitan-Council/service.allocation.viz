## code to prepare `scenario_spectrum` dataset goes here

scenario_spectrum <- tidyr::tibble(
  scenario = factor(
    unique(scenario_def$scenario),
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
  scenario_id = unique(scenario_def_long$scenario_id),
  scenario_priority = c(
    "Convenient Concept",
    rep("", 5),
    "Coverage Concept"
  ),
  scenario_priority_desc = c(
    "Improving service serving all trip types, mostly in Transit Market Areas I & II",
    rep("", 5),
    "Maximizes geographic coverage of transit service"
  ),
  x = seq(1, 7, 1),
  y = 0,
  mix_scenario_1 = c(100, 80, 60, 50, 40, 20, 0),
  mix_scenario_2 = c(0, 20, 40, 50, 60, 80, 100),
  mix = paste0(as.character(mix_scenario_1), "/", as.character(mix_scenario_2)),
  mix_value = c(3, 2, 1, 0, -1, -2, -3),
  mix_text = c(
    "All improvements from Convenient Concept",
    "Mostly improvements from Convenient Concept",
    "Improvements lean towards Convenient Concept",
    "Half improvements from Convenient Concept, half improvements from Coverage Concept",
    "Improvements lean towards Coverage Concept",
    "Mostly improvements from Coverage Concept",
    "All improvements from Coverage Concept"
  ),
  hover_text = paste0(
    "<b>",
    scenario,
    "</b> ",
    mix_text
  ),
  text_color = c(rep("white", 2),
                 rep("black", 3),
                 rep("white", 2))
)



usethis::use_data(scenario_spectrum, overwrite = TRUE)
