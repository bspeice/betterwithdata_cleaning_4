library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  emergency2013 <- read.csv("./data/emergency2013.csv")
  
  output$distPlot <-renderPlot({
    plot(emergency2013$duid, emergency2013$vstctgry)
  })
  
  output$mytable1 <- renderDataTable({

    emergency2013[, input$show_vars, drop = FALSE]

      
  })
})