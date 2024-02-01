setwd("C:/Users/lenovo1/Google Drive/Documentos/EAE/bussiness_performance_analysis/clase_6")

library(haven)
library(tidyverse)
library(openxlsx)

data <- read.xlsx("datos_clase_muestra.xlsx")
data <- as_tibble(data)

data$sexo <- factor(data$sexo, 
                    levels = c(1,2),
                    labels = c("Hombre", "Mujer"))

data$edad_r <- factor(data$edad_r, 
                      levels = c(1,2,3,4,5,6),
                      labels = c("18-24", "25-34", "35-44", "45-54", "55-64", "65+"))

data$altura <- as.numeric(data$altura)
data$peso <- as.numeric(data$peso)

data

# Recordemos!!!
# En la última clase empezamos a adentrarnos en el terreno de la estadística inferencial, la cual, se encargaba de extaer información de los datos que iban más allá de la mera descripción.
# La modelización, se presenta como una de las herramientas más potentes de la estadística inferencial, siendo el modelo de regresión lineal, el algoritmo más básico y fundamental.
# En la sesión de hoy vamos a centrarnos en entender el funcionamiento del modelo de regresión lineal y su puesta en práctica.

# Vamos a ello!

# Imaginad que tenemos estas 2 variables
data$peso
data$altura

# Podemos extar información valiosa de forma univariada
summary(data$peso)
summary(data$altura)


# Podemos analizar la relación de estas dos variables
data %>%   ggplot() +
  geom_point(aes(y = peso, x = altura))

cor.test(data$altura, data$peso)


# Y...

# Podemos ajustar a estos datos un modelo

data %>%   ggplot() +
  geom_point(aes(y = peso, x = altura)) +
  geom_smooth(aes(y = peso, x = altura), method = "lm", se = F, color = "red", size = 1.2)

# Efectivamente esa linea que hemos trazado es un modelo.
# Modelo: Construción conceptual simplificada de una realidad más compleja

# Concretamente hemos ajustado un modelo de regresión lineal a este conjunto de datos

# ¿Por qué es util?

data %>%   ggplot() +
  geom_point(aes(y = peso, x = altura), alpha = 0) +
  geom_smooth(aes(y = peso, x = altura), method = "lm", se = F, color = "red", size = 1.2)

# La regresión lineal se usa para predecir el valor de una variable "Y" en función otra variable de predicción de entrada "X". 

# A la variable "Y" la llamamos variable dependiente, mientras que a la variable "X" variable independiente

# Por consiguiente, nos sirve para responder preguntas como….
# 
# ¿cual es el peso estimado de una persona que mida 1,80m?

###########################################
# ¿De donde sale esta recta de regresión? #
###########################################

data %>%   ggplot() +
  geom_point(aes(y = peso, x = altura)) +
  geom_smooth(aes(y = peso, x = altura), method = "lm", se = F, color = "red", size = 1.2)

# Por una nube de puntos pasan infinitas rectas. 
# ¿Con cuál debemos quedarnos? ¿Cómo determinamos cuál de todas esas rectas es la recta de regresión?

# En regresión lineal, es frecuente utilizar el método de Mínimos Cuadrados Ordinarios (MCO). 
# MCO es un método que consiste en minizar la suma de cuadrados de los residuos 
# con el objeto de estimar los parámetros del modelo.

# https://setosa.io/ev/ordinary-least-squares-regression/

###########################################
# Y esto matemáticamente como se traduce  #
###########################################
  
# todo modelo de regresión lineal se puede resumir en la siguiente ecuación:

# Y = β0 + β1 * X1

# β0: Este parametro la conocemos como la constante, y nos dice en que altura del eje Y empieza la recta de regresión
# β1: Este parametro determina la inclinación o pendiente de la recta y también nos indica la relación entre la relación de X e Y

########################################################################################################
# IMPORTANTE: En un modelo de regresión lineal la variable dependiente tiene que ser numética continua #
########################################################################################################

# Cuando ajustamos un modelo de regresión lineal a unos datos, lo que nos calcula en definitva R son los coeficientes β
 
#################################################
# ¿Qué β nos ha calculado R en nuestro ejemplo? #
#################################################

modelo_1 <- lm(formula = peso ~ altura, data = data)

summary(modelo_1)

# Ay madre mía que significa todo esto???

# Y = β0 + β1 * X1
# Y = -29.82099 + 0.60358 * X1


# ¿Cual sería el peso de una persona que mide 1,75?

-29.82099 + 0.60358 * 172

###########################################
# ¿Cómo se interpreta estos coeficientes? #
###########################################

# Las regresiones no solo sirven para predecir, también sirven para explicar como afectan unas variables sobre otras

###########################################
# ¿Son significativos estos coeficientes? #
###########################################

# Acordaros del contraste de hipótesis

###########################################
# ¿Cuál es la bondad de ajuste del modelo?#
###########################################

# Para eso nos fijamos en el parametro R2

# R2 mide el porcentaje de varianza de la variable 
# dependiente que queda explicado con nuestro modelo

# Okey?

# Ahora bien!!!!

################################
#La vida es mucho más compleja #
################################

# ¿Podemos meter más variables?

# Sí

#########################################
#  Modelo de regresión lineal múltiple  #
#########################################

# De esto:
# Y = β0 + β1 * X1

# Pasamos a esto:
# Y = β0 + β1 * X1 + β2 * X2

# Ya no buscamos la recta que minimice los residuos de las observaciones
# Ahora buscamos el plano!!
# Nos encontramos ante un modelo tridimensional!!!!

# https://setosa.io/ev/ordinary-least-squares-regression/

modelo_2 <- lm(formula = peso ~ altura + edad, data = data)
summary(modelo_2)

# Y = -46.97734 + 0.66840  * X1 + 0.12097 * X2

# ¿Cual sería el peso de una persona que mide 1,85 y tiene 54 años?

-46.97734 + 0.66840 * 185 + 0.12097 * 54    

#############################################
# Y así podríamos meter más y más variables #
#############################################

# Y = β0 + β1 * X1 + β2 * X2 + β3 * X3 + β4 * X4.....

# Hemos dicho que en un modelo de regresión lineal la variable dependiente Y, tiene que ser numérica continua

# ¿Qué tipo de variables podemos meter como variables independientes?
# Como variables X, podemos meter tanto variables numéricas como categóricas
# Lo único a tener en cuenta es que la interpretación de los coeficientes cambia

#############
# Ejemplo!! #
#############

modelo_3 <- lm(formula = peso ~ altura + edad + sexo, data = data)
summary(modelo_3)

modelo_4 <- lm(formula = peso ~ altura + edad_r + sexo, data = data)
summary(modelo_4)