library("shiny")

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Tangent"),

  sidebarPanel(
      submitButton("Update"),
      p(strong("Polynomial coefficients")),
      numericInput("b0", "1", 0),
      numericInput("b1", "x", 1),
      numericInput("b2", HTML("x<sup>2</sup>"), 0),
      numericInput("b3", HTML("x<sup>3</sup>"), 0),
      p(strong("Derivative at")),
      numericInput("x", "x = ", 0),
      numericInput("logh", HTML("log<sub>10</sub> h"), 0, step = 0.25),
      p(strong("Plot limits")),
      numericInput("xmin", "min(x):", -4),
      numericInput("xmax", "max(x):", 4)
      ## numericInput("ymin", "y min:", -4),
      ## numericInput("ymax", "y max:", 4)     
      ),

  mainPanel(
      uiOutput("text"),
      plotOutput("plot")
      )
))
