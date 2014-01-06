library("shiny")
library("ggplot2")

format_term <- Vectorize(function(a, k) {
    a <- as.character(a)
    if (k == 0) {
        as.character(a)
    } else if (k == 1) {
        sprintf("%s x", a)
    } else {
        sprintf("%s x^%d", a, k)
    }
})

shinyServer(function(input, output) {
    NOBS <- 101
    ORDER <- 5

    beta <- reactive({
        sapply(paste0("b", 0:ORDER), function(i) input[[i]])
    })

    dfdx <- reactive({
        1:ORDER * beta()[-1]
    })
    
    output$plot <- renderPlot({
        x <- seq(input$xmin, input$xmax, length = NOBS)
        if (input$funtype == "polynomial") {
            y <- sapply(0:ORDER, function(i) x^i) %*% beta()
        } else if (input$funtype == "logarithm") {
            x <- x[x > 0]
            y <- input$log_a * log(input$log_b * x)
        } else if (input$funtype == "exponential") {
            y <- input$exp_a * input$exp_b * exp(x * input$exp_b)
        } else if (input$funtype == "radical") {
            y <- input$rad_a * x^(input$rad_b / input$rad_root)
        }
        data1 <- data.frame(x = x, y = y)
        print(ggplot()
              + geom_line(data = data1, mapping = aes(x = x, y = y))
              + scale_x_continuous(limits = c(input$xmin, input$xmax))
              )
    })

    output$plot2 <- renderPlot({
        x <- seq(input$xmin, input$xmax, length = NOBS)
        if (input$funtype == "polynomial") {
            y <- sapply(0:(ORDER-1), function(i) x^i) %*% dfdx()
        } else if (input$funtype == "logarithm") {
            x <- x[x > 0]
            y <- input$log_a / x
        } else if (input$funtype == "exponential") {
            y <- input$exp_a * input$exp_b * exp(x * input$exp_b)
        } else if (input$funtype == "radical") {
            y <- (input$rad_a * input$rad_b / input$rad_root) * x^(input$rad_b / input$rad_root - 1)
        }
        data1 <- data.frame(x = x, y = y)
        print(ggplot()
              + geom_hline(yintercept = 0, colour = "gray")
              + geom_line(data = data1, mapping = aes(x = x, y = y))
              + scale_x_continuous(limits = c(input$xmin, input$xmax))
              )
    })

    
    output$text1 <- renderUI({
        if (input$funtype == "polynomial") {
            list(HTML(do.call(sprintf, as.list(c("f(x) = %s + %s x + %s x<sup>2</sup> + %s x<sup>3</sup> + %s x<sup>4</sup> + %s x<sup>5</sup>", beta()))))
                 )
        } else if (input$funtype == "exponential") {
            list(HTML(sprintf("f(x) = %s e<sup>%sx</sup>", as.character(input$exp_a), as.character(input$exp_b)))
                 )
        }  else if (input$funtype == "logarithm") {
            list(HTML(sprintf("f(x) = %s log(%sx)", as.character(input$log_a), as.character(input$log_b)))
                 )
        }   else if (input$funtype == "radical") {
            list(HTML(sprintf("f(x) = %s x <sup>%s / %s</sup>",
                              as.character(input$rad_a),
                              as.character(input$rad_b),
                              as.character(input$rad_root)))
                 )
        }
    })
    output$text2 <- renderUI({
        if (input$funtype == "polynomial") {
            list(
                 HTML(do.call(sprintf, as.list(c("f'(x) = %s + %s x + %s x<sup>2</sup> + %s x<sup>3</sup> + %s x<sup>4</sup>", dfdx()))))
                 )
        } else if (input$funtype == "exponential") {
            list(
                 HTML(sprintf("f'(x) = %s e<sup>%sx</sup>",
                              as.character(input$exp_a * input$exp_b),
                              as.character(input$exp_b)))
                 )
        }  else if (input$funtype == "logarithm") {
            list(
                 HTML(sprintf("f'(x) = %s / x", 
                              as.character(input$log_a)))
                 )
        }   else if (input$funtype == "radical") {
            list(HTML(sprintf("f(x) = %s x <sup>%s / %s - 1</sup>",
                              as.character(input$rad_a * input$rad_b / input$rad_root),
                              as.character(input$rad_b),
                              as.character(input$rad_root)))
                 )
        }
    })

})
