setwd("C:/Users/steph/Google Drive/Documentos/EAE/bussiness_performance_analysis/clase_8")

library(tidyverse)
library(haven)

data <- read_sav("clase_8_datos_cis.sav")

# La regresión logística
# El análisis de regresión logística es una técnica para el análisis de variables dependientes categóricas, con dos categorías (dicotómicas). 
# Sirve para modelar la probabilidad de ocurrencia de un evento como función de otros factores, y responder preguntas como:
#   
#   ¿Qué factores explican la victoria/derrota de un candidato en unas elecciones?
#   ¿Qué variables determinan que una persona fume?
#   ¿Cómo podemos explicar el abandono escolar?
#   ¿Qué factores afectan a la probabilidad de tener un/otro hijo?

# La regresión lógística seríe un tipo de sistemas de clasificación supervisado 

#######################################################
# ¿Por qué no utilizar un modelo de regresión lineal? # 
# https://bit.ly/2Mvu2h1                              #                      
#######################################################

# Regresión lineal:    Y = β0 + β1 * X1

# Transformación de la función lineal a logística

# Regresión logística: ln(p/1−p) = β0 + β1 * X1

# Ejemplo práctico!

################################################################
# ¿Qué factores incrementan/disminuyen el riesgo de desempleo? #                                                  #
################################################################

# Nuestra variable dependiente Y:

data$desempleado <- NA
data$desempleado[data$P26 %in% c(1)] <- 0 
data$desempleado[data$P26 %in% c(4,5)] <- 1 

data$desempleado <- factor(data$desempleado,
                           levels = c(0,1),
                           labels = c("Trabaja", "Desempleado"))

summary(data$desempleado)

# Variables independientes X: 

data$sexo <- as_factor(data$P23)

data$edad <- as.numeric(data$P24)
data$edad[data$edad > 98] <- NA

data$rural <- NA 
data$rural[data$TAMUNI > 2] <- 0
data$rural[data$TAMUNI < 3] <- 1  

data$rural <- factor(data$rural,
                     levels = c(0,1),
                     labels = c("Urbano", "Rural"))

data$estu_univ <- 0
data$estu_univ[data$ESTUDIOS %in% c(6)] <- 1

data$estu_univ <- factor(data$estu_univ,
                     levels = c(0,1),
                     labels = c("No universitarios", "Universitarios"))

summary(data$estu_univ)

data$clase_alta <- 0
data$clase_alta[data$P28 %in% c(1,2)] <- 1

data$clase_alta <- factor(data$clase_alta,
                         levels = c(0,1),
                         labels = c("Otros", "Clase alta"))


summary(data$clase_alta)

# Me quedo solo con las variables que vamos a utilizar para modelizar
data <- data %>% 
  select(desempleado, sexo, edad, rural, estu_univ, clase_alta)

# Elimino cualquier observación que tenga algún NA
data <- na.omit(data)

# Nuestras variables
summary(data)

# SAQUEMOS NUESTRA REGRESIÓN LOGÍSTICA!!

modelo_desempleo <- glm(desempleado ~ sexo + edad + rural + estu_univ + clase_alta, data = data, family = "binomial")
summary(modelo_desempleo)

#############################
# ¿Cómo se interpreta esto? #
#############################

# Debido a que la interpretación de esto es demasiado complicado podemos 
# convertir los coeficientes en Odds ratio exponenciando
  
exp(coef(modelo_desempleo))

# Como sabemos si son esadísticamente significativos??
# Podemos calcular los intervalos de confianza
  
exp(cbind(OR = coef(modelo_desempleo), confint(modelo_desempleo)))

##################################################################
# EN CUALQUIER CASO, LO MEJOR ES CALCULAR LOS EFECTOS MARGINALES #
##################################################################

#install.packages("margins")

library(margins)

margins_desempleo <- margins(modelo_desempleo)
summary(margins_desempleo)

# Podemos visualizarlo
plot(margins_desempleo, main="Modelo desempleo", pch=15, las=2, 
     labels = c("Clase alta", "edad", "Estudios", "Rural", "Mujer"))

# El argumento at de margins es muy interesante porque nos permite calcular los efectos marginales 
# para valores concretos de las variables independientes. 
# Para ello, tan sólo tenemos que especificar el nombre de las variables y los valores que nos interesan

summary(margins(modelo_desempleo, at = list(edad = c(20, 40, 50, 60, 70)), variables = "sexo"))

# Podemos usar también stargazer para sacar la regresión en formato científico
library(stargazer)

stargazer(modelo_desempleo, type = "text")

# Para sacarlo con ods ratio
stargazer(modelo_desempleo, type = "text", apply.coef = exp, apply.se   = exp)

# Diagnóstico

# ¿Hay multicolinealidad?

library(rms)
logit.vif<- vif(modelo_desempleo)
logit.vif

# ¿Hay heterocedasticidad?

#install.packages("lmtest")
library(lmtest)

logit.het<-bptest(modelo_desempleo)
logit.het

# La hipótesis nula en este test es que la varianza de los residuos es constante. La evidencia permite rechazar la hipótesis nula, 
# confirmando que se cumple el supuesto de heterocedasticidad.

######################
# Validación cruzada #
######################

# A continuación, vamos examinar cómo de bueno/malo es nuestro modelo a la hora de clasificar nuevos datos. Para ello, 
# continuamos con el ejemplo anterior, en el que estimábamos la probabilidad de que un individiuo esté en paro

# Primero vamos a crear dos bases de datos, uno con los datos para entrenar y otro para testear

set.seed(123)
index <- 1:nrow(data)
porc_test <- 0.30
testindex <- sample(index, trunc(length(index)*porc_test))

train.data <- data[-testindex,]
test.data <- data[testindex,]

# A continuación calculamos la clase real:
clase_real <- test.data$desempleado

# Entrenamos el modelo:
modelo_entrenado <- glm(desempleado ~ sexo + edad + rural + estu_univ + clase_alta, data = train.data, family = "binomial")

# Hacemos las predicciones para los datos de testeo
predicciones <- predict(modelo_entrenado, test.data, type="response")
head(predicciones)

# Para comprobar si clasifica bien calculamos la curva ROC
# install.packages("ROCR")
library(ROCR)

# Curva ROC
pred <-  prediction(predicciones, clase_real) #crea un objeto "predicción"
perf <- performance(pred, measure = "tpr", x.measure = "fpr") 

par(mfrow = c(1,1))
plot(perf, lty=1, main = "Logit ROC Curve")

# Matriz de confusión
# install.packages("caret")
library(caret)

p_class<- ifelse(predicciones > 0.30, 1, 0)
table(p_class)

table(clase_real)


summary(predicciones)

p_class <- factor(p_class, levels=c(0,1), labels=c("Trabaja", "Desempleado"))
table(p_class)

# install.packages("e1071")
library(e1071)

confusionMatrix(p_class, clase_real)

StephanZhao





prueba <- cbind(test.data, predicciones)
