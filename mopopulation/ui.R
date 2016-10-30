# mopopulation shiny web app ui.R

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Missouri Population (1900-2010)"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("year",
                   "Decennial Census Year:",
                   min = 1900,
                   max = 2010,
                   value = 2010,
                   step = 10,
                   sep = '',
                   animate=animationOptions(interval=2000, loop = T)),
       br(),
       checkboxInput("checkbox", 
                     label = "Plot log of population?", 
                     value = FALSE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(br(),
       plotOutput("moPlot"),
       includeHTML("include.html")
    )
  )
))
