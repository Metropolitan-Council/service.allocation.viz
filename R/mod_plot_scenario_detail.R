#' plot_access_all_day UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_scenario_detail_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotlyOutput(ns("new_all_day"), width = "90%")
  )
}

#' plot_access_all_day Server Function
#'
#' @noRd
mod_plot_scenario_detail_server <- function(
                                           input,
                                           output,
                                           session,
                                           data_for_plotting = data_for_plotting,
                                           plot_type,
                                           unit_type) {
  ns <- session$ns

  output$new_all_day <- renderPlotly({

    if(nrow(data_for_plotting$detail_data[expand_improve == plot_type,][type == unit_type,]) > 2){
      coords_x <- c(0,0,1,1)
      coords_y <- c(0,1,1,0)
      plot_color <- rep(people_color, 4)
    } else {
      coords_x <- c(1,0)
      coords_y <- c(0,0)
      plot_color <- rep(job_color, 2)
    }

    ggplotly(
      tooltip = "text",
      ggplot(data = data_for_plotting$detail_data[!item_category %in% c("pop", "emp"),][expand_improve == plot_type,][type == unit_type,]) +
        geom_tile(
          aes(x = coords_x,
              y = coords_y,
              fill = item_unit_factor,
              text = hover_text),
          show.legend = F,
          width = 1,
          color = "white",
          lwd = 5) +
        geom_text(
          aes(
            x = coords_x,
            y = coords_y + 0.01,
            label = str_wrap(lab, width = 12)
          ),
          position = position_dodge(width = 0),
          family = font_families$font_family_title,
          size = "4.5"
        ) +
        scale_fill_manual(values = plot_color) +
        # labs(title = paste0(plot_all_day_data$summary_title[1])) +
        app_theme()
    ) %>%
      plotly::layout(
        margin = list(l = 0, r = 0, b = 10, t = 5, pad = 0), # l = left; r = right; t = top; b = bottom
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
# mod_plot_scenario_detail_ui("plot_access_all_day_ui_1")

## To be copied in the server
# callModule(mod_plot_scenario_detail_server, "plot_access_all_day_ui_1")
