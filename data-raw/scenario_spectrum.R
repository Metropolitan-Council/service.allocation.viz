## code to prepare `scenario_spectrum` dataset goes here

scenario_spectrum <- tidyr::tibble(scenario = factor(unique(scenario_def$scenario),
                                                        levels = c("Scenario 1",
                                                                   "Scenario A",
                                                                   "Scenario B",
                                                                   "Scenario C",
                                                                   "Scenario D",
                                                                   "Scenario E",
                                                                   "Scenario 2"
                                                                   )),
              scenario_id = unique(scenario_def_long$scenario_id),
              scenario_priority = c("Ridership Priority", rep("", 5),
                                    "Coverage Priority"),
              scenario_priority_desc = c("Improving service serving all trip types, mostly in Transit Market Areas I & II",
                                         rep("", 5),
                                         "Maximizes geographic coverage of transit service"),
              x = seq(1,7,1),
              y = 0,
              mix_scenario_1 = c(100, 80, 60, 50, 40, 20 ,0),
              mix_scenario_2 = c(0, 20, 40, 50, 60, 80, 100),
              mix = paste0(as.character(mix_scenario_1), "/", as.character(mix_scenario_2)),
              mix_value = c(3, 2, 1, 0, -1, -2, -3),
              mix_text = c("100% Scenario I",
                           "80% Scenario I / 20% Scenario II",
                           "60% Scenario I / 40% Scenario II",
                           "50% Scenario I / 50% Scenario II",
                           "40% Scenario I / 60% Scenario II",
                           "20% Scenario I / 80% Scenario II",
                           "100% Scenario II"),
              hover_text = c("<b> Scenario I </b> Improving service serving all trip types, mostly in Transit Market Areas I & II",
                             "<b> Scenario A </b> 80% Scenario I / 20% Scenario II",
                             "<b> Scenario B </b> 60% Scenario I / 40% Scenario II",
                             "<b> Scenario C </b> 50% Scenario I / 50% Scenario II",
                             "<b> Scenario D </b> 40% Scenario I / 60% Scenario II",
                             "<b> Scenario E </b> 20% Scenario I / 80% Scenario II",
                             "<b> Scenario II </b> Maximizes geographic coverage of transit service")
              )



usethis::use_data(scenario_spectrum, overwrite = TRUE)
