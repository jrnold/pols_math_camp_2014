\name{run_shiny_example}
\alias{run_shiny_example}
\title{Run Shiny app}
\usage{
run_shiny_example(example, ...)
}
\arguments{
  \item{example}{Name of the example to run. One of:
  \Sexpr{paste(dQuote(dir(system.file('shiny',
  package='mathcamp'))), collapse=", ")}}

  \item{...}{Passed to \code{\link{runApp}}.}
}
\value{
This function is run for the side effect of starting the
shiny app.
}
\description{
Run Shiny app
}

