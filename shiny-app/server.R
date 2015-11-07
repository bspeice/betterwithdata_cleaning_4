library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  emergency2013 <- read.csv("./data/emergency2013.csv")
  
  output$distPlot <- renderPlot({
   plot(faithful$eruptions, faithful$waiting)
  })
})