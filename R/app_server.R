#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # List the first level callModules here


  scrolly_section <- callModule(
    mod_scrolly_container_server,
    "scrolly_container_ui_1"
  )

  slider_input <- callModule(mod_slider_server, "slider_ui_1")

  data_for_plotting <- callModule(mod_util_data_server, "util_data_ui_1",
                                  slider_input = slider_input)





  callModule(
    mod_plot_server,
    "plot_ui_1",
    scroll_section = scrolly_section
  )


# Summary scrolly ------------------------------------------------------------
  callModule(
    mod_plot_scenario_summary_server,
    "plot_scenario_summary_ui_expand",
    plot_type = "Expand",
    data_for_plotting = data_for_plotting
  )

  callModule(
    mod_plot_scenario_summary_server,
    "plot_scenario_summary_ui_improve",
    plot_type = "Improve",
    data_for_plotting = data_for_plotting

  )


  callModule(
    mod_plot_scenario_tma_server,
    "plot_scenario_tma_ui_1",
    slider_input = slider_input
  )

# Table scrolly ---------------------------------------------------------------
  callModule(
    mod_table_server,
    "table_ui_1",
    slider_input = slider_input
  )

# New access to all day transit -----------------------------------------------

  callModule(
    mod_plot_scenario_summary_server,
    "plot_scenario_summary_ui_expand_all_day",
    plot_type = "Expand",
    data_for_plotting = data_for_plotting
  )

  callModule(mod_plot_scenario_detail_server,
             "mod_plot_scenario_detail_ui_expand_people",
             data_for_plotting = data_for_plotting,
             plot_type = "Expand",
             unit_type = "People")

  callModule(mod_plot_scenario_detail_server,
             "mod_plot_scenario_detail_ui_expand_jobs",
             data_for_plotting = data_for_plotting,
             plot_type = "Expand",
             unit_type = "Jobs")




# New improved transit

  callModule(
    mod_plot_scenario_summary_server,
    "plot_scenario_summary_ui_improve_all",
    plot_type = "Improve",
    data_for_plotting = data_for_plotting

  )

  callModule(mod_plot_scenario_detail_server,
             "mod_plot_scenario_detail_ui_improve_people",
             data_for_plotting = data_for_plotting,
             plot_type = "Improve",
             unit_type = "People")

  callModule(mod_plot_scenario_detail_server,
             "mod_plot_scenario_detail_ui_improve_jobs",
             data_for_plotting = data_for_plotting,
             plot_type = "Improve",
             unit_type = "Jobs")

# increase by service type

  callModule(
    mod_plot_scenario_tma_server,
    "plot_scenario_tma_ui_2",
    slider_input = slider_input
  )
  callModule(mod_plot_service_type_server,
             "plot_service_type_ui_1",
             slider_input = slider_input)


}
