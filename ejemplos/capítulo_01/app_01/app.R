library(shiny)

ui <- fluidPage(
  "Hola, mundo"
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
