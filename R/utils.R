latex2fun_safe = function(code) {
  tryCatch({
    shinymath::latex2fun(code)
  },
  latex2r.error = function(cnd) {
    shiny::showNotification(
      paste("Error when translating to R code:", sub("Error: ", "", cnd$message)),
      type = "error"
    )
  },
  error = function(cnd) {
    shiny::showNotification("Unexpected error", type = "error")
  })
}

pkg_file = function(...) {
  system.file(..., package = "ifuns", mustWork = TRUE)
}
