#' plot_job_access UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_job_access_ui <- function(id) {
  ns <- NS(id)
  tagList((
    plotlyOutput(ns("job_access_plot"))
  ))
}

#' plot_job_access Server Function
#'
#' @noRd
mod_plot_job_access_server <- function(
  input,
  output,
  session,
  data_for_plotting = data_for_plotting
) {
  ns <- session$ns

  output$job_access_plot <- plotly::renderPlotly({
    # browser()
    ggplotly(
      tooltip = "text",
      ggplot(data_for_plotting$job_access_data) +
        geom_col(
          mapping = aes(
            x = scenario,
            y = pct,
            fill = minute_improvement,
            text = hover_text,
            group = minute_improvement
          ),
          position = position_dodge2(
            padding = 0.1
          )
        ) +
        geom_col(
          data = data_for_plotting$job_access_data[selected == 0, ],
          mapping = aes(
            x = scenario,
            y = pct,
            group = minute_improvement,
            text = hover_text
          ),
          position = position_dodge2(
            padding = 0.1
          ),
          fill = "gray",
          alpha = 1
        ) +
        scale_y_continuous(
          labels = scales::label_percent(prefix = "+"),
          breaks = c(
            0.025,
            0.050,
            0.075,
            0.100
          )
        ) +
        scale_fill_manual(values = c(
          "#3CB371",
          "#319F5D",
          "#268B4A",
          spectrum_colors[[7]]
        )) +
        labs(
          title = "Job Accessibility",
          x = "",
          y = ""
        ) +
        app_theme() +
        theme(
          # axis.title.x = ggplot2::element_text(
          #   vjust = -1,
          #   family = font_families$font_family_axis_title,
          #   size = font_sizes$font_size_axis_title
          # ),
          # axis.title.y = ggplot2::element_text(
          #   vjust = 2,
          #   family = font_families$font_family_axis_title,
          #   size = font_sizes$font_size_axis_title
          # ),
          axis.text.x = ggplot2::element_text(
            family = font_families$font_family_axis_text,
            size = font_sizes$font_size_axis_text,
            vjust = 0.5
          ),
          axis.text.y = ggplot2::element_text(
            family = font_families$font_family_axis_text,
            size = font_sizes$font_size_axis_text,
            vjust = 1
          )
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
          y = -0.125
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
# mod_plot_job_access_ui("plot_job_access_ui_1")

## To be copied in the server
# callModule(mod_plot_job_access_server, "plot_job_access_ui_1")
