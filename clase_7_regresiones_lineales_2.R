setwd("C:/Users/steph/Google Drive/Documentos/EAE/bussiness_performance_analysis/clase_7")

library(tidyverse)
library(haven)

data <- read_sav("clase_7_datos_cis.sav")

# Recordemos!
# A partir de un conjunto de mínimo 2 variables, podíamos ajustar un modelo.
# Vimos el modelo de regresión lineal, el cual era útil para predecir y explicar

# Su ecuación básica era: 
# Y = β0 + β1 * X1

########################################################################################################
# ¿QUÉ DATOS ESTAMOS USANDO HOY?
########################################################################################################

# Encuesta preelectoral 10N 2019 - CIS
# http://www.cis.es/cis/opencm/ES/1_encuestas/estudios/ver.jsp?estudio=14473&cuestionario=17452&muestra=24446

data

########################################################################################################
#
# Viajemos al pasado!
# 
# 1 de Noviembre de 2019
# 
# No encontramos en plena campaña electoral de cara a las elecciones del 10N
#
# En Génova 13, miran con preocupación las encuestas ante el inminente crecimiento de Vox
# 
# Pablo Casado, os llama buscando ayuda...
#
# ¿Cuales son las variables que aumentan la probabilidad de voto al PP?
# ¿Cuales son las variables que aumentan la probabilidad de voto a Vox?
#
########################################################################################################

# Variable dependiente Y
data$prob_pp <- as.numeric(data$P1202)
data$prob_pp[data$prob_pp > 10] <- NA

data$prob_vox <- as.numeric(data$P1206)
data$prob_vox[data$prob_vox > 10] <- NA


#Variables independientes X
data$sexo <- as_factor(data$P23)

data$edad <- as.numeric(data$P24)
data$edad[data$edad > 98] <- NA


data$rural <- NA 
data$rural[data$TAMUNI > 2] <- 0
data$rural[data$TAMUNI < 3] <- 1  

data$rural <- factor(data$rural,
                    levels = c(0,1),
                    labels = c("Urbano", "Rural"))


data$ideol <- as.numeric(data$P18)
data$ideol[data$ideol > 10] <- NA

data$inmigr <- 0
data$inmigr[data$P601 == 18] <- 1

data$inmigr <- factor(data$inmigr,
                      levels = c(0,1),
                      labels = c("No", "Si"))

data$paro <- 0
data$paro[data$P601 == 1] <- 1

data$paro <- factor(data$paro,
                      levels = c(0,1),
                      labels = c("No", "Si"))

data$corrupcion <- 0
data$corrupcion[data$P601 == 11] <- 1

data$corrupcion <- factor(data$corrupcion,
                    levels = c(0,1),
                    labels = c("No", "Si"))

data$economia <- 0
data$economia[data$P601 == 8] <- 1

data$economia <- factor(data$economia,
                        levels = c(0,1),
                        labels = c("No", "Si"))


data$labsitu <- NA
data$labsitu[data$P26 == 1] <- 1
data$labsitu[data$P26 %in% c(2,3)] <- 2
data$labsitu[data$P26 %in% c(4,5)] <- 3
data$labsitu[data$P26 %in% c(6,7,8)] <- 4

data$labsitu <- factor(data$labsitu,
                     levels = c(1,2,3,4),
                     labels = c("Trabaja", "Pensionista", "Parado", "Otra situación"))



# Sacamos nuestros modelos
modelo_pp <- lm(formula = prob_pp ~ sexo + edad + rural + ideol + inmigr + paro + corrupcion + economia + labsitu, data = data)
summary(modelo_pp)

modelo_vox <- lm(formula = prob_vox ~ sexo + edad + rural + ideol + inmigr + paro + corrupcion + economia + labsitu, data = data)
summary(modelo_vox)


# Podemos visualizarlo a través de estas funciones

# install.packages("jtools")
# install.packages("ggstance")

library(jtools)
library(ggstance)

plot_summs(modelo_pp)

# También conjuntamente

plot_summs(modelo_pp, modelo_vox)

# Sacarlo en formato científico

# install.packages("stargazer")
library(stargazer)

stargazer(modelo_pp, modelo_vox,
          type = "text")


# ¿Cuáles son las variables que más pesan?

library(lm.beta)

beta_pp <- lm.beta(modelo_pp)
summary(beta_pp)

