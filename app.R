library(shiny)
library(palmerpenguins)
library(ggplot2)
library(dplyr)

x_vector <- colnames(penguins)
y_vector <- colnames(select(penguins, where(is.numeric)))
colour_vector <- colnames(select(penguins, where(is.factor)))
summary_vector <- colnames(select(penguins, where(is.factor)))

ui <- fluidPage(
  titlePanel("Penguins Plots"),
  sidebarLayout(
    sidebarPanel(
      selectInput("xaxis", label = "x-axis", choices = x_vector), 
      selectInput("yaxis", label = "y-axis", choices = y_vector), 
      selectInput("colour", label = "Colour", choices = colour_vector),
      selectInput("table_value", label = "Table Value", choices = y_vector),
      selectInput("table_group", label = "Table Grouping", choices = summary_vector),
      img(src = "penguins_img.png", width = "97%", align = "left")
  ), 
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot1")),
      tabPanel("Summary Table", tableOutput("table1")),
    )
  )
)
)

server <- function(input, output, session) {
  output$plot1 <- renderPlot({
    ggplot(data = penguins, mapping = aes_string(x = input$xaxis, y = input$yaxis)) +
      geom_jitter(aes_string(colour = input$colour), alpha = 0.5) +
      theme_minimal()
  })
  output$table1 <- renderTable({
    penguins %>%
      group_by(!!sym(input$table_group)) %>%
      summarize(mean = mean(!!sym(input$table_value), na.rm = TRUE), sd = sd(!!sym(input$table_value), na.rm = TRUE), n = n())
  })
}


shinyApp(ui, server)