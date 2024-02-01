setwd("C:/Users/lenovo1/Google Drive/Documentos/EAE/bussiness_performance_analysis/clase_4/")

library(tidyverse)
library(haven)

data <- read_csv("data_clase_4.csv")


# Antes de empezar vamos a crear esta variable de ingresos que utilizamos la clase pasada

data$ingresos <- NA
data$ingresos[data$gdpPercap < 3100] <- 1
data$ingresos[data$gdpPercap >= 3100 & data$gdpPercap <= 18600] <- 2
data$ingresos[data$gdpPercap > 18600] <- 3

data$ingresos <- factor(data$ingresos,
                        levels = c(1,2,3),
                        labels = c("Bajos", "Medios", "Altos"))



# Recordemos los fundamentos de ggplot2

# ¿Qué ingredientes necesitamos?

# 1 - Datos: La mayoría de veces antes de visualizar los datos hay que transformarlos o limpiarlos 

#Vamos a quedarnos solo con las observaciones de 2007

data %>% 
  filter(country == "Spain")


# 2 - MAPEAR DE DATOS: Definir las variables a visualizar

data %>% 
  filter(country == "Spain") %>% 
  ggplot(aes(x = year, y = lifeExp))


# 3 - CAPA DE GEOMETRÍA: Definir el tipo de visualización que queremos utilizar para representar las variables mapeadas

data %>% 
  filter(country == "Spain") %>% 
  ggplot(aes(x = year, y = lifeExp)) +
  geom_point()

# En resumen: 
# GRÁFICO = DATOS + MAPEO DE DATOS + CAPA DE GEOMETRÍA

# No nos conformemos con esto...

# Ampliemos nuestra fórmula: 
# GRÁFICO ÉPICO = DATOS + MAPEO DE DATOS + CAPA DE GEOMETRÍA + CAPA DE GEOMETRÍA

# Vamos a meterle además de la geometría de los puntos, una capa de geometría de líneas.

data %>% 
  filter(country == "Spain") %>% 
  ggplot(aes(x = year, y = lifeExp)) +
  geom_point() +
  geom_line()


###################################################################################################################################
# VARIOS APUNTES ANTES DE SEGUIR
#
# 1 - Ojo que las capas en ggplot2 se añaden con el símbolo + y no con %>% 
#
# 2 - Estos dos códigos hacen exactamente lo mismo

# Versión 1
data %>% 
  filter(country == "Spain") %>% 
  ggplot(aes(x = year, y = lifeExp)) +
  geom_point() +
  geom_line()

# Versión 2
data %>% 
  filter(country == "Spain") %>% 
  ggplot() +
  geom_point(aes(x = year, y = lifeExp)) +
  geom_line(aes(x = year, y = lifeExp))

# ¿A que se debe esto?
# Todo lo que metamos en la función inicial de ggplot lo heredan las capas de geometrías que vengan después

# VAMOS A TRABAJAR CON LA VERSIÓN 2 PARA TENER UN MAYOR CONTROL
#
###################################################################################################################################


# Continuemos con nuestro código

data %>% 
  filter(country == "Spain") %>% 
  ggplot() +
  geom_point(aes(x = year, y = lifeExp)) +
  geom_line(aes(x = year, y = lifeExp))

# Sigamos ampliando nuestra fórmula: 
# GRÁFICO SÚPER ÉPICO = DATOS + MAPEO DE DATOS + CAPA DE GEOMETRÍA + CAPA DE GEOMETRÍA + ARGUMENTOS DE PERSONALIZACIÓN

data %>% 
  filter(country == "Spain") %>% 
  ggplot() +
  geom_point(aes(x = year, y = lifeExp), size = 2, color = "#347383") +
  geom_line(aes(x = year, y = lifeExp), size = 1, color = "#347383")



# GRÁFICO HIPER ÉPICO = DATOS + MAPEO DE DATOS + CAPAS DE GEOMETRÍAS + ARGUMENTOS DE PERSONALIZACIÓN + CAPAS DE PERSONALIZACIÓN

