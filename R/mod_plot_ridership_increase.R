#' plot_ridership_increase UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_ridership_increase_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotlyOutput(ns("ridership_increase_plot"))
  )
}

#' plot_ridership_increase Server Function
#'
#' @noRd
mod_plot_ridership_increase_server <- function(
  input,
  output,
  session,
  data_for_plotting = data_for_plotting
) {
  ns <- session$ns

  output$ridership_increase_plot <- plotly::renderPlotly({
    ggplotly(
      tooltip = "text",
      ggplot(data = scenario_rdrshp[scenario_id %in% data_for_plotting$detail_data$scenario_id, ]) +
        geom_col(
          mapping = aes(
            x = scenario,
            y = ridership_increase,
            # fill = reorder(service_type, dplyr::desc(service_type)),
            text = hover_text
          ),
          color = "white"
        ) +
        scale_fill_manual(values = convenient_colors) +
        geom_col(
          data = scenario_rdrshp[!scenario_id %in% data_for_plotting$detail_data$scenario_id, ],
          mapping = aes(
            x = scenario,
            y = ridership_increase,
            # fill = reorder(service_type, dplyr::desc(service_type)),
            text = hover_text
          ),
          color = "white",
          fill = "gray",
          alpha = 1
          # lwd = 0.4,
        ) +
        scale_y_continuous(
          labels = scales::label_percent()
        ) +
        labs(
          x = "",
          y = "",
          title = "Increase in Transit Ridership"
        ) +
        app_theme() +
        theme(
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
      plotly::layout(
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
# mod_plot_ridership_increase_ui("plot_ridership_increase_ui_1")

## To be copied in the server
# callModule(mod_plot_ridership_increase_server, "plot_ridership_increase_ui_1")
