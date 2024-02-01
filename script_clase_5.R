# setwd("D:/google drive/Documentos/EAE/bussiness_performance_analysis/clase_5")
setwd("C:/Users/lenovo1/Google Drive/Documentos/EAE/bussiness_performance_analysis/clase_5")

# Vamos a instalar un nuevo paquete muy util para abrir bases de datos en excel
#install.packages("openxls")

# Cargamos nuestras librearías incluyendo este nuevo paquete
library(tidyverse)
library(haven)
library(openxlsx)

# Vamos a abrir 2 bases de datos
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

#######################################################################################################
#
# Estadística: Recolección, análisis e interpretación de los datos
# Se divide esencialmente en 2 ramas: Estadística descriptiva y estadística inferencial
#
#######################################################################################################

# Lo que hemos hecho hasta ahora es esencialmente estadística descriptiva

# A través de la estadística descriptiva respondíamos esencialmente a preguntas del siguiente estilo:

# ¿Cuál es la altura media?
mean(data$altura)
sd(data$altura)

summary(data$altura)

data %>% 
  ggplot() +
  geom_histogram(aes(x = altura))

data %>% 
  ggplot() +
  geom_boxplot(aes(x = altura))

# ¿Qué porcentajes de hombres y mujeres hay?

data %>%
  count(sexo) %>% 
  mutate(pct = n/sum(n)*100)

data %>%
  count(sexo) %>% 
  mutate(pct = n/sum(n)*100) %>% 
  ggplot() +
  geom_col(aes(x = sexo, y = pct))

# En definitica, con la estadística descriptiva lo que haciamos era transformar y resumir una gran cantidad de datos
# con el objetivo de tener un mejor entendimiento de ellos

# Ahora bien... podíamos también empezar a combinar variables para enriquecer los análisis
# Esto nos acercaría la estadística inferencial al extraer conclusiones que van más allá de la descripción de los datos

# Combinabamos una variable categórica y otra de tipo numérico (sexo y altura) podíamos hacer este análisis

data %>% 
  group_by(sexo) %>% 
  summarise(media = mean(altura))

data %>% 
  ggplot() +
  geom_boxplot(aes(x = altura, y = sexo))


# por otro lado si combinabamos dos variables de tipo numérico (altura y peso)
data %>% 
ggplot() +
  geom_point(aes(x = altura, y = peso), size = 2)

# Como podemos ver, a través de herramientas puramente desciptivas encontramos ciertos patrones como:
# - Diferencias entre grupos (altura entre sexos)
# - Relación entre variables

# pero...

#################################################
# SON REALES ESTAS DIFERENCIAS Y RELACIONES???? #
#################################################

# Al final, vamos a estar trabajando la mayor parte del tiempo solo con un fragmento de datos de toda la realidad
# Para contrastar esto existen distintas pruebas estadísticas.

# test de correlación
# t-test 
# chi2
# Regresiones


# Pero antes de nada tenemos que conocer lo que es un contraste de hipótesis o test de hipótesis

# Antes de ponernos a analizar datos, partimos siempre de algunas preguntas de investigación previas.

# Por ejemplo, ¿Existe relación entre la altura y el peso?

# De la pregunta de investigación derivarán una serie de hipótesis

# H0 - No existe relación entre la altura y el peso
# H1 - Sí existe relación entre la altura y el peso

# Una vez planteada nuestra pregunta de investigación sus posibles hipótesis procedemos a contrastarlas
# a través del test estadístico más apropiado.
# En este caso, al tratar de conocer la relación entre dos variables de tipo númérico, uilizamos un test de correlación

# Concretamente vamos a utilizar el test de correlación de Pearson
cor.test(data$peso, data$altura)

# Nuestro objetivo es tratar de demostrar H1 y eso lo hacemos descartando H0

####################################################################################################################################
# CORRELACIÓN NO ES CAUSALIDAD 
#
# https://www.tylervigen.com/spurious-correlations
#
# https://www.jotdown.es/2016/06/correlacion-no-implica-causalidad/
#
# Es importante recordar que correlación NO implica causalidad. La correlación entre dos variables v1 y v2 puede deberse a:
#
# Relación causal: V1 es la causa, V2 el efecto
# Relación causal: V2 es la causa, V1 el efect
# Azar
#
# La existencia de una Variable interviniente
#
# ojo con la paradoja de simpson: https://quantdare.com/paradoja-de-simpson/
#
####################################################################################################################################

# ¿Y si tenemos una variable numérica y otra categórica?

# T-test 

# ¿Hay diferencias en la altura media entre hombres y mujeres?

# H0 - No existen diferencias
# H1 - Sí existen diferencias

t.test(data$altura ~ data$sexo)


# ¿Y si tenemos dos variables de tipo categóricas?

data <- read_sav("datos_clase_5_ess.sav")

data$gndr <- as_factor(data$gndr)
data$polintr <- as_factor(data$polintr)

# Otro ejemplo: ¿Existe alguna relación entre el sexo y el interés por la política?

# H0: No hay asociación entre el sexo y la edad
# H1: Síhay asociación entre el sexo y la edad

# Para dar respuesta a este tipo de preguntas las tablas de contingencia se presentan como la herramienta más util

# Podemos sacar una tabla de contingencia con r base
table(data$gndr, data$polintr)
tabla <- table(data$gndr, data$polintr)

# Porcentajes de celda
prop.table(tabla)

# Porcentajes de fila
prop.table(tabla, 1)

# Porcentajes de columnas
prop.table(tabla, 2)


# Con tidyverse se haría así
data %>%
  group_by(gndr) %>% 
  count(polintr) %>% 
  mutate(pct = n/sum(n)*100) %>% 
  select(-n) %>% 
  pivot_wider(names_from = polintr, values_from = pct)

# En cualquier caso existen paquetes especializados que nos hacen la vida un poco más fácil

# install.packages("gmodels")
library(gmodels)

CrossTable(data$gndr, data$polintr)

# Como sabemos si existe alguna relación entre las dos vaqriables
# Para eso utilizamos el estadístico chi2

# Si queremos sacar la tabla con chi2 añadimos el argumento chisq

CrossTable(data$gndr, data$polintr, chisq=TRUE)

#Vamos a darle formato
CrossTable(data$gndr, data$polintr, chisq=TRUE, format=c("SPSS"))

#Quitemos cosas que no nos interesan
CrossTable(data$gndr, data$polintr, chisq=TRUE, format=c("SPSS"), prop.chisq = F)

# De donde sale el chi2?
CrossTable(data$gndr, data$polintr, chisq=TRUE, format=c("SPSS"), prop.chisq = F, asresid = T)


# https://prnt.sc/x4zpoj


#############################################################################################################################################

# y = B0 + B1*X1

#############################################################################################################################################