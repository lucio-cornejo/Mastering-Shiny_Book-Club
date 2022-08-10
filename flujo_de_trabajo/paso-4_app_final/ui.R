ui <- fluidPage(
  titlePanel("Temperatura promedio mensual en Nottingham"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("anio", label = "Año", min = 1920, max = 1939, value = 1930),
      downloadButton("reporte", "Generar reporte")
    ),
    mainPanel(
      plotOutput("barras"),
      verbatimTextOutput("min_max")
    )    
  )
)
