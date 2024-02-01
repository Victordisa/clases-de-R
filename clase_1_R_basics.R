# Clase 1 - BIENVENIDOS A R

# Si acabas de abrir este script recuerda reabirlo con el encoding UTF-8
# Para ello haz click en "file" y a "Reopen with encoding"
# Si lo has hecho correctamente los siguientes caracteres aparecerán sin problemas: (ñ á é í ó ú ¿ ç) 
# Como te habrás fijado, con # podemos introducir comentarios en el script


# OBJETIVOS DE LA CLASE DE HOY
# > Instalar R y R Studio 
# > Conocer la interfaz de R Studio
# > Aprender a realizar operaciones básicas
# > Crear objetos
# > Conocer las principales clases de datos (numericos, character, factor, logic, NA)
# > Conocer los principales tipos estructuras de datos (vectores, listas, matrices, arrays y dataframes)
# > Aprender a trabajar con vectores
# > Algunas funciones básicas
# > Trabajar con Dataframes

# Nuestras primeras operaciones con R
1+1
10-5
2*3
10/2
2^2

# Estructuras de datos (Son los objetos que almacenan los datos para ser trabajados o analizados)

# VALORES ÚNICOS 
# Estos valores no están almacenados en ningún lado. Para ello tenemos que crear objetos que guarden esta información
# Para crear un objeto ponemos un nombre de identificación, utilizamos el operador "<-" e introducimos la información que queremos asignar al objetco
gasto_ropa <- 30
gasto_transporte <- 20 

# Una vez almacenado el dato en un objeto, podemos acceder a él escribiendo el nombre que le hemos puesto 
gasto_ropa
gasto_transporte

# Podemos hacer también operaciones aritméticas con los objetos creados
gasto_ropa + gasto_transporte

# También almacenar todo en un nuevo objeto
gasto_total <- gasto_ropa + gasto_transporte
gasto_total

# Los datos que puede trabajar puden ser de distinto tipo

# Tipo numérico (numeric)
edad <- 24 

# Tipo texto (Character) - Siempre están entre comillas
nombre <- "Stephan"

# Tipo lógicos - Pueden adoptar valores TRUE o FALSE
tiene_hijos <- FALSE

# Para comprobar que tipo de dato contiene un objeto podemos utilizar la función class()
class(edad)
class(nombre)
class(tiene_hijos)

# Existen más tipos de datos como los factores que veremos más adelante

#Podemos eliminar objetos de nuestro entorno usando la función rm()
rm(gasto_ropa, gasto_total, gasto_transporte, edad, tiene_hijos, nombre)

# VECTORES: Un vector es una secuencia de elementos de datos. Los elementos de un vector se llaman componentes y tienen que ser todos del mismo tipo  
nombre <- c("Stephan", "Maria", "Pablo", "Carla", "Hector", "Sara")
edad <- c(24, 23, 26, 27, 26, 30)
nota <- c(6, 5, 9, 1, 8, 3)

# Funciones útiles para trabajar con vectores
class(edad)

#De análisis
sum(edad)

mean(edad)
sd(edad)
max(edad)
min(edad)

table(edad)

summary(edad)


# LISTAS: Cuando el vector contiene más de un tipo de datos se denomina LISTA (list) y se genera con list()
ejemplo_lista <- list(1,"a",2,"b")
ejemplo_lista

# MATRICES: Estructura de datos con dos dimensiones y datos del mismo tipo
ejemplo_matriz <- matrix(1:21, nrow = 7, ncol = 3)
ejemplo_matriz

# ARRAYS: Estructura de datos con multiples dimensiones
ejemplo_array <- array(data=1:24,dim=c(3,4,2)) 
ejemplo_array

rm(ejemplo_lista, ejemplo_matriz, ejemplo_array)

# DATAFRAMES: Un data frame es una lista de vectores de igual longitud (mismo número de filas)
# http://www.r-tutor.com/r-introduction/data-frame

#Creamos un data frame a partir de vectores
data <- data.frame(nombre, edad, nota)
data

#borramos los vectores creados anteriormente par quedarnos solo con nuestro dataframe
rm(edad, nombre, nota)

# Como accedemos a las variables de dataframe?
data$edad

# Aplicar funciones a variables de un dataframe
sum(data$edad)

mean(data$edad)
sd(data$edad)
max(data$edad)
min(data$edad)

table(data$edad)

summary(data$edad)


# Y si queremos crear o recodificar una nueva variable?

# Ejemplo 1
data$año_nacimiento <- NA
data$año_nacimiento <- 2020 - data$edad

# Ejemplo 2 (factores)
data$aprobado_suspenso <- NA
data$aprobado_suspenso[data$nota < 5] <- 0
data$aprobado_suspenso[data$nota > 4] <- 1

data$aprobado_suspenso <- factor(x = data$aprobado_suspenso,
                                 levels = c(0,1),
                                 labels = c("Suspenso", "Aprobado"))

#vamos a ver las frecuencias de nuestra nueva variable
table(data$aprobado_suspenso)
prop.table(table(data$aprobado_suspenso))*100
table(data)

# Subconjuntos

# seleccionar columnas
data[1]
data[c(1,3)]

# eliminar columnas
data[-1]
data[-c(1,3)]

#seleccionar filas
data[1,]
data[c(1,3),]

#filtrar - Nos quedamos solo con los aprobados de 27 años
data_aprobados <- data[data$aprobado_suspenso == "Aprobado",]
mean(data_aprobados$nota)

#Una forma más sencilla de hacer todo a través de funciones del paquete tidyverse. Vamos a eliminar todo menos nuestro dataframe original.


#Primero hay que descargar el paquete
install.packages("tidyverse", dependencies = T)

#Ahora activamos
library(tidyverse)

# Ya podemos usar las funciones de Tidyverse
# Vamos aprender a usar filter() y select()

# Y si queremos filtrar el dataframe? (Quedarnos solo con los aprobados) (función del paquete tidyverse)
data_aprobados <- filter(data, 
                         aprobado_suspenso == "Aprobado")
data_aprobados


# Y si queremos quedarnos solo con unas variables concretas? (solo nos interesa el nombre y la nota) (función del paquete tidyverse)
data_aprobados <- select(data_aprobados, 
                         nombre, nota)
data_aprobados

# Ahora podemos analizar solo a los aprobados 
mean(data_aprobados$nota)


# ¿Podemos combinar estas operaciones?

#Para eso utilizamos los llamados "pipes" %>% (del paquete tidyverse)
#Las pipes nos permiten encadenar distintas funciones del paquete tidyverse como filter() o select()
#Estas 3 lineas de codigo hacen exactamente lo mismo que las lineas que van de la 102 a la 110

data_aprobados <- data %>% 
  filter(aprobado_suspenso == "Aprobado") %>% 
  select(nombre, nota)


