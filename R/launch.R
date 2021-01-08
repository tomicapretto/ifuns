#' Launch app
#'
#' @importFrom shiny tags req observe reactiveValues observeEvent insertUI removeUI
#' @export

launch = function() {
  shiny::shinyApp(ui(), server)
}
