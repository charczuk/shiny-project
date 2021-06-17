# This is some ecommerce data for online, offline, and total sales.  
# The application allows you to see relationships between the two and
# find clusters in that relationship.
# Data frame includes multiple inputs (spend, cost-per-click, etc) that 
# influence the offline/online/total sales numbers.

library(shiny)
library(dplyr)

df <- read.csv("all.csv", stringsAsFactors = FALSE) %>% select(2:7,9,11:40)
df <- df[complete.cases(df),]

function(input, output, session) {
    
    # Combine the selected variables into a new data frame
    selectedData <- reactive({
        df[, c(input$xcol, input$ycol)]
    })
    
    clusters <- reactive({
        kmeans(selectedData(), input$clusters)
    })
    
    output$plot1 <- renderPlot({
        palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
                  "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
        
        par(mar = c(5.1, 4.1, 0, 1))
        plot(selectedData(),
             col = clusters()$cluster,
             pch = 20, cex = 3)
        points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    })
    
}