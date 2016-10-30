# mopopulation shiny web app server.R

library(shiny)
#library(leaflet)
#library(lubridate)
library(choroplethr)
library(choroplethrMaps)

# load the Missouri county population data file
mo_pop_data <- read.csv('mo_pop_data.csv', header = TRUE) 

# Define server logic required to draw the Missouri map
shinyServer(function(input, output) {
    mo_pop_county <- reactive({
        m <- data.frame(region = mo_pop_data$fips, 
                    value = mo_pop_data[,paste("X", 
                                               as.character(input$year), 
                                               sep = '')], 
                    row.names = 1:115)
        if (input$checkbox==TRUE) {
             m$value <- log(m$value)
        }
        m
    })
    

    Legend <- reactive({
        if (input$checkbox==TRUE) {
            l <-  'log10(Population)'
        } else {
            l <- 'Population'
        }
        l
    })
    
    Color <- reactive({
        if (input$checkbox==TRUE) {
            c <- 1
        } else {
            c <- 9
        }
        c
    })
    
    yearSum <- reactive({
        if (input$checkbox==TRUE) {
            prettyNum(sum(exp(mo_pop_county()$value)), big.mark = ',', 
                      trim = TRUE, scientific = FALSE)
        } else {
            prettyNum(sum(mo_pop_county()$value), big.mark = ',', 
                         trim = TRUE, scientific = FALSE)
        }
    })
    
    output$moPlot <- renderPlot({
            county_choropleth(mo_pop_county(),
                          title=paste(input$year, 
                                      ' Missouri Population (total = ',
                                      yearSum(), 
                                      ')', 
                                      sep = ''),
                          legend     = Legend(),
                          num_colors = Color(),
                          state_zoom = c('missouri')) 
    })
  
    output$year <- reactive({input$year})
})
