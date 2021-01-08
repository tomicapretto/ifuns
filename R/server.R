server = function(input, output, session) {

  rvs = reactiveValues(args = NULL, count = 0, ids = character())
  equations = Equations$new("x",  c(-10, 10))

  output$plot = plotly::renderPlotly({
    plot_base()
  })

  observe({
    if (rvs$count > 0) {
      shinyjs::show("param_container")
    } else {
      shinyjs::hide("param_container")
    }
  })

  observeEvent(input$add, {
    expr = latex2fun_safe(input$math)
    req(is.function(expr))

    id = equations$add(input$math, expr)
    add_equation(equations, id, output, session)
    add_params(equations, id)

    rvs$args = equations$get_args_all()
    rvs$count = equations$count()
    rvs$ids = c(rvs$ids, id)

    # 2 is the starting value by default
    args = replicate(length(equations$get_args(id)), 2, simplify = FALSE)
    names(args) = equations$get_args(id)


    plot_add_trace(
      equations$evaluate(id, args),
      "plot",
      equations$katex(id),
      session
    )

    observeEvent(input[[paste0("btn_remove_", id)]], {
      idx = which(rvs$ids == id)
      rvs$names = rvs$names[-idx]
      plot_remove_trace(idx, session)
      removeUI(paste0("#", session$ns(paste0("div_", id))))
      remove_params(equations, id)
      equations$remove(id)
      rvs$count = equations$count()
    }, ignoreInit = TRUE)

  }, priority = 1)


  listen_to_update = shiny::debounce(shiny::reactive({
    req(rvs$count > 0)
    req(unlist(sapply(paste0("param_", rvs$args), function(x) input[[x]])))
    sapply(paste0("param_", rvs$args), function(x) input[[x]])
  }), millis = 500)

  observeEvent(listen_to_update(), {
    argvals = as.list(vapply(paste0("param_", rvs$args), function(x) {input[[x]]}, numeric(1)))
    names(argvals) = rvs$args
    data = equations$evaluate_all(argvals)
    names(data) = NULL
    plot_update(data, session)
  }, ignoreInit = TRUE)

}
