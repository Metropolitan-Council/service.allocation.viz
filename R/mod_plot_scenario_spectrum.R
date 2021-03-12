#' plot_scenario_spectrum UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_scenario_spectrum_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotlyOutput(ns("scenario_spectrum"))
  )
}

#' plot_scenario_spectrum Server Function
#'
#' @noRd
mod_plot_scenario_spectrum_server <- function(input, output, session) {
  ns <- session$ns

  # more introductory text is needed
  # may need to invert text color against darker backgrounds
  # expand  = who didn't have access that now have access
  # improve = people who will get a better level of service
  #
  # Coverage trade-off
  # Highlight access to high frequency transit options
  # use green/purple throughout app
  # everything is gray-scale, as slider bar changes
  # make bar charts the focal points, everything else supplemental

  output$scenario_spectrum <- renderPlotly({
    ggplotly(
      tooltip = "text",
      ggplot(data = scenario_spectrum) +
        geom_tile(
          mapping = aes(
            x = scenario,
            y = y,
            fill = mix_value,
            text = stringr::str_wrap(hover_text, width = 60)
          ),
          show.legend = F
        ) +
        geom_text(
          mapping = aes(
            x = scenario,
            y = y + 0.6,
            label = scenario_priority
          )
        ) +
        geom_text(mapping = aes(
          x = scenario,
          y = y,
          label = stringr::str_wrap(hover_text, 20),
        )) +
        scale_fill_distiller(type = "div", palette = "PRGn") +
        scale_x_discrete(labels = scenario_spectrum$scenario) +
        app_theme() +
        ggplot2::theme(
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
# mod_plot_scenario_spectrum_ui("plot_scenario_spectrum_ui_1")

## To be copied in the server
# callModule(mod_plot_scenario_spectrum_server, "plot_scenario_spectrum_ui_1")
