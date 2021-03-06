#' util_data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_util_data_ui <- function(id) {
  ns <- NS(id)
  tagList()
}

#' util_data Server Function
#'
#' @noRd
mod_util_data_server <- function(
  input,
  output,
  session,
  slider_input = slider_input
) {
  ns <- session$ns

  summary_data <- reactive({
    se_summary_long[scenario_id == slider_input$slider, ][item_category %in% c("pop", "emp")]
  })

  detail_data <- reactive({
    se_detail_long[scenario_id == slider_input$slider, ]
  })

  summary_context_data <- reactive({
    se_summary_long[item_category %in% c("pop", "emp")][, selected := ifelse(scenario_id == slider_input$slider, 1, 0)]
  })

  service_type_by_tma <- reactive({
    list(
      by_tma = service.allocation.viz::se_by_tma_long[scenario_id == slider_input$slider, ][item == "pop_total", ][service_type %in% c(
        "High frequency",
        "Local"
      ), ],
      by_all = service.allocation.viz::se_high_low_freq_summary[, selected := ifelse(scenario_id == slider_input$slider, 1, 0)]
    )
  })

  job_access_data <- reactive({
    service.allocation.viz::job_access[, selected := ifelse(scenario_id == slider_input$slider, 1, 0)]
  })

  vals <- reactiveValues()

  observe({
    vals$summary_data <- summary_data()
  })


  observe({
    vals$summary_context_data <- summary_context_data()
  })

  observe({
    vals$job_access_data <- job_access_data()
  })
  observe({
    vals$service_type_by_tma <- service_type_by_tma()
  })

  observe({
    vals$detail_data <- detail_data()
  })


  return(vals)
}

## To be copied in the UI
# mod_util_data_ui("util_data_ui_1")

## To be copied in the server
# callModule(mod_util_data_server, "util_data_ui_1")
