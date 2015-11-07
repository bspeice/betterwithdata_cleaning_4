library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  #datasets <- list.files('./data/')
  emergency2013 <- read.csv("./data/emergency2013.csv")
  
  

  output$fileSelect <- renderUI({
    selectInput("dataSetInput", "Choose your survey:", list.files('./data/'))
  })  
  
  #currentDataset <- read.csv(paste0('./data/', input$dataSetInput))
  
  output$columnList <- renderUI({
    currentDataset <- read.csv(paste0('./data/', input$dataSetInput, sep=''))
    checkboxGroupInput('show_vars', 'Columns in dataset to show:', names(currentDataset), selected = NULL)
  })


  
  output$distPlot <- renderPlot({
    currentDataset <- read.csv(paste0('./data/', input$dataSetInput, sep=''))
    plot(currentDataset$duid, currentDataset$vstctgry)
  })
  
  output$mytable1 <- renderDataTable({
      currentDataset <- read.csv(paste0('./data/', input$dataSetInput, sep=''))
      currentDataset[, input$show_vars, drop = FALSE]
  })
    
  output$mytable2 <- renderDataTable({
    currentDataset <- read.csv(paste0('./data/', input$dataSetInput, sep=''))
    summary(currentDataset[, input$show_vars, drop = FALSE])
    
  })
  output$myplot <- renderPlot({
    currentDataset <- read.csv(paste0('./data/', input$dataSetInput, sep=''))
    library(ggplot2)
    library(corrplot)
    pairs(currentDataset[, input$show_vars, drop = FALSE])

    currentDataset[, input$show_vars, drop = FALSE]

  })
})