# Con la capa labs() podemos introducir titulos y personalizar el texto de los ejes

data %>% 
  filter(country == "Spain") %>% 
  ggplot() +
  geom_point(aes(x = year, y = lifeExp), size = 2, color = "#347383") +
  geom_line(aes(x = year, y = lifeExp), size = 1, color = "#347383") +
  labs(title = "Evolución de la esperanza de vida en España", 
       subtitle = "La esperanza de vida se situa por encima de los 80 años",
       x = "",
       y = "Esperanza de vida",
       caption = "Fuente: gapminder")


# Podemos modificar también el tema del gráfico con las capas theme_
data %>% 
  filter(country == "Spain") %>% 
  ggplot() +
  geom_point(aes(x = year, y = lifeExp), size = 2, color = "#347383") +
  geom_line(aes(x = year, y = lifeExp), size = 1, color = "#347383") +
  labs(title = "Evolución de la esperanza de vida en España", 
       subtitle = "La esperanza de vida se situa por encima de los 80 años",
       x = "",
       y = "Esperanza de vida",
       caption = "Fuente: gapminder") +
  theme_minimal()


# ¿Como guardamos ahora nuestro gráfico tan cuqui?

# Podemos hacerlo manualmente o con la función ggsave()
# ggsave() guardará en nuestro directorio de trabajo el gráfico que esté siendo visualizado en este momento

#Podemos guardarlo en .png
ggsave("mi_primerito_grafico.png", width = 7)

#Podemos también en .pdf
ggsave("mi_primerito_grafico.pdf", width = 7)


# Hasta aquí el repaso de lo básico! ############################################################################################

# Llegados a este punto sigamos aventurandonos en las profundidades de la visualización de datos con ggplot
# Pasemos al siguiente nivel!!!


# Las infinitas posibilidades del mapeo ################################################################################ 

# Hemos mapeado hasta ahora por una posición x y una posición y, pero podemos mapear por muchas más características

# Imaginaros que queremos meter en este mismo gráfico también los datos de Alemania

# ¿Qué pasa si hacemos esto?

data %>% 
  filter(country == "Spain" | country == "Germany") %>% 
  ggplot() +
  geom_point(aes(x = year, y = lifeExp), size = 2) +
  geom_line(aes(x = year, y = lifeExp), size = 1)

# Como vemos se vuelve loco...

# Código correcto sería el siguiente
data %>% 
  filter(country == "Spain" | country == "Germany") %>% 
  ggplot() +
  geom_point(aes(x = year, y = lifeExp), size = 2) +
  geom_line(aes(x = year, y = lifeExp, group = country), size = 1)

# Y si queremos poner colores?

data %>% 
  filter(country == "Spain" | country == "Germany") %>% 
  ggplot() +
  geom_point(aes(x = year, y = lifeExp, color = country), size = 2) +
  geom_line(aes(x = year, y = lifeExp, color = country, group = country), size = 1)


# También podemos poner los datos por separados utilizando la capa facet_wrap()

data %>% 
  filter(country == "Spain" | country == "Germany") %>% 
  ggplot() +
  geom_point(aes(x = year, y = lifeExp, color = country), size = 2) +
  geom_line(aes(x = year, y = lifeExp, color = country, group = country), size = 1) +
  facet_wrap(~country)
  

# Aquí ya sobraría el argumento group en el aes de geom_line

data %>% 
  filter(country == "Spain" | country == "Germany") %>% 
  ggplot() +
  geom_point(aes(x = year, y = lifeExp, color = country), size = 2) +
  geom_line(aes(x = year, y = lifeExp, color = country), size = 1) +
  facet_wrap(~country)


# Para eliminar información duplicada podemos quitar también la leyenda con la capa theme

data %>% 
  filter(country == "Spain" | country == "Germany") %>% 
  ggplot() +
  geom_point(aes(x = year, y = lifeExp, color = country), size = 2) +
  geom_line(aes(x = year, y = lifeExp, color = country), size = 1) +
  facet_wrap(~country) +
  theme(legend.position = "none")


