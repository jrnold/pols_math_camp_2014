library("shiny")
library("ggplot2")

shinyServer(function(input, output) {
    
    output$plot <- renderPlot({
        x <- seq(input$xmin, input$xmax, length = 101)
        beta <- c(input$b0, input$b1, input$b2, input$b3)
        y <- sapply(0:3, function(i) x^i) %*% beta
        data1 <- data.frame(x = x, y = y)

        h <- 10^input$logh
        x0 <- input$x
        x1 <- input$x + h
        y0 <- sum(beta * x0^(0:3))
        y1 <- sum(beta * x1^(0:3))
        m <- (y1 - y0) / (x1 - x0)
        b <- y0 - m * x0
        dfdx <- sum(c(input$b1, 2 * input$b2, 3 * input$b3) * (x0^(0:2)))
        
        print(ggplot()
              + geom_line(data = data1, mapping = aes(x = x, y = y))
              + geom_abline(intercept = b, slope = m, colour = "blue")
              + geom_point(data = data.frame(x = x1, y = y1),
                           mapping = aes(x = x, y = y),
                           colour = "blue")
              + geom_point(data = data.frame(x = x0, y = y0),
                           mapping = aes(x = x, y = y),
                           colour = "red")
              + geom_abline(intercept = y0 - dfdx * x0, slope = dfdx, colour = "red")
              + scale_x_continuous(limits = c(input$xmin, input$xmax))
              #+ scale_y_continuous(limits = c(input$ymin, input$ymax))
              )
    })

    output$text <- renderUI({
        beta <- c(input$b0, input$b1, input$b2, input$b3)
        h <- 10^input$logh
        x0 <- input$x
        x1 <- input$x + h
        y0 <- sum(beta * x0^(0:3))
        y1 <- sum(beta * x1^(0:3))
        m <- (y1 - y0) / h
        dfdx <- sum(c(input$b1, 2 * input$b2, 3 * input$b3) * (x0^(0:2)))
        list(HTML(sprintf("f(x) = %d + %d x + %d x<sup>2</sup> + %d x<sup>3</sup>",
                          input$b0, input$b1, input$b2, input$b3)),
             br(),
             HTML(sprintf("f'(x) = %d + %d x + %d x<sup>2</sup> = %f",
                          input$b1, 2 * input$b2, 3 * input$b3, dfdx)),
             br(),
             sprintf("h = %f", h),
             br(),
             HTML(sprintf("(f(x + h) - f(x)) / h = %f", m))
             )
    })
})
