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

  callModule(
    mod_plot_server,
    "plot_ui_1",
    scroll_section = scrolly_section
  )

  callModule(
    mod_table_server,
    "table_ui_1",
    slider_input = slider_input
  )

  callModule(
    mod_plot_scenario_summary_server,
    "plot_scenario_summary_ui_1",
    slider_input = slider_input
  )
  callModule(
    mod_plot_scenario_tma_server,
    "plot_scenario_tma_ui_1",
    slider_input = slider_input
  )

}
