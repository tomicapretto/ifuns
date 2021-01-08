#' Launch app
#'
#' @importFrom shiny tags insertUI removeUI
#' @export

launch = function() {
  shiny::shinyApp(ui(), server)
}
