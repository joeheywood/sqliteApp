#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(RSQLite)
db <- dbConnect(SQLite(), "tud2.sqlite")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$tables <- renderText({
        paste(dbListTables(db), sep=" | ")
    })

    output$fields <- renderTable({
        words <- strsplit(input$sqlEdit, " ")[[1]]
        output$msg <- renderText({length(words)})
        tbls <- dbListTables(db)
        words <- words[words %in% tbls]
        if(length(words > 0)) {
            flds <- vapply(words, function(x) {
                paste(dbListFields(db, x), collapse = " | ")
            }, "")
            data.frame(table = words, fields = flds)
        } else {
            data.frame()
        }
    }, include.rownames = F)

    #output$msg <- renderText({input$isCtrl})

    output$res <- renderDataTable({
        if(is.null(input$lastkey)) {return(data.frame())}
        if(input$isCtrl == TRUE & input$lastkey == 13) {
            sql <- input$sqlEdit
            dbGetQuery(db, sql)
        } else {
            data.frame(a = 1, b = 2)
        }
    })
})