# Podemos mostrar más paises si modificamos el filter()

data %>% 
  filter(continent == "Europe") %>% 
  ggplot() +
  geom_point(aes(x = year, y = lifeExp, color = country), size = 2) +
  geom_line(aes(x = year, y = lifeExp, color = country), size = 1) +
  facet_wrap(~country) +
  theme(legend.position = "none")

###############################################################################################################################################


# Visualización de distribuciones de variables categóricas (factores)

#geom_col
data %>%
  filter(year == 2007) %>% 
  count(ingresos) %>% 
  mutate(pct = n/sum(n)*100) %>% 
  ggplot() +
  geom_col(aes(x = ingresos, y = pct))


#Vamos a darle algo de color no??
data %>%
  filter(year == 2007) %>% 
  count(ingresos) %>% 
  mutate(pct = n/sum(n)*100) %>% 
  ggplot() +
  geom_col(aes(x = ingresos, y = pct, fill = ingresos))

# Podemos personalizar los colores manualmente con la capa scale_fill_manual()

data %>%
  filter(year == 2007) %>% 
  count(ingresos) %>% 
  mutate(pct = n/sum(n)*100) %>% 
  ggplot() +
  geom_col(aes(x = ingresos, y = pct, fill = ingresos)) +
  scale_fill_manual(values = c("#C4E0E8", "#50A4B9", "#11262C"))


# Challenge!!! ################################################################################################
# ¿Sabrías sacar este mismo gráfico para cada uno de los continentes utilizando la capa facet_wrap()?

#Pista: Vas a tener que utilizar la función group_by()








##############################################################################################################

# Podemos jugar también con la capas de coordenadas como coord_flip() o coord_polar()

#coord_flip()
data %>%
  filter(year == 2007) %>% 
  count(ingresos) %>% 
  mutate(pct = n/sum(n)*100) %>% 
  ggplot() +
  geom_col(aes(x = ingresos, y = pct, fill = ingresos)) +
  scale_fill_manual(values = c("#C4E0E8", "#50A4B9", "#11262C")) +
  coord_flip()

#coord_polar()
data %>%
  filter(year == 2007) %>% 
  count(ingresos) %>% 
  mutate(pct = n/sum(n)*100) %>% 
  ggplot() +
  geom_col(aes(x = ingresos, y = pct, fill = ingresos)) +
  scale_fill_manual(values = c("#C4E0E8", "#50A4B9", "#11262C")) +
  coord_polar()


# Como alternativa a geom_col() tenemos la capa de geometría geom_bar()

#geom_bar
data %>%
  filter(year == 2007) %>%
  ggplot() +
  geom_bar(aes(x = ingresos, fill = ingresos)) +
  scale_fill_manual(values = c("#C4E0E8", "#50A4B9", "#11262C"))

# Es más facil, pero tenemos menos control!



# Visualización de distribuciones de variables numéricas continuas

# geom_hist
data %>%
  filter(year == 2007) %>% 
  ggplot() +
  geom_histogram(aes(x = lifeExp))


# Podemos editar el rango de las barras con el argumento binwidth
data %>%
  filter(year == 2007) %>% 
  ggplot() +
  geom_histogram(aes(x = lifeExp), binwidth = 5)

# geom_dotplot
data %>%
  filter(year == 2007) %>% 
  ggplot() +
  geom_dotplot(aes(x = lifeExp))

# Le podemos poner colorines
data %>%
  filter(year == 2007) %>% 
  ggplot() +
  geom_dotplot(aes(x = lifeExp, fill = continent))


# Dos variables numéricas continuas




# Dos variables categóricas (factores)
data %>% 
  filter(year == 2007) %>% 
  ggplot() +
  geom_count(aes(x = ingresos, y = continent))


# Una variable continua y una variable categórica

data %>% 
  filter(year == 2007) %>% 
  ggplot() +
  geom_boxplot(aes(x = continent, y = lifeExp))








