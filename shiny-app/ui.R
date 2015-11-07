library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hello Shiny!"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      uiOutput('fileSelect'),
      uiOutput('columnList')
    ),
  # Show a summary table of the selected variables
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel('Data Table', dataTableOutput('mytable1')),
        tabPanel('Summary Statistics', dataTableOutput('mytable2')),
        tabPanel('Scatter Plots', plotOutput('myplot')))
    )
  )
)
)
