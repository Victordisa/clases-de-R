setwd("C:/Users/steph/Google Drive/Documentos/EAE/bussiness_performance_analysis/clase_2")

library(tidyverse)
library(haven)

data <- read_sav("ESS9e02.sav")

# REPASO CON DATOS REALES!

# ¿Qué es un dataframe? - Estructura datos rectangular, con observaciones y variables
data

head(data)
tail(data)

# ¿Cuantas observaciones? ¿Cuantas variables?
nrow(data)
ncol(data)

colnames(data)

# ¿Cómo accedesmos a los datos almacenados en las variables que forman un dataframe?
data$agea
data$gndr
data$cntry
data$happy
data$trstplt


# Tipos de datos (numerico, texto, logico, factor)
class(data$agea)
class(data$happy)
class(data$trstplt)
class(data$gndr)
class(data$cntry)

# Vamos a pasar la variable edad, felicidad, confianza en los políticos, de tipo haven_labbeled a numerica
data$agea <- as.numeric(data$agea)
data$happy <- as.numeric(data$happy)
data$trstplt <- as.numeric(data$trstplt)

class(data$agea)
class(data$happy)
class(data$trstplt)

# Vamos a pasar la variable sexo y país de tipo haven_labbeled a factor
data$gndr <- as_factor(data$gndr)
data$cntry <- as_factor(data$cntry)

class(data$gndr)
class(data$cntry)

levels(data$gndr)
levels(data$cntry)


# Vamos a quedarnos solo con las variables que nos interesa
# ¿Cómo se hacía esto? Con la función select(). Podemos hacerlo sin pipes o con pipes

# Sin pipes
# data <- select(data, agea, gndr, cntry, happy, trstplt)

# Con pipes (recomendado)
data <- data %>% 
        select(agea, gndr, cntry, happy, trstplt)

# ¿Cual es la felicidad media de los europeos en una escala 0-10?
mean(data$happy)

# Vaya! ¿Qué ha pasado?
summary(data$happy)

# Tenemos NAs en esta variable. ¿Qué hacemos?
mean(data$happy, na.rm = T)

# ¿Quienes son más felices, los españoles o los alemanes?
# Para responder a esta pregunta podemos crear una base de datos con los españoles y otra con los alemanes y analizar por separado
# ¿Como hacemos eso? Con la función filter(). Podemos hacerlo sin pipes o con pipes

# Sin pipes
# spain <- filter(data, cntry == "Spain")
# germany <- filter(data, cntry == "Germany")

# Con pipes (recomendado)
spain <- data %>% 
         filter(cntry == "Spain")

germany <- data %>% 
  filter(cntry == "Germany")


# Ahora podemos ver la media de felicidad en los dos paises por separado (Cuidado con los NAs)
mean(data$happy, na.rm = T)
mean(spain$happy, na.rm = T)
mean(germany$happy, na.rm = T)

sd(data$happy, na.rm = T)
sd(spain$happy, na.rm = T)
sd(germany$happy, na.rm = T)


# Vamos a borrar estas dos bases de datos
rm(spain, germany)

#####################################################################################################################################
# PREGUNTA! - Quien confía más en los políticos? Los españoles, los alemanes o los Franceses
#####################################################################################################################################

#pista: recuerda que la variable de confianza en los políticos se llama trstplt


spain <- data %>% 
  filter(cntry == "Spain")

germany <- data %>% 
  filter(cntry == "Germany")

france <- data %>% 
  filter(cntry == "France")

mean(spain$trstplt, na.rm = T)
mean(germany$trstplt, na.rm = T)
mean(france$trstplt, na.rm = T)

rm(spain, france, germany)


##########################################################
# BREVE INCISO PARA PROFUNDIZAR MÁS EN LA FUNCIÓN FILTER # 
##########################################################

# Filtrar por un criterio (Igual que...)
data %>% 
  filter(cntry == "Spain")

# Tipos de operadores de comparación

#Distinto a...
data %>% 
  filter(cntry != "Spain")

#Mayor que...
data %>% 
  filter(agea > 35)

#Mayor o igual que...
data %>% 
  filter(agea >= 35)

#Menor que...
data %>% 
  filter(agea < 35)

#Menor o igual que...
data %>% 
  filter(agea <= 35)


# Filtrar por varios criterios

# & (y)
data %>% 
  filter(cntry == "Spain" & agea < 35 & gndr == "Female")

# | (o)
x <- data %>% 
  filter((cntry == "Spain" | cntry == "Germany") & agea < 35 & gndr == "Female")

# OJO! como filtramos NAs??

# Esto no funciona

# data %>% 
#   filter(agea == NA)
# 
# data %>% 
#   filter(agea != NA)

# Se haría así

#así selecionamos a los que tienen NAs en la columna de edad
data %>% 
  filter(is.na(agea))

