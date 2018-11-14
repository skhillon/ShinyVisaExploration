library(shiny)

# Read in data
visas <- read_csv("h1b_kaggle.csv")

function(input, output, session) {
   output$plot1 <- renderPlot({
      iris %>% 
         ggplot(aes_string(x = input$xcol, y = input$ycol)) +
         geom_point()
   })
}