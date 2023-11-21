library(shiny)
library(palmerpenguins)
library(ggplot2)

x_vector <- colnames(penguins)
y_vector <- colnames(select(penguins, where(is.numeric)))
colour_vector <- colnames(select(penguins, where(is.factor)))

ui <- fluidPage(
  selectInput("xaxis", label = "x-axis", choices = x_vector),
  selectInput("yaxis", label = "y-axis", choices = y_vector),
  selectInput("colour", label = "Colour", choices = colour_vector),
  plotOutput("plot1")
)

#need to fix colour output
server <- function(input, output, session) {
  output$plot1 <- renderPlot({
    ggplot(data = penguins, mapping = aes_string(x = input$xaxis, y = input$yaxis)) +
      geom_jitter(aes(colour = input$colour_vector), alpha = 0.5) +
      theme_minimal()
  })
}


shinyApp(ui, server)