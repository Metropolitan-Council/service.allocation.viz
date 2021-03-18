#' plot_people_jobs_detail UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_people_jobs_detail_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotly::plotlyOutput(ns("scenario_detail"))
  )
}

#' plot_people_jobs_detail Server Function
#'
#' @noRd
mod_plot_people_jobs_detail_server <- function(
  input,
  output,
  session,
  data_for_plotting = data_for_plotting,
  plot_expand_improve = c("Expand", "Improve"),
  plot_type = c("People", "Jobs")
) {
  ns <- session$ns

  output$scenario_detail <- plotly::renderPlotly({
    ggplotly(
      tooltip = "text",
      ggplot(data_for_plotting$detail_data[plot_data_type == plot_type][expand_improve == plot_expand_improve]) +
        geom_col(
          mapping = aes(
            x = scenario_short,
            y = total,
            fill = item_unit_label,
            text = hover_text,
            group = scenario_short
          ),
          position = position_dodge2(
            padding = 0.1
          )
        ) +
        # geom_col(
        #   data = data_for_plotting$detail_data[plot_data_type == plot_type][expand_improve == plot_expand_improve][selected == 0],
        #   mapping = aes(
        #     x = scenario_short,
        #     y = total,
        #     # fill = item_unit_label,
        #     text = hover_text,
        #     group = scenario_short
        #   ),
        #   position = position_dodge2(
        #     padding = 0.1
        #   ),
        #   fill = "white",
        #   alpha = 0.7
        # ) +
        scale_y_continuous(
          labels = scales::label_comma(prefix = "+"),
          limits = if(plot_expand_improve == "Expand"){
            c(0, 70000)
          } else {
            c(0, 500000)
          }
        ) +
        # scale_fill_manual(values = c(
        #   "#3CB371",
        #   "#319F5D",
        #   "#268B4A",
        #   spectrum_colors[[7]]
        # )) +
        labs(
          title = paste0(plot_type),
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
          y = -0.125,
          font = list(
            size = 12
          )
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
# mod_plot_people_jobs_detail_ui("plot_people_jobs_detail_ui_1")

## To be copied in the server
# callModule(mod_plot_people_jobs_detail_server, "plot_people_jobs_detail_ui_1", data_for_plotting = data_for_plotting,
# plot_expand_improve = c("Expand", "Improve"),
# plot_type = c("People", "Jobs"))
