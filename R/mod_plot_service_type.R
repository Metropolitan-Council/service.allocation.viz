#' plot_service_type UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_service_type_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotlyOutput(ns("service_type"))

  )
}

#' plot_service_type Server Function
#'
#' @noRd
mod_plot_service_type_server <- function(input, output, session,
                                         slider_input = slider_input){
  ns <- session$ns

  service_type_plot_data <- reactive({
    se_service_type[scenario_id == slider_input$slider, ]
  })

  output$service_type <- plotly::renderPlotly({
    # browser()
    plot_service_data <- service_type_plot_data()

    ggplotly(
      tooltip = "text",
      ggplot(data = plot_service_data) +
        geom_col(aes(y = service_type,
                     x = total_value,
                     text = hover_text)) +
        scale_x_continuous(labels = scales::comma) +
        labs(x = "People",
             y = "") +
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
          )
        )

    ) %>%
      plotly::layout(
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
# mod_plot_service_type_ui("plot_service_type_ui_1")

## To be copied in the server
# callModule(mod_plot_service_type_server, "plot_service_type_ui_1", slider_input = slider_input)

