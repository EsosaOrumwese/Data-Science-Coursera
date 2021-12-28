
## Loading the necessary packages
library(shiny)
library(ggplot2)
library(curl)


shinyServer(function(input, output) {
        
        ## load data
        data("diamonds")

        ## Create the initial plot. Plot that'll show on startup
        output$distPlot <- renderPlot({
                # subset the data based on input. We want to carat and price values 
                # at the selected diamond factors (cut, color and clarity)
                diamonds_sub <- subset(diamonds, cut == input$cut &
                                               color == input$color &
                                               clarity == input$clarity)
        
                # plot the diamond data with carat and price
                p <- ggplot(diamonds_sub, aes(carat, price)) + geom_point() # creates a scatterplot of price to carat
                p <- p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price") # adds a smoothing line and labels the axes
                p <- p + xlim(0,6) + ylim(0,20000) # limits the plotting area
                p
                
                },height = 700)
        
        ## create linear model
        output$predict <- renderPrint({
                diamonds_sub <- subset(diamonds, cut == input$cut &
                                               color == input$color &
                                               clarity == input$clarity)
                
                fit <- lm(price~carat, diamonds_sub) # with price dependent on carat, we plot a linear regression model
                
                unname(predict(fit, data.frame(carat = input$lm))) ## Predicts the price for the given carat value. 
                # unname() removes the names of the returned object
        })
        
        observeEvent(input$predict, {
                distPlot <<- NULL ## ??
                
                output$distPlot <- renderPlot({
                        p <- ggplot(diamonds_sub, aes(carat, price)) + geom_point()
                        p <- p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
                        p <- p + xlim(0,6) + ylim(0,20000)
                        p
                }, height = 700)
        })
})
