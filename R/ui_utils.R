link_add = function(id) {
  tags$a(
    id = id,
    href = "#",
    class = "action-button link_add",
    `data-val` = 0,
    list(shiny::icon("plus"), "")
  )
}

link_remove = function(id) {
  tags$a(
    id = id,
    href = "#",
    class = "action-button link_remove",
    `data-val` = 0,
    list(shiny::icon("times"), "")
  )
}

ui_grid = function(...) {
  tags$div(class = "ui grid", ...)
}

ui_row = function(...) {
  tags$div(class = "row", ...)
}

ui_col = function(width, ...) {
  opts = c("one", "two", "three", "four", "five", "six", "seven", "eight",
           "nine", "ten", "eleven", "twelve", "thirtheen", "fourteen",
           "fifteen", "sixteen")
  tags$div(class = paste(opts[width], "wide column"), ...)
}
