#load required packages
library(shiny)
library(palmerpenguins)
library(ggplot2)
library(dplyr)

#define vectors to be used as input choices
x_vector <- colnames(penguins)
y_vector <- colnames(select(penguins, where(is.numeric)))
colour_vector <- colnames(select(penguins, where(is.factor)))
summary_vector <- colnames(select(penguins, where(is.factor)))

#define user interface, including inputs to customize the plots and table
#the plot and table will be shown as outputs on separate tabs
#The four key features are created below: 
# (1) Plot with customizable input parameters - this is useful for selectively and efficiently viewing relationships between variables of interest
# (2) Table with customizable input parameters - this is useful for efficiently generating summary statistics of a desired variable ("Table Value") within specific groups (defined by "Table Variable")
# (3) Tabset format - the table and plot are on separate tabs, allowing clean visualization of less overwhelming amounts of data
# (4) Image - a representative image of penguins adds visual appeal to the interface

ui <- fluidPage(

  #Create the title panel and establish the sidebar layout format and sidebar panel
  titlePanel("Penguins Plots"),
  sidebarLayout(
    sidebarPanel(
      selectInput("xaxis", label = "x-axis", choices = x_vector), 
      selectInput("yaxis", label = "y-axis", choices = y_vector), 
      selectInput("colour", label = "Colour", choices = colour_vector),
      selectInput("table_value", label = "Table Value", choices = y_vector),
      selectInput("table_group", label = "Table Grouping", choices = summary_vector),

      #Add an image and customize its width and alignment to fit the page
      img(src = "penguins_img.png", width = "97%", align = "left")
  ), 
  
#Create main panel with separate tabs for the plot and the table
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot1")),
      tabPanel("Summary Table", tableOutput("table1")),
    )
  )
)
)

#the server function creates a jitterplot and a table, both mapped to the ui input options
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