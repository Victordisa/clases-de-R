######################################
#                                    #
# Nombre:                            #
# NIU:                               #
#                                    #
######################################



# ¡Holi! Bienvenido/a a la primera actividad evaluada de la asignatura, el cual consistirá en la resolución
# de un conjunto de 10 ejercicios. Cada ejercicio sumará un punto.
# 
# Tendrás que responder a los ejercicios en los espacios que te iré dejando a lo largo de este script.
# Una vez terminado el ejercicio guarda los cambios y subelo a campus virtual a la pestaña habilitada.
# SÚBEME ÚNICAMENTE EL SCRIPT, NO LA BASE DE DATOS
# Nombra al script final con tu nombre completo.
# 
# Tienes de plazo hasta antes del 2021 (Por favor, no me lo envíes en medio de las campanadas xD)
# 
# ¡Mucha suerte! :)



# ANTES DE EMPEZAR #######################################################################################################################
#
# - Recuerda establecer tu directorio de trabajo para este ejercicio
# - Activa las librerías tidyverse y haven
# - Haz estas dos tareas iniciales en este mismo espacio que te dejo
#
##########################################################################################################################################









##########################################################################################################################################
# Ejercicio 1:
#
# - Abre la base datos que te he proporcionado y almacénalo en un objeto llamado "data"
#
# - Quédate únicamente con las siguientes variables:
#
#   "cntry" - País del encuestado 
#   "gndr" - Genero del encuestado
#   "agea" - Edad del encuestado 
#   "stfhlth" - Valoración del sistema sanitario (Escala 0-10)
#   "lrscale" - Ideología del entrevistado (Escala 0-10) 
#
# - Renombra estas variables de la siguiente forma 
#
#   "cntry" - pais 
#   "gndr" - genero
#   "agea" - edad 
#   "stfhlth" - satis_sani
#   "lrscale" - ideol 
#
# > Terminado este ejercicio deberías tener un objeto en el environment llamado data con 5 variables renombradas
#
##########################################################################################################################################











##########################################################################################################################################
# Ejercicio 2:
#
# - Convierte en tipo factor las variables: pais y genero
# - Convierte en tipo numérico las variables: edad, satis_sani e ideol
#
#########################################################################################################################################













###########################################################################################################################################
# Ejercicio 3:
#
# - Genera una nueva variable llamada edad_r con los siguientes valores:
#
#   1 - Si la persona tiene entre 15 y 17 años
#   2 - Si la persona tiene entre 18 y 24 años
#   3 - Si la persona tiene entre 25 y 34 años
#   4 - Si la persona tiene entre 35 y 44 años
#   5 - Si la persona tiene entre 45 y 54 años
#   6 - Si la persona tiene entre 55 y 64 años
#   7 - Si la persona tiene entre 65 años o más
#
#
# - Factoriza esta nueva variable y etiqueta los valores de la siguiente forma:
#
#   1 = 15-17
#   2 = 18-24 
#   3 = 25-34
#   4 = 35-44
#   5 = 45-54
#   6 = 55-64
#   7 = 65 o más
#
##########################################################################################################################################













##########################################################################################################################################
# Ejercicio 4:
#
# Filtra la base de datos llamada data, de manera que nos quedemos solo con las personas con información sobre su edad, es decir,
# elimina de data a todas las personas con NA en la variable de edad
#
# > Terminado este ejercicio deberías tener un objeto en el environment llamado data con 6 variables y 46864 observaciones
#
##########################################################################################################################################









##########################################################################################################################################
# Ejercicio 5:
#
# - En España, ¿que porcentaje de personas tenemos en cada una de las categorías de edad que has creado en el ejercicio 3?
#
##########################################################################################################################################










##########################################################################################################################################
# Ejercicio 6:
#
# - Visualiza con ggplot la pregunta anterior (Tienes total libertad para hacer el gráfico como más te guste)
#
##########################################################################################################################################










##########################################################################################################################################
# Ejercicio 7:
#
# -¿Que países de esta base de datos tienen un mayor porcentaje de personas de 65 años o más?
#
# > Muestrame en consola esa información ordenada de mayor a menor y de la forma más clara posible
#
##########################################################################################################################################










##########################################################################################################################################
# Ejercicio 8:
#
# - ¿Cuales son los paises con una mejor valoración media del sistema sanitario?
#
# > Muestrame en consola esa información ordenada de mayor a menor
#
##########################################################################################################################################










###########################################################################################################################################
# Ejercicio 9:
#
# - Genera una nueva variable llamada ideol_r con los siguientes valores:
#
#   1 - Si la persona tiene una ideología de 0 o 1
#   2 - Si la persona tiene una ideología de 2, 3 o 4
#   3 - Si la persona tiene una ideología de 5
#   4 - Si la persona tiene una ideología de 6, 7 u 8
#   5 - Si la persona tiene una ideología de 9 o 10
#
#
# - Factoriza esta nueva variable y etiqueta los valores de la siguiente forma:
#
#   1 = Extrema izquierda
#   2 = Izquierda
#   3 = Centro
#   4 = Derecha
#   5 = Extrema derecha
#
# - ¿Es cierto que los jóvenes (menores de 35 años) son generalmente más de izquierdas?
#
# - ¿Cual es el país donde la juventud (menores de 35 años) es más de izquierdas?
#
##########################################################################################################################################











###########################################################################################################################################
# Ejercicio 10:
#
# Visualiza con ggplot la distribución ideológica de los jóvenes (menores de 35 años) en todos los paises de la base de datos
#
# > Recuerda utiliza la variable de ideología construida en el ejercicio 9
#
###########################################################################################################################################












# SE ACABÓ ################################################################################################################################


# Espero que no te hayan resultado muy complicados estos ejericios!
# En cualquier caso, felices fiestas y disfruta mucho de las vacaciones!! :)
#
# Abrazos,
#
# Stephan                 
#                                /\
#                               <  >
#                                \/
#                                /\
#                               /  \
#                              /++++\
#                             /  ()  \
#                             /      \
#                            /~`~`~`~`\
#                           /  ()  ()  \
#                           /          \
#                          /*&*&*&*&*&*&\
#                         /  ()  ()  ()  \
#                         /              \
#                        /++++++++++++++++\
#                       /  ()  ()  ()  ()  \
#                       /                  \
#                      /~`~`~`~`~`~`~`~`~`~`\
#                     /  ()  ()  ()  ()  ()  \
#                     /*&*&*&*&*&*&*&*&*&*&*&\
#                    /                        \
#                   /,.,.,.,.,.,.,.,.,.,.,.,.,.\
#                              |   |
#                             |`````|
#                             \_____/