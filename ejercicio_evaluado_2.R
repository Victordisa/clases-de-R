######################################
#                                    #
# Nombre:                            #
# NIU:                               #
#                                    #
######################################


# ¡Holi! Tras semanas curtiendote en el noble arte del análisis de datos con R,
# has llegado al ejercicio definitivo que pondrá a prueba todo lo visto en estas 8 sesiones que hemos compartido.
# Se trata de un conjunto de 7 ejercicios. Cada ejercicio tiene una puntuación asignada entre parentesis.
# 
# Tendrás que responder a los ejercicios en los espacios que te iré dejando a lo largo de este script.
# Una vez terminado el ejercicio guarda los cambios y subelo a campus virtual a la pestaña habilitada.
# SÚBEME ÚNICAMENTE EL SCRIPT, NO LA BASE DE DATOS
# Nombra al script final con tu nombre completo.
# 
# Tienes de plazo hasta el sábado 13 de febrero
# 
# Una vez más ¡Mucha suerte! :D

#######################################################################################################################
# Los datos que vamos a utilizar para este ejercicio corresponde al estudio preelectoral del CIS                      #
# de las elecciones catalanas del próximo 14 de febrero de 2021                                                       #  
# FUENTE: http://www.cis.es/cis/opencm/ES/1_encuestas/estudios/ver.jsp?estudio=14541&cuestionario=17517&muestra=24855 #                                                            #
#######################################################################################################################

# ANTES DE EMPEZAR #######################################################################################################################
#
# - Recuerda establecer tu directorio de trabajo para este ejercicio
# - Activa las librerías que consideres oportunas
# - Haz estas dos tareas iniciales en este mismo espacio que te dejo
#
##########################################################################################################################################







##########################################################################################################################################
# Ejercicio 1: (1 punto)
#
# - Abre la base datos que te he proporcionado y almacénalo en un objeto llamado "data"
#
# - Quédate únicamente con las siguientes variables:
#
#   "SEXO" - Genero del encuestado 
#   "EDAD" - Edad del encuestado
#   "TAMUNI" - Tamaño del habitat en el que reside el encuestado 
#   "P24" - Grado de nacionalismo catalán (Escala 1-10) 
#   "P22" - Preferencia en la organización territorial del Estado
#
# - Renombra estas variables de la siguiente forma 
#
#   "SEXO" - sexo 
#   "EDAD" - edad
#   "TAMUNI" - tamuni 
#   "P24" - nacionalismo
#   "P22" - independentismo
#
# > Terminado este ejercicio deberías tener un objeto en el environment llamado data con 5 variables renombradas
#
##########################################################################################################################################








##########################################################################################################################################
# Ejercicio 2: (1 punto)
#
# Haz las siguientes recodificaciones:
#
# sexo: factoriza la variable de forma que tenga 2 categorías (1 y 2)
# siendo 1 hombre y 2 mujer,
#
# edad: convierte en numérica la variable edad
# recuerda enviar a NA los valores superiores a 98
#
# tamuni: recodifica la variable de forma que tenga 2 categorías.
# La categoría 1 debe agrupar a los que viven en municipios  de 50.000 habitantes o menos.
# La categoría 2 debe agrupar a los que viven en municipios  de 50.001 habitantes o más.
# Etiqueta la categoría 1 con "Municipio pequeño" y la categoría 2 con "Municipio grande" 
#
# nacionalismo: convierte en numérica la variable nacionalismo y envía a NA los valores superiores a 10
#
# independentismo: Envía a NA los valores superiores a la categoría 5.
# recodifica de tal forma que asignemos un valor 0 a los que se encuentren en las categorías 1,2,3 o 4,
# y el valor 1 a los que se encuentren en la categoría 5
# Factoriza la variables y etiqueta de la siguiente forma
# 0 = No independentista
# 1 = Independentista
#
# Terminadas todas estas recodificaciones elimina de la base de datos todas las filas que contengan algún NA
# Al finalizar este ejercicio deberías tener una base de datos con 5 columnas y 3.705 observaciones
#
#########################################################################################################################################











##########################################################################################################################################
# Ejercicio 3: (1 punto)
#
# ¿Tienen los independentistas una edad media inferior que los no inpendentistas?
# ¿Es estadísticamente significativo lo que se observa en los datos?
# Justifica tu respuesta
#
#########################################################################################################################################










##########################################################################################################################################
# Ejercicio 4: (2 punto)
# 
# Genera un modelo de regresión logística utilizando 
# la variable independentismo como variable dependiente y el resto como variables independientes
# almacena la regresión en un modelo llamado "modelo_indepe"
#
# ¿Cuanta probabilidad de ser independentista aumenta o disminuye vivir en un municipio grande?
# ¿Cuanta probabilidad de ser independentista aumenta o disminuye incrementar una unidad en la escala nacionalista?
#
#########################################################################################################################################









##########################################################################################################################################
# Ejercicio 5: (2 punto)
#
# ¿Qué probabilidad tiene esta persona de ser independentista?
#
# Nombre: Lluis
# Sexo: Hombre
# Edad: 30 años
# Municipio de residencia: Llagostera (8.297 habitantes)
# Grado de nacionalismo: 7 en la escala 1-10
#
#########################################################################################################################################










##########################################################################################################################################
# Ejercicio 6: (1 punto)
#
# ¿Tenemos problemas de multicolinealidad?
# ¿Y de homocedasticidad?
# 
#########################################################################################################################################











##########################################################################################################################################
# Ejercicio 7: (2 punto)
#
# Realiza una validaciòn cruzada del modelo construido
#  - Utiliza el 70% de la base de datos para entrenar el modelo y el 30% restante para testear
#  - Usando un umbral del 60% de probabilidad para considerar a alguien independentista, saca la matriz de confusión, 
#
#  ¿cuál es la precisión del modelo entrenado prediciendo?
#  ¿Cuantas observaciones ha clasificado mal nuestro modelo?
#
#########################################################################################################################################













# SE ACABÓ ################################################################################################################################
#
#
# De verdad que ha sido un verdadero placer daros clases y espero
# que os resulte muy útil todo lo que hemos visto a los largo esta asignatura.
#
# Estoy a vuestra disposición para cualquier cosa aunque deje de ser vuestro profe.
#
# Podéis contactarme por cualquiera de estos canales:
#
# Mail: stephanzhaolafuente@campus.eae.es
# LinkedIn: https://www.linkedin.com/in/stephanzhao/
# Twitter: https://twitter.com/StephanZhao
# Instagram: https://www.instagram.com/stephanzhao/
#
# Os deseo muchísimos éxitos!
# Abrazos,
#
# Stephan 
#
# P.D: De regalo os dejo este Snoopy de la suerte!! :D
#
#   ,-~~-.___.
#  / |  '     \         
# (  )         0  
#  \_/-, ,----'            
#     ====           // 
#    /  \-'~;    /~~~(O)
#   /  __/~|   /       |     
# =(  _____| (_________|