# Fijar ruta
setwd("D:/Mastering-Shiny_Book-Club/flujo_de_trabajo/paso-0_base")

# Base de datos usada para crear el data frame "temperaturas":
# nottem (Average Monthly Temperatures at Nottingham, 1920-1939)
temperaturas <- read.csv("temperaturas.csv")

# Fijar un año
# Años posibles: 1920 a 1939
anio <- 1930

# Diagrama de barras
temperatura_anual <- temperaturas[temperaturas$anio == anio,]
temperatura_anual <- unlist(temperatura_anual)[-1]

barplot(
  height = temperatura_anual, col ="skyblue",
  xlab = "", ylab = "Temperatura promedio",
  main = paste0("Año ", anio),
  names = colnames(temperatura_anual)[-1], las = 2
)

# Meses de mínima y máxima temperatura
mes_max_temperatura <- colnames(temperaturas)[1+which.max(temperatura_anual)]
mes_min_temperatura <- colnames(temperaturas)[1+which.min(temperatura_anual)]

mes_max_temperatura
mes_min_temperatura