#así quitamos a los que tienen NAs en la columna de edad
data %>% 
  filter(!is.na(agea))

#####################################################################################################################################
# CHALLENGE!

# Cread 3 data frames nuevos a partir de "data"
# el primero llamado "felices" con las personas que declaran tener una felicidad de 5 o más
# el segundo llamado "tristes" con las personas que declaran tener una felicidad inferior a 5
# el tercero llamado "missings" con las personas de las que no tenemos datos (NAs)


felices <- data %>% 
  filter(happy >= 5)

tristes <- data %>% 
  filter(happy < 5)

missings <- data %>% 
  filter(is.na(happy))




#####################################################################################################################################

rm(felices, tristes, missings)

#######################################################################################################
# VAMOS A APRENDER FUNCIONES NUEVAS - rename(), arrange(), group_by(), summarise()                    # 
#######################################################################################################

#Rename - Sirve para cambiar el nombre de las columnas

#Sin pipes
# data <- rename(data, 
#                edad = agea, 
#                sexo = gndr, 
#                pais = cntry, 
#                felicidad = happy, 
#                politicos = trstplt)

#Con pipes (recomendado)
data <- data %>% 
  rename(edad = agea, 
         sexo = gndr, 
         pais = cntry, 
         felicidad = happy, 
         politicos = trstplt)

#arrange - Sirve para ordenar columnas

#De forma ascendente
data <- data %>% 
  arrange(edad)

#De forma descendente
data <- data %>% 
  arrange(-edad)


################################
# PREPARAROS QUE VIENEN CURVAS # 
################################

# ¿Quienes son más felices, los jóvenes(15 a 35), los de mediana edad(36 a 54) o los mayores (mayores de 55)?

data$edad_r <- NA
data$edad_r[data$edad >= 15 & data$edad <= 35] <- 1
data$edad_r[data$edad >= 36 & data$edad <= 54] <- 2
data$edad_r[data$edad >= 55] <- 3

data$edad_r <- factor(data$edad_r,
                      levels = c(1,2,3),
                      labels = c("15-35", "36-54", "55+"))


# Group_by() Agrupa la base de datos a partir de una variable
data %>% 
  group_by(edad_r)


# Summarise() Colapsa la base de datos en una única fila
data %>% 
  summarise(mean(felicidad, na.rm = T))

# ¿Qué pasa si combinamos ambas funciones?
data %>% 
  group_by(edad_r) %>% 
  summarise(media = mean(felicidad, na.rm = T))

# Podemos añadir también la desviación típica
data %>% 
  group_by(edad_r) %>% 
  summarise(media = mean(felicidad, na.rm = T),
            DT = sd(felicidad, na.rm = T))

#podemos encadenar otras funciones de tidyverse
data %>% 
  group_by(edad_r) %>%
  filter(!is.na(edad)) %>% 
  summarise(mean(felicidad, na.rm = T),
            sd(felicidad, na.rm = T))

#####################################################################################################################################
# PREGUNTA! - ¿Cual es el país más feliz?
#####################################################################################################################################

#Pista: Antes hemos grupado por edad para sacar la felicidad por franjas, ¿Qué variable deberíamos agrupar ahora?

x <- data %>% 
  group_by(pais) %>% 
  summarise(media = mean(felicidad, na.rm = T)) %>% 
  arrange(-media)



#####################################################################################################################################
# PREGUNTA! - ¿Cual es el país donde los jóvenes(15-35) son más felices? 
#####################################################################################################################################

#Pista: ¿Qué pasa si en group_by() ponemos dos variables group_by(pais, edad_r)?

data %>% 
  group_by(pais, edad_r) %>% 
  summarise(media = mean(felicidad, na.rm = T)) %>% 
  filter(edad_r == "15-35") %>% 
  arrange(media)



#####################################################################################################################################
# ¿Por qué es recomendable usar pipes?
#####################################################################################################################################

#Eliminemos todo
rm(list = ls())


#Volvemos a cargar la base de datos
data <- read_sav("ESS9e02.sav")


#Queremos calcular la media de confianza en los políticos por sexo en España
data %>% 
  select(gndr, cntry, trstplt) %>%
  rename(sexo = gndr, pais = cntry, politicos= trstplt) %>% 
  filter(pais == "ES" & !is.na(politicos)) %>% 
  group_by(sexo) %>% 
  summarise(media = mean(politicos))


# ¿Qué hemos hecho en estas líneas de código?
# 1. seleccionamos las variables que nos interesan
# 2. Por comodidad les ponemos nombres que nos resulten intuitivos
# 3. Filtramos para quedarnos con los casos de España y además eliminamos las observaciones con NAs
# 4. Agrupamos por sexo
# 5. Calculamos la media para las categorías por las que hemos agrupado
