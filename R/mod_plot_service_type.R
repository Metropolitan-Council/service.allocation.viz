#' plot_service_type UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_service_type_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotlyOutput(ns("service_type_plot"))
  )
}

#' plot_service_type Server Function
#'
#' @noRd
mod_plot_service_type_server <- function(
  input,
  output,
  session,
  data_for_plotting = data_for_plotting
  ) {
  ns <- session$ns


  output$service_type_plot <- plotly::renderPlotly({

    ggplotly(
      tooltip = "text",
      ggplot(data = data_for_plotting$service_type_by_tma[service_type %in% c("Local",
                            "High frequency"),][item == "pop_total",]) +
        geom_col(
          mapping = aes(
            x = scenario_short,
            y = val_increase,
            fill = service_type,
            group = market_area,
            text = hover_text
          ),
          color = "white",
          lwd = 0.4) +
        geom_col(data = data_for_plotting$service_type_by_tma[service_type %in% c("Local",
                                                                                  "High frequency"),][item == "pop_total",][selected == 0,],
          mapping = aes(
            x = scenario_short,
            y = val_increase,
            group = market_area,
            text = hover_text
          ),
          fill = "white",
          alpha = 0.7) +
        scale_y_continuous(labels = scales::comma) +
        labs(
          x = "People",
          y = "",
          title = "Change in Acess to Transit by Service Level"
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
# mod_plot_service_type_ui("plot_service_type_ui_1")

## To be copied in the server
# callModule(mod_plot_service_type_server, "plot_service_type_ui_1", slider_input = slider_input)
