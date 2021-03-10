#' plot_scenario_tma UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_tma_service_type_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotly::plotlyOutput(
      ns("tma_service_type_summary"),
      # width = "75%",
      # height = "225px"
    )
  )
}

#' plot_scenario_tma Server Function
#'
#' @noRd
mod_plot_tma_service_type_server <- function(
  input,
  output,
  session,
data_for_plotting = data_for_plotting
  ) {
  ns <- session$ns


  output$tma_service_type_summary <- plotly::renderPlotly({
    ggplotly(
      tooltip = "text",
      ggplot(data = data_for_plotting$service_type_by_tma$by_tma) +
        geom_col(
          aes(
            x = market_area,
            y = val_increase,
            # group = service_type,
            text = hover_text,
            fill = reorder(service_type, dplyr::desc(service_type))
          ),
          color = "white",
          lwd = 0.4,
          position = "stack"
        ) +
        scale_fill_manual(values = convenient_colors) +
        scale_y_continuous(
          labels = scales::comma
        ) +
        labs(
          x = "Transit market area",
          y = "",
          # title = "Scenario 1",
          fill = "Service level"
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
        margin = list(l = 0, r = 0, b = 10, t = 50, pad = 10),
        # l = left; r = right; t = top; b = bottom
        # xaxis = axis_options,
        # yaxis = axis_options,
        showlegend = TRUE,
        legend = list(
          orientation = "h",
          y = -0.12
        ),
        annotations = list(
          visible = FALSE,
          font = list(
            family = font_family_list,
            size = 30,
            color = councilR::colors$suppBlack
          )
        ),
        # hovermode = "x-unified",
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
# mod_plot_tma_service_type_ui("plot_tma_service_type_ui_1")

## To be copied in the server
# callModule(mod_plot_tma_service_type_server, "plot_tma_service_type_ui_1")
