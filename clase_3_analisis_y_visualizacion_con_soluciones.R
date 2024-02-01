setwd("C:/Users/steph/Google Drive/Documentos/EAE/bussiness_performance_analysis/clase_3")

library(tidyverse)
library(haven)

# Hoy vamos a trabajar con la base de datos de gapminder
data <- read_csv("data_clase_3.csv")

# ¿Qué encontramos en esta base de datos?
data


# BREVE ACLARACIÓN - 2 tipos de data frames ####################################################################################################

as.data.frame(data)
as.tibble(data)

# Esta base datos al ser importada con la función read_csv() viene como un tibble autonáticamente
data

# ¿Y si queremos ver más ?

data %>%
  print(n = 20)

################################################################################################################################################


# Recordemos!
# Sabemos seleccionar columnas de una base de datos con la función select()
# Sabemos como renombrarlas con la función rename()
# Sabemos como filtrar bases de datos con la función filter()
# Sabemos ordenar las observaciones de forma ascendente o descendente con arrange()
# Sabemos como agrupar y colapsar bases de datos con group_by y summarise()

# Todavía nos falta por aprender dos funciones básicas de tidyverse para ser unos maestros de la data

# mutate() - Sirve para generar nuevas columnas en un dataset
# Vamos a crear en nuestra base de datos una nueva columna con el PIB (gdp)

data <- data %>% 
  mutate(gdp = gdpPercap*pop)


# Con lo que sabíamos hasta ahora podríamos haberlo también así

data$gdp <- data$gdpPercap * data$pop

# count() - Sirve para contar el número de observaciones que encontramos en una variable

data %>% 
  filter(year == 2007) %>% 
  count(continent)


# Podemos combinar count() y mutate() para obtener las frencuancias relativas

data %>% 
  filter(year == 2007) %>% 
  count(continent) %>% 
  mutate(pct = n/sum(n)*100)

# Podemos encadenar la función select() para quitar la columna n y quedarnos solo con los porcentajes

 data %>% 
  filter(year == 2007) %>% 
  count(continent) %>% 
  mutate(pct = n/sum(n)*100) %>% 
  select(-n)


# Todo claro hasta ahora?

# Seguros?

# Demostradmelo!! #########################################################################################################################################

# Cread una nueva variable llamada ingresos, la cual tiene que tener 3 categorías
# Una primera categoría con los paises con un PIB per capita de menos de 3100 a los que les asignaremos el valor 1
# Una segunda categoría con los paises con un PIB per capita entre 3100 a 18600 a los que les asignaremos el valor 2
# Una tercera categoría con los paises con un PIB per capita de más de 18600 a los que les asignaremos el valor 3

data$ingresos <- NA
data$ingresos[data$gdpPercap < 3100] <- 1
data$ingresos[data$gdpPercap >= 3100 & data$gdpPercap <= 18600] <- 2
data$ingresos[data$gdpPercap > 18600] <- 3

# Ahora factorizad esa variable y poned las siguientes etiquetas
# 1 = "Bajos"
# 2 = "Medios"
# 3 = "Altos"

data$ingresos <- factor(data$ingresos,
                        levels = c(1,2,3),
                        labels = c("Bajos", "Medios", "Altos"))

data %>% 
  count(ingresos)


# ¿Qué porcentaje de paises del mundo tienen ingresos altos en el año 2007?

data %>% 
  filter(year == 2007) %>% 
  count(ingresos) %>%
  mutate(pct = n/sum(n)*100) %>% 
  select(-n)

# ¿Cómo ha evolucionado el porcentaje de paises de ingresos bajo a lo largo de los años?

data %>% 
  group_by(year) %>% 
  count(ingresos) %>% 
  mutate(pct = n/sum(n)*100) %>% 
  filter(ingresos == "Bajos") %>% 
  select(-ingresos, -n)


# Si habéis conseguido hacer estos ejercicios, estáis preparados para visualizar datos!!
# Para ello vamos a usar ggplot2, un paquete integrado dentro del conjunto de paquetes que conforman tidyverse

# primero vamos a quedarnos con solo las observaciones de España
spain <- data %>% 
  filter(country == "Spain")


# ¿Cuales son los fundamentos de ggplot?
spain %>% 
  ggplot()


# El mapeo de valores (aesthetic)
spain %>%
  ggplot(aes(x = year, y = pop))


# Capas de geometrías (geoms)
spain %>%
  ggplot(aes(x = year, y = pop)) +
  geom_point()


# Dentro de las geometrías hay numerosos argumentos como el tamaño de las bolas
spain %>%
  ggplot(aes(x = year, y = pop)) +
  geom_point(size = 5)

# el color
spain %>%
  ggplot(aes(x = year, y = pop)) +
  geom_point(size = 5, color = "red")

# la transparencia
spain %>%
  ggplot(aes(x = year, y = pop)) +
  geom_point(size = 5, color = "red", alpha = 0.5) 


# ¿Y si queremos unir los puntos?

# Podemos ir añadiendo distintas capas
spain %>%
  ggplot(aes(x = year, y = pop)) +
  geom_point(size = 5, color = "red", alpha = 0.5) +
  geom_line()

# También con sus respectivos argumentos
spain %>%
  ggplot(aes(x = year, y = pop)) +
  geom_point(size = 5, color = "red", alpha = 0.5) +
  geom_line(size = 1.5)

spain %>%
  ggplot(aes(x = year, y = pop)) +
  geom_point(size = 5, color = "red", alpha = 0.5) +
  geom_line(size = 1.5, color = "red", alpha = 0.5)

# Y estos serían los fundamentos


# A continuación más ejemplos!

data %>% 
  filter(year == 2007) %>% 
  count(ingresos) %>% 
  mutate(pct = n/sum(n)*100) %>% 
  ggplot(aes(x = ingresos, y = pct, fill = ingresos)) + 
  geom_col()



data %>% 
  group_by(year) %>% 
  count(ingresos) %>% 
  mutate(pct = n/sum(n)*100) %>% 
  ggplot(aes(x = ingresos, y = pct, fill = ingresos)) +
  geom_col() +
  facet_wrap(~year)

data %>% 
  ggplot(aes(x = lifeExp, y = gdpPercap)) +
  geom_point(aes(color = continent)) +
  geom_smooth(color = "black")











