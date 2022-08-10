ui <- fluidPage(
  sliderInput("anio", label = "Año", min = 1920, max = 1939, value = 1930),
  plotOutput("barras"),
  verbatimTextOutput("min_max")
)
