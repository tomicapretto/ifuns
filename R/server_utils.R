add_param_slider = function(params) {
  ids = paste0("param_", params)
  mapply(slider_input_div, ids, params, min = -10, max = 10, value = 2, step = 0.1,
         SIMPLIFY = FALSE, USE.NAMES = FALSE)
}

slider_input_div = function(id, param, ...) {
  ui_row(
    id = paste0("div_", id),
    style = "padding-bottom:0;",
    katexR::katex(add_slashes(param)),
    rangeInput(id, ...)
  )
}

add_equation = function(equations, id, output, session) {
  ns = session$ns
  insertUI(
    selector = "#equations",
    ui = ui_row(
      id = paste0("div_", id),
      ui_col(
        width = 14,
        katexR::katex(equations$katex(id))
      ),
      ui_col(
        width = 2,
        tags$div(
          style = "margin-top: 2px; margin-left: -10px; font-size: 18px;",
          link_remove(paste0("btn_remove_", id))
        )
      )
    )
  )
}

add_params = function(equations, id) {
  params = equations$get_args_unique(id)
  if (length(params) > 0) {
    insertUI(
      selector = "#parameters",
      ui = add_param_slider(params)
    )
  }
}

remove_params = function(equations, id) {
  params = equations$get_args_unique(id)
  if (length(params) > 0) {
    lapply(paste0("#div_param_", params), removeUI)
  }
}

GREEKS = paste0(c(
  "alpha", "theta", "tau", "beta", "vartheta", "pi", "upsilon",
  "gamma", "varpi", "phi", "delta", "kappa", "rho",
  "varphi", "epsilon", "lambda", "varrho", "chi", "varepsilon",
  "mu", "sigma", "psi", "zeta", "nu", "varsigma", "omega", "eta",
  "xi", "Gamma", "Lambda", "Sigma", "Psi", "Delta", "Xi",
  "Upsilon", "Omega", "Theta", "Pi", "Phi"
), collapse = "|")

add_slashes = function(x) {
  stringr::str_replace(x, GREEKS, function(x) paste0("\\", x))
}





