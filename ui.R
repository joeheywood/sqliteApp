#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyAce)
source("viz.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  tags$script('
    $(document).on("keydown", function(e) {
    Shiny.onInputChange("lastkey", e.keyCode);
    Shiny.onInputChange("isCtrl", e.ctrlKey);
    });
  '),

    
  # Application title
  titlePanel("SQLite app"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        p(textOutput("tables")),
        tableOutput("fields"),
        p(textOutput("msg"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        aceEditor("sqlEdit", mode = "sql"),
        dataTableOutput("res")
    )
  )
))
