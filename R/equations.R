Equations = R6::R6Class(
  "Equations",
  public = list(
    equations = list(),
    variable = NULL,
    domain = NULL,
    initialize = function(variable, domain) {
      self$variable = variable
      self$domain = domain
    },
    add = function(expr, fun) {
      id = as.character(self$new_id())
      self$equations[[id]] = Equation$new(id, expr, fun, self$variable, self$domain)
      return(id)
    },
    remove = function(id) {
      self$equations[[id]] = NULL
    },
    new_id = function() {
      ids = as.numeric(names(self$equations))
      ids_seq = seq(length(self$equations))
      if (length(setdiff(ids_seq, ids)) > 0) {
        id = setdiff(ids_seq, ids)[1]
      } else {
        id = length(self$equations) + 1
      }
      return(id)
    },
    evaluate = function(id, args) {
      self$equations[[id]]$evaluate(args)
    },
    evaluate_all = function(args) {
      lapply(self$equations, function(x) x$evaluate(args))
    },
    katex = function(id) {
      self$equations[[id]]$katex()
    },
    get_args = function(id) {
      self$equations[[id]]$get_args()
    },
    get_args_all = function() {
      unique(unlist(lapply(self$equations, function(x) x$get_args()), use.names = FALSE))
    },
    get_args_without_id = function(id) {
      eqs = self$equations[setdiff(names(self$equations), id)]
      unique(unlist(lapply(eqs, function(x) x$get_args()), use.names = FALSE))
    },
    get_args_unique = function(id) {
      setdiff(self$get_args(id), self$get_args_without_id(id))
    },
    count = function() {
      length(self$equations)
    }
  )
)

Equation = R6::R6Class(
  "Equation",
  public = list(
    id = NULL,
    expr = NULL,
    fun = NULL,
    variable = NULL,
    args = NULL,
    initialize = function(id, expr, fun, variable, interval) {
      self$id = id
      self$expr = expr
      self$fun = fun
      self$variable = variable
      self$args = formalArgs(self$fun)
      private$get_domain(interval)
    },
    evaluate = function(args) {
      # 'args' must be a named list
      # Of all the args passed, only keep the ones in the function
      args = args[setdiff(self$args, self$variable)]

      # Append grid for the argument of the function
      if (self$variable %in% self$args) {
        domain_list = list(private$domain)
        names(domain_list) = self$variable
        args = c(domain_list, args)
      }
      return(list("x" = private$domain, "y" = do.call(self$fun, args)))
    },
    katex = function() {
      paste0("f_{", self$id, "}(x) = ", self$expr)
    },
    get_args = function() {
      setdiff(self$args, self$variable)
    }
  ),
  private = list(
    domain = NULL,
    get_domain = function(interval) {
      # TODO: Call SimPy?
      private$domain = seq(interval[1], interval[2], length.out = 2048)
    }
  )
)


# equations = Equations$new("x", c(-10, 10))
#
#
# equations$add("1/x + b", latex2r::latex2fun("1/x + b"))
# equations$add("ax + b", latex2r::latex2fun("ax + b"))
#
#
# equations$get_args("1")
# equations$get_args_unique("1")
#
# equations$get_args("2")
# equations$get_args_unique("2")
#
# args = list("a" = 1, "b" = 2)
#
# # equations$evaluate("1", args)
#
# x = equations$evaluate_all(args)
