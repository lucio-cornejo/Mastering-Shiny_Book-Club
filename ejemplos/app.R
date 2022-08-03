library(shiny)

ui <- fluidPage(
  "Hola, mundo."
)

server <- function(input, output) {
}

shinyApp(ui, server)