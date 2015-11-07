library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hello Shiny!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput('show_vars', 'Columns in dataset to show:',
                         names(emergency2013), selected = names(emergency2013))
    ),
    
    # Show a summary table of the selected variables
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel('emergency2013', dataTableOutput('mytable1')))
        tabPanel('emergency2013', plotOutput('myplot')))
    )
  )
))