#' plot_scenario_summary UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_scenario_summary_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotly::plotlyOutput(ns("scenario_summary"))
  )
}

#' plot_scenario_summary Server Function
#'
#' @noRd
#' @import ggplot2
#' @import plotly
#' @importFrom stringr str_wrap
mod_plot_scenario_summary_server <- function(
  input,
  output,
  session,
  slider_input = slider_input
) {
  ns <- session$ns

  summary_data <- reactive({
    se_population_type_long[scenario_id == slider_input$slider, ][item_category %in% c("pop", "emp")]
  })


  output$scenario_summary <- plotly::renderPlotly({
    ggplotly(
      tooltip = "label",
      ggplot(data = summary_data()) +
        geom_tile(
          aes(
            x = c(1, 0, 1, 0),
            y = 1,
            fill = item_category
          ),
          show.legend = F
        ) +
        facet_wrap(
          ~expand_improve,
          labeller = labeller(expand_improve = c(
            Expand = "Expand Access",
            Improve = "Improved Transit Service"
          ))
        ) +
        geom_text(
          aes(
            x = c(1, 0, 1, 0),
            y = 1,
            label = stringr::str_wrap(lab, width = 9)
          ),
          position = position_dodge(width = 0)
        ) +
        scale_fill_manual(
          labels = c(
            "Jobs",
            "People"
          ),
          values = c(
            "#E2F0D9",
            "#DAE3F3"
          )
        ) +
        councilR::council_theme(use_showtext = TRUE) +
        theme(
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank()
        )
    ) %>%
      plotly::config(
        displaylogo = F,
        showSendToCloud = F,
        displayModeBar = F
      )
  })
}

## To be copied in the UI
# mod_plot_scenario_summary_ui("plot_scenario_summary_ui_1")

## To be copied in the server
# callModule(mod_plot_scenario_summary_server, "plot_scenario_summary_ui_1")
