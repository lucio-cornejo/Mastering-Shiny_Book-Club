library(shiny)

# :::::::::
# Texto
# :::::::::
ui <- fluidPage(
  textOutput("texto"),
  verbatimTextOutput("codigo")
)
server <- function(input, output, session) {
  output$texto <- renderText("Hola, buenas.")
  output$codigo <- renderPrint({
    "Hola, buenas."
  })
}

# :::::::::
# Tablas
# :::::::::
ui <- fluidPage(
  tableOutput("estatico"),
  dataTableOutput("dinamico")
)
server <- function(input, output, session) {
  output$estatico <- renderTable(head(mtcars))
  output$dinamico <- renderDataTable(mtcars, options = list(pageLength = 5))
}

# :::::::::
# Gráficos
# :::::::::
ui <- fluidPage(
  plotOutput("grafico", width = "400px")
)
server <- function(input, output, session) {
  output$grafico <- renderPlot(
    plot(1:5), 
    # Resolucion del gráfico, en píxeles por pulgada
    res = 96
  )
}


shinyApp(ui, server)
