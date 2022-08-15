library(shiny)

ui <- fluidPage(
  numericInput("y", "num", 2),
  verbatimTextOutput("x")
)

server <- function(input, output, session) {
  output$x <- renderPrint(
    session$clientData
  )
}

shinyApp(ui, server)