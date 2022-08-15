ui <- fluidPage(
  titlePanel("Temperatura promedio mensual en Nottingham"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("anio", label = "Año", min = 1920, max = 1939, value = 1930),
      fileInput("carga", NULL, buttonLabel = "Cargar archivo .csv", accept = ".csv"),
      numericInput("nuevo_anio", "Nuevo año", value = "1940")
    ),
    mainPanel(
      plotOutput("barras"),
      verbatimTextOutput("min_max")
    )
  )
)




# ui <- fluidPage(
#   titlePanel("Temperatura promedio mensual en Nottingham"),
#   sidebarLayout(
#     sidebarPanel(
#       sliderInput("anio", label = "Año", min = 1920, max = 1939, value = 1930),
#       fileInput("carga", NULL, buttonLabel = "Cargar archivo .csv", accept = ".csv"),
#       numericInput("nuevo_anio", "Nuevo año", value = "1940", min = "1940")
#     ),
#     mainPanel(
#       plotOutput("barras"),
#       verbatimTextOutput("min_max")
#     )    
#   )
# )
