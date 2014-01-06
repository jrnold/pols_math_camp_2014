#' mathcamp
#'
#' Miscellaneous code for 
#'
#' @name mathcamp
#' @importFrom shiny runApp
#' @docType package
NULL

#' Run Shiny app
#'
#' @param example Name of the example to run. One of: \Sexpr{paste(dQuote(dir(system.file('shiny', package='mathcamp'))), collapse=", ")}
#' @param ... Passed to \code{\link{runApp}}.
#' @return This function is run for the side effect of starting the shiny app.
#' @export
run_shiny_example <- function(example, ...) {
    runApp(file.path(system.file('shiny', package='mathcamp'), example), ...)
}
