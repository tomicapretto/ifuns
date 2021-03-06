# Added grey in first place
COLORS = c('#808080', '#c23531', '#2f4554', '#61a0a8', '#d48265',
           '#91c7ae', '#749f83', '#ca8622')

plot_base = function() {
  plotly::plot_ly(
    type = "scatter",
    mode = "lines",
    colors = COLORS
  ) %>%
  plotly::layout(
    showlegend  = TRUE,
    legend = list(yanchor = "top", xanchor = "right", y = 0.99, x = 0.9,
                  bgcolor = 'rgba(0,0,0,0)', font = list(size = 16)),
    xaxis = list(range = c(-5, 5)),
    yaxis = list(range = c(-5, 5)),
    dragmode = "pan",
    colorway = COLORS,
    font = list(family = "Arial")
  ) %>%
  plotly::animation_opts(
    transition = 500,
    redraw = FALSE
  ) %>%
  plotly::config(
    mathjax = "cdn",
    scrollZoom = TRUE,
    displayModeBar = FALSE
  )
}

plot_add_trace = function(data, plot_name, name, session) {
  plotly::plotlyProxy(plot_name, session) %>%
    plotly::plotlyProxyInvoke(
      "addTraces",
      list(
        x = data$x,
        y = data$y,
        line = list(simplify = FALSE),
        type = "scatter",
        mode = "lines",
        name = plotly::TeX(name),
        hoverinfo = "skip"
      )
    )
}

plot_remove_trace = function(idx, session) {
  plotly::plotlyProxy("plot", session) %>%
    plotly::plotlyProxyInvoke("deleteTraces", idx)
}

plot_update = function(data, session) {
  # 'data' is a list that contains 'n' lists with vectors 'x' and 'y'
  plotly::plotlyProxy("plot", session) %>%
    plotly::plotlyProxyInvoke(
      "animate",
      list(
        data = data,
        traces = as.list(seq(length(data)))
      )
    )
}
