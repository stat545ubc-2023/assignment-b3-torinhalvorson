# Shiny App: Penguins Plots


Link: https://torinhalvorson.shinyapps.io/assignment-b3-torinhalvorson/


## Description:
The goal of this project was to create a shiny app with three distinct features. This app uses the `penguins` dataset from the `palmerpenguins` package to create plots or summary tables of the data. The user specifies the x- and y-axes (labels: x-axis, y-axis), as well as the grouping colour (label 'Colour'), of the plot, and the table value (label: Table Value) and grouping variable (label: Table Grouping) for the table. The plot and the table are generated on two separate tabs for convenience. The app also includes an image of penguins to increase visual appeal.

## Features:

1. Plot with customizable input parameters
  - The user can specify any variable from the `penguins` dataset on the x-axis, any numeric variable on the y-axis, and any categorical variable as colour. 
  
2. Table with customizable grouping and summary variables
 - The user specifies one categorical variable from the `penguins` dataset to be used as a grouping variable, and a second numeric variable for which mean, standard deviation (sd) and count (n) are summarized in the table.
 
3. Tabset layout
 - The plot and table are generated on separate tabs, creating a clean layout
 
4. Image
 - A representative image of young penguins is included in the sidebar for visual appeal.