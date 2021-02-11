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
                                             slider_input = slider_input) {
  ns <- session$ns

  summary_data <- reactive({
    se_population_type_long[scenario_id == slider_input$slider, ][item_category %in% c("pop", "emp")]
  })


  output$scenario_summary <- plotly::renderPlotly({
    ggplotly(
      tooltip = "text",
      ggplot(data = summary_data()) +
        geom_tile(aes(
          x = c(1, 0, 1, 0),
          y = 1,
          fill = item_category,
          text = hover_text
        ),
        show.legend = F
        ) +
        facet_wrap(~expand_improve,
          labeller = labeller(expand_improve = c(
            Expand = "Expand Access",
            Improve = "Improved Transit Service"
          ))
        ) +
        geom_text(aes(
          x = c(1, 0, 1, 0),
          y = 1.1,
          label = str_wrap(lab, width = 9)
        ),
        position = position_dodge(width = 0),
        family = font_families$font_family_title,
        size = font_sizes$font_size_axis_title
        ) +
        geom_text(aes(
          x = c(1, 0, 1, 0),
          y = 0.7,
          label = type
        ),
        position = position_dodge(width = 0),
        family = font_families$font_family_title,
        size = 8
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
        )
    ) %>%
      layout(
        # margin = list(l = 10, r = 10, b = 10, t = 10, pad = 10), # l = left; r = right; t = top; b = bottom
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
            size = 20,
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
# callModule(mod_plot_scenario_summary_server, "plot_scenario_summary_ui_1")
