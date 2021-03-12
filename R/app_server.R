#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # List the first level callModules here
  # browser()

  scrolly_section <- callModule(
    mod_scrolly_container_server,
    "scrolly_container_ui_1"
  )

  slider_input <- callModule(mod_slider_server, "slider_ui_1")

  data_for_plotting <- callModule(
    mod_util_data_server,
    "util_data_ui_1",
    slider_input = slider_input
  )

  callModule(mod_plot_scenario_spectrum_server, "plot_scenario_spectrum_ui_1")



  # Scenario summary in context ----------------------------------------------
  ## expand access -----
  callModule(
    mod_plot_new_access_server,
    "plot_new_access_ui_1",
    data_for_plotting = data_for_plotting
  )

  callModule(mod_plot_people_jobs_detail_server,
             "plot_people_expand_detail_ui_1",
             data_for_plotting = data_for_plotting,
             plot_expand_improve = "Expand",
             plot_type = "People")

  callModule(mod_plot_people_jobs_detail_server,
             "plot_jobs_expand_detail_ui_1",
             data_for_plotting = data_for_plotting,
             plot_expand_improve = "Expand",
             plot_type = "Jobs")


  ## improve service -----
  callModule(
    mod_plot_improve_service_server,
    "plot_improve_service_ui_1",
    data_for_plotting = data_for_plotting
  )


  callModule(mod_plot_people_jobs_detail_server,
             "plot_people_improve_detail_ui_1",
             data_for_plotting = data_for_plotting,
             plot_expand_improve = "Improve",
             plot_type = "People")

  callModule(mod_plot_people_jobs_detail_server,
             "plot_jobs_improve_detail_ui_1",
             data_for_plotting = data_for_plotting,
             plot_expand_improve = "Improve",
             plot_type = "Jobs")




  callModule(
    mod_plot_job_access_server,
    "plot_job_access_ui_1",
    data_for_plotting = data_for_plotting
  )
  callModule(
    mod_plot_service_type_server,
    "plot_service_type_ui_1",
    data_for_plotting = data_for_plotting
  )

  callModule(
    mod_plot_tma_service_type_server,
    "plot_tma_service_type_ui_1",
    data_for_plotting = data_for_plotting
  )



  # Table scrolly ---------------------------------------------------------------
  callModule(
    mod_table_network_improvements_server,
    "table_ui_1",
    slider_input = slider_input
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




  # New access to all day transit -----------------------------------------------

  callModule(
    mod_plot_scenario_summary_server,
    "plot_scenario_summary_ui_expand_all_day",
    plot_type = "Expand",
    data_for_plotting = data_for_plotting
  )

  callModule(
    mod_plot_scenario_detail_server,
    "mod_plot_scenario_detail_ui_expand_people",
    data_for_plotting = data_for_plotting,
    plot_type = "Expand",
    unit_type = "People"
  )

  callModule(
    mod_plot_scenario_detail_server,
    "mod_plot_scenario_detail_ui_expand_jobs",
    data_for_plotting = data_for_plotting,
    plot_type = "Expand",
    unit_type = "Jobs"
  )




  # New improved transit

  callModule(
    mod_plot_scenario_summary_server,
    "plot_scenario_summary_ui_improve_all",
    plot_type = "Improve",
    data_for_plotting = data_for_plotting
  )

  callModule(
    mod_plot_scenario_detail_server,
    "mod_plot_scenario_detail_ui_improve_people",
    data_for_plotting = data_for_plotting,
    plot_type = "Improve",
    unit_type = "People"
  )

  callModule(
    mod_plot_scenario_detail_server,
    "mod_plot_scenario_detail_ui_improve_jobs",
    data_for_plotting = data_for_plotting,
    plot_type = "Improve",
    unit_type = "Jobs"
  )

  # increase by service type

  callModule(
    mod_plot_tma_service_type_server,
    "plot_scenario_tma_ui_2",
    data_for_plotting = data_for_plotting)
}
