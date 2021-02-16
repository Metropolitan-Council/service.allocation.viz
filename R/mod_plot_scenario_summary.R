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
  slider_input = slider_input,
  plot_type) {
  ns <- session$ns

  summary_data <- reactive({
    se_population_type_long[scenario_id == slider_input$slider, ][item_category %in% c("pop", "emp")][expand_improve == plot_type ]
  })



  output$scenario_summary <- plotly::renderPlotly({
    plot_data <- summary_data()
    ggplotly(
      tooltip = "text",
      ggplot(data = plot_data) +
        geom_tile(aes(
          x = c(1, 0),
          y = 1,
          fill = item_category,
          text = hover_text
        ),
        show.legend = F,
        lwd = 5,
        color = "white"
        ) +
        geom_text(
          aes(
            x = c(1, 0),
            y = 1.01,
            label = str_wrap(lab, width = 4)
          ),
          position = position_dodge(width = 0),
          family = font_families$font_family_title,
          size = "10"
        ) +
        scale_fill_manual(
          labels = c(
            "Jobs",
            "People"
          ),
          values = c(
            job_color,
            people_color
          )
        ) +
        labs(title = paste0(plot_data$summary_title[1])) +
        app_theme()
    ) %>%
      plotly::layout(
        margin = list(l = 0, r = 0, b = 10, t = 50, pad = 10), # l = left; r = right; t = top; b = bottom
        xaxis = axis_options,
        yaxis = axis_options,
        showlegend = FALSE,
        annotations = list(
          visible = FALSE,
          font = list(
            family = font_family_list,
            size = 30,
            color = councilR::colors$suppBlack
          )
        ),
        hovermode = "closest",
        # hoveron = "fills",
        hoverdistance = "5",
        hoverlabel = list( #----
                           font = list(
                             size = font_sizes$font_size_strip_title,
                             family = font_family_list,
                             color = "black"
                           ),
                           bgcolor = "white",
                           bordercolor = "white",
                           padding = list(l = 10, r = 10, b = 10, t = 10)
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
# callModule(mod_plot_scenario_summary_server, "plot_scenario_summary_ui_1", slider_input = slider_input)
