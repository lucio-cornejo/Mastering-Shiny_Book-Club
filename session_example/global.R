########## PELIGRO ##########
# NO EJECUTAR ESTA APP, 
# EN CASO SUFRAS DE EPILEPSIA
#############################

library(shiny)

# Make a palette of 40 colors
colors <- rainbow(40, alpha = NULL)
# Mirror the rainbow, so we cycle back and forth smoothly
colors <- c(colors, rev(colors[c(-1, -40)]))
