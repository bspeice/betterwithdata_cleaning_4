library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  emergency2013 <- read.csv("./data/emergency2013.csv")
  
  output$mytable1 <- renderDataTable({
      emergency2013[, input$show_vars, drop = FALSE]
  })
  output$myplot <- renderPlot({
    library(ggplot2)
    library(corrplot)
    pairs(emergency2013[, input$show_vars, drop = FALSE])
  })
})