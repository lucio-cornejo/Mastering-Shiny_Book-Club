library(shiny)

ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("resumen"),
  tableOutput("tabla")
)
server <- function(input, output, session) {
  # Creamos una expresión reactiva
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })

  output$resumen <- renderPrint({
    # Usamos la expresión reactiva como si fuese una función
    summary(dataset())
  })
  
  output$tabla <- renderTable({
    dataset()
  })
}

shinyApp(ui, server)
