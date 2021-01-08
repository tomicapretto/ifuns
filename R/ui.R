sidebar = function() {
  tags$div(
    class = "ui sidebar inverted vertical visible menu",
    id = "sidebar",
    tags$div(
      class = "item",
      tags$p(
        class = "sidebar_header",
        "Interactive Function Graphs"
      )
    ),
    tags$div(
      class = "item",
      ui_grid(
        ui_row(
          ui_col(
            width = 14,
            shinymath::mathInput("math", "Write a function")
          ),
          ui_col(
            width = 2,
            tags$div(
              style = "margin-top: 25px; margin-left: -10px; font-size: 18px;",
              link_add("add")
            )
          )
        )
      )
    ),
    shinyjs::hidden(
      tags$div(
        id = "param_container",
        tags$div(
          class = "item",
          ui_grid(
            id = "equations"
          )
        ),
        tags$div(
          class = "item",
          ui_grid(
            ui_col(
              width = 16,
              id = "parameters"
            )
          )
        )
      )
    )
  )
}


body = function() {
  tags$div(
    style = "margin-left: 260px",
    tags$div(
      class = "ui container",
      plotly::plotlyOutput("plot", width = "100%", height = "800px")
    )
  )
}

ui = function() {
  shiny.semantic::semanticPage(
    tags$head(shiny::includeCSS(pkg_file("www", "style.css"))),
    shinyjs::useShinyjs(),
    sidebar(),
    body()
  )
}


# https://htmlcolorcodes.com/es/
