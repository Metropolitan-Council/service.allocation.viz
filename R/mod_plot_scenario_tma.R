#' plot_scenario_tma UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_scenario_tma_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotly::plotlyOutput(
      ns("tma_summary"),
      width = "75%",
      height = "225px"
    )
  )
}

#' plot_scenario_tma Server Function
#'
#' @noRd
mod_plot_scenario_tma_server <- function(
  input,
  output,
  session,
  slider_input = slider_input
) {
  ns <- session$ns

  summary_tma_data <- reactive({
    se_by_tma_long[scenario_id == slider_input$slider, ][item == "pop_total", ][service_type %in% c(
      "High frequency",
      "Local"
    ), ]
  })


  output$tma_summary <- plotly::renderPlotly({
    ggplotly(
      tooltip = "text",
      ggplot(data = summary_tma_data()) +
        geom_col(
          aes(
            x = market_area,
            y = value,
            # group = service_type,
            text = hover_text,
            fill = service_type
          ),
          width = -1,
          # fill = "#542c40",
          position = position_identity()
        ) +
        scale_fill_manual(values = c(
          "#964f74",
          "#542c40"
        )) +
        scale_y_continuous(
          labels = scales::comma,
          name = "People"
        ) +
        labs(
          x = "Transit market area",
          y = "",
          # title = "Scenario 1",
          fill = "Service level"
        ) +
        theme(
          # legend.position = "bottom",
          axis.text.x = element_text(
            size = font_sizes$font_size_axis_text,
            family = font_families$font_family_base
          ),
          axis.title = element_text(
            family = font_families$font_family_title,
            size = font_sizes$font_size_axis_title
          )
        ) +
        app_theme() +
        ggplot2::theme(
          axis.title.x = ggplot2::element_text(
            vjust = -1,
            family = font_families$font_family_axis_title,
            size = font_sizes$font_size_axis_title
          ),
          axis.title.y = ggplot2::element_text(
            vjust = 2,
            family = font_families$font_family_axis_title,
            size = font_sizes$font_size_axis_title
          ),
          axis.text.x = ggplot2::element_text(
            family = font_families$font_family_axis_text,
            size = font_sizes$font_size_axis_text,
            vjust = 0.5
          ),
          axis.text.y = ggplot2::element_text(
            family = font_families$font_family_axis_text,
            size = font_sizes$font_size_axis_text,
            vjust = 1
          ),
        )
    ) %>%
      layout(
        # margin = list(l = 10, r = 10, b = 10, t = 10, pad = 10), # l = left; r = right; t = top; b = bottom
        # xaxis = axis_options,
        # yaxis = axis_options,
        showlegend = TRUE,
        legend = list(
          orientation = "v"
        ),
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
        hoverlabel = list(
          #----
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
# mod_plot_scenario_tma_ui("plot_scenario_tma_ui_1")

## To be copied in the server
# callModule(mod_plot_scenario_tma_server, "plot_scenario_tma_ui_1", slider_input = slider_input)
