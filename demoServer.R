library(shiny)

function(input, output, session) {
   output$plot1 <- renderPlot({
      iris %>% 
         ggplot(aes_string(x = input$xcol, y = input$ycol)) +
         geom_point()
   })
}