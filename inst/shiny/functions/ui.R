library("shiny")

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Common Functions"),

  sidebarPanel(
      submitButton("Update"),
      selectInput("funtype", strong("Function Type"),
                  list("polynomial" = "polynomial",
                       "exponential" = "exponential",
                       "logarithm" = "logarithm",
                       "radical" = "radical")),
      conditionalPanel(condition = "input.funtype == 'polynomial'",
                       p(strong("Polynomial coefficients")),
                       numericInput("b0", "1", 0),
                       numericInput("b1", "x", 1),
                       numericInput("b2", HTML("x<sup>2</sup>"), 0),
                       numericInput("b3", HTML("x<sup>3</sup>"), 0),
                       numericInput("b4", HTML("x<sup>4</sup>"), 0),
                       numericInput("b5", HTML("x<sup>5</sup>"), 0)
                       ),
      conditionalPanel(condition = "input.funtype == 'exponential'",
                       p(strong("f(x) = a exp(b x)")),
                       numericInput("exp_a", "a", 1),
                       numericInput("exp_b", "b", 1)
                       ),
      conditionalPanel(condition = "input.funtype == 'logarithm'",
                       p(strong("f(x) = a log(b x)")),
                       numericInput("log_a", "a", 1),
                       numericInput("log_b", "b", 1)
                       ),
      conditionalPanel(condition = "input.funtype == 'radical'",
                       p(strong("f(x) = a x^(b / r)")),
                       numericInput("rad_root", "root", 1, min=1),
                       numericInput("rad_a", "a", 1),
                       numericInput("rad_b", "b", 1)
                       ),
      p(strong("Plot limits")),
      numericInput("xmin", "min(x):", -4),
      numericInput("xmax", "max(x):", 4)
      ## numericInput("ymin", "y min:", -4),
      ## numericInput("ymax", "y max:", 4)     
      ),

  mainPanel(
      uiOutput("text1"),
      plotOutput("plot"),
      uiOutput("text2"),
      plotOutput("plot2")
      )
))
