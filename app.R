#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(cfbfastR)
Sys.setenv(CFBD_API_KEY = "r3iuRSkLeTGBugPmK+4ARytbfFkkxbm/Mvk9nW8bQwKhqmhQK1UvQ8cP7owKHnhC")

lsu2020 <- cfbd_stats_season_advanced(2020, team = "LSU")
lsu2020player <- cfbd_stats_season_player(2020, team = "LSU")

# Define UI for application that prints a table of a dataset
ui <- fluidPage(
    selectInput("dataset", label = "Dataset", choices = ls()),
    tableOutput("table")
)

# Define server logic required to print a dataset
server <- function(input, output, session) {
    
    # Create a reactive expression
    dataset <- reactive({
        get(input$dataset)
    })
    
    output$table <- renderPrint({
        #Use a reactive expression by calling it like a function
        glimpse(dataset())
    })
    
    output$table <- renderTable({
        dataset()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