beta_vox <- lm.beta(modelo_vox)
summary(beta_vox)

# PREGUNTA!!! ############################################################################################################################################

# ¿A que partido tiene más probabilidad de votar la siguiente persona, al PP o a Vox?
#
# Nombre: Encarnación
# Edad: 51 años
# Municipio: Berzosa del Lozoya (Rural)
# Ideología: 5
# No le preocupa la inmigración
# Le preocupa el paro
# Le preocupa la corrupción
# No le preocupa la economía
# Trabaja


# Pista: Usad la función predict

sexo <- c("Mujer")
edad <- c(51)
rural <- c("Rural")
ideol <- c(5)
inmigr <- c("No")
paro <- c("Si")
corrupcion <- c("Si")
economia <- c("No")
labsitu <- c("Trabaja")

encarnacion <- tibble(sexo, edad, rural, ideol, 
                      inmigr, paro, corrupcion, 
                      economia, labsitu)


predict(modelo_pp, encarnacion)
predict(modelo_vox, encarnacion)

##########################################################################################################################################################


# No todo es tan sencillo...
# Una regresión lineal tiene que intentar cumplir los isiguientes supuestos:

# La relación entre las variables x e y es lineal (una recta).
# La varianza de los errores es constante (heterocesdasticidad).
# Los errores tienen distribucion normal
# Ausencia de multicolinealidad perfecta
# La media de los residuos es igual a cero



# Linealidad, heterocedasticidad y distribución de los residuos

par(mfrow=c(2,2))
plot(modelo_pp, pch=2 ,bg='red', cex=2) 


# El gráfico superior-izquierda: 
# Se pueden utilizar
# los residuos para ver si 
# el modelo de regresión lineal es adecuado. 
# Si los residuos aparecen igualmente distribuidos 
# alrededor de una línea horizontal y sin patrones, es un buen indicio de que 
# la relación entre las variables es lineal.

# El gráfico superior-derecha muestra si 
# los residuos se distribuyen normalmente. 
# Es bueno si los residuos están bien alineados en la línea recta discontinua. 
# En este caso, el resultado es claro.

# El gráfico inferior-izquierda se llama diagrama 
# de Spread-Location. Este tipo de gráfico muestra 
# si los residuos se reparten equitativamente a 
# lo largo de los rangos de los predictores. 
# Así es como puede verificar el supuesto de varianza igual 
# (homoscedasticidad). 
# Es bueno si observamos una línea horizontal 
# con puntos de propagación iguales. 

# También podemos hacer un test de heterocedasticidad:

#install.packages("lmtest")

library(lmtest)

het.lm <- bptest(modelo_pp)
het.lm

# La hipótesis nula en este test es que la varianza 
# de los residuos es constante. 
# La evidencia  permite rechazar la hipótesis nula, 
# por lo cual no afirmamos que la distribución sea homocedástica.


# El gráfico inferior-derecha nos ayuda a detectar casos influyentes. 
# Leverage es una medidad de cuánta influencia ejerce cada punto la recta de regresión. 
# No todos los valores atípicos son influyentes en el análisis de regresión lineal. 
# Al contrario, se puede dar el caso de que haya valores extremos que no son determinantes a la hora de estima la recta de gresión, 
# por lo que los resultados no serían muy diferentes si los excluímos del análisis. Sin embargo, 
# si los casos están fuera de la distancia de Cook (lo que significa que tienen puntuaciones de distancia de Cook altas), 
# los resultados de la regresión se alterarán si excluimos esos casos. Para un buen modelo de regresión, 
# la línea suavizada roja debe permanecer cerca de la línea media y ningún punto debe tener una distancia de Cook grande. 


# Comprobar multicolinealidad

# VIF (Variation Inflation Factor)

# install.packages("rms")

library(rms)

reg.lineal.vif <- vif(modelo_pp)
reg.lineal.vif


# Comprobar Media de los residuos=0
mean(modelo_pp$residuals)


# PREGUNTA!!! ############################################################################################################################################

# ¿Qué probabilidad tiene Encarna de votar al PSOE y a Unidas Podemos?

# Pista:
data$prob_psoe <- as.numeric(data$P1201)
data$prob_psoe[data$prob_psoe > 10] <- NA

data$prob_podemos <- as.numeric(data$P1204)
data$prob_podemos[data$prob_podemos > 10] <- NA






##########################################################################################################################################################

# INTERACCIONES!!

