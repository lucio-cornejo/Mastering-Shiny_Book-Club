library(shiny)

temperaturas <- read.csv("data/temperaturas.csv")

server <- function (input, output) {
  temp_anual <- reactive({
    anio <- input$anio
    temperatura_anual <- temperaturas[temperaturas$anio == anio,]
    temperatura_anual <- unlist(temperatura_anual)[-1]
    temperatura_anual
  })

  output$barras <- renderPlot({
    barplot(
      height = temp_anual(), col = "skyblue", 
      xlab = "", ylab = "Temperatura promedio",
      main = paste0("Año ", input$anio),
      names = names(temp_anual()), las = 2
    )
  })

  output$min_max <- renderPrint({
    mes_max_temperatura <- colnames(temperaturas)[1+which.max(temp_anual())]
    mes_min_temperatura <- colnames(temperaturas)[1+which.min(temp_anual())]
    print(mes_max_temperatura)
    print(mes_min_temperatura)
  })
}





# library(shiny)

# temperaturas <- read.csv("data/temperaturas.csv")

# server <- function(input, output) {
#   temp_anual <- reactive({
#     anio <- input$anio
#     temperatura_anual <- temperaturas[temperaturas$anio == anio,]
#     temperatura_anual <- unlist(temperatura_anual)[-1]
#     temperatura_anual
#   })

#   output$barras <- renderPlot({
#     barplot(
#       height = temp_anual(), col ="skyblue",
#       xlab = "", ylab = "Temperatura promedio",
#       main = paste0("Año ", input$anio),
#       names = colnames(temp_anual())[-1], las = 2
#     )
#   })

#   output$min_max <- renderPrint({
#     mes_max_temperatura <- colnames(temperaturas)[1+which.max(temp_anual())]
#     mes_min_temperatura <- colnames(temperaturas)[1+which.min(temp_anual())]
#     print(paste0("Temperatura máxima: ", mes_max_temperatura))
#     print(paste0("Temperatura mínima: ", mes_min_temperatura))
#   })
# }
