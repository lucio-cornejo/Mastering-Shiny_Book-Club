library(shiny)

ui <- fluidPage(
  fileInput(
    inputId = "carga", label = NULL, 
    buttonLabel = "Cargar archivo", accept = c(".sav", ".xlsx")
  ),
  numericInput("n", "Filas", value = 5, min = 1, step = 1),
  tableOutput("cabeza")
)

server <- function(input, output, session) {
  data <- reactive({
    req(input$carga)
    
    # Extensión del archivo cargado
    ext <- tools::file_ext(input$carga$name)
    switch(ext,
      sav = haven::read_sav(input$carga$datapath),
      xlsx = xlsx::read.xlsx(input$carga$datapath, sheetIndex = 1),
      validate("Solo aceptamos archivos de tipo .sav o .xlsx")
    )
  })
  
  output$cabeza <- renderTable({
    head(data(), input$n)
  })
}

shinyApp(ui, server)
