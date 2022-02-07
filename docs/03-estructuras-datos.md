# **Estructuras de datos** {#estructurasdatos}

La sección básica de R, introdujo la terminología de variables y funciones en lo que respecta a la sintaxis del código en R. En este capítulo, revisaremos todo lo que se debe conocer para manejar estructuras de datos diversas. Estos son los insumos esenciales que ingresarán más adelante en las funciones para poder procesar datos, analizarlos o convertirlos en impresionantes gráficos estadísticos. La teoría sobre las variables es la base de todo lo que desarrollarás en R.

## Clasificación de variables

Toda variable cuenta con dos atributos: clase y estructura. Para entender cómo se almacenan los datos en R, se necesita conocerlas a detalle.

(ref:gatocaja) Analogía del gato en la caja para entender a las variables. Aquí, el gato es el contenido; la caja, la estructura. Esta "variable" podría ser considerada de la clase "contenedora de gatos" y de estructura "cúbica". De igual manera, en R reconoceremos variables contenedoras de números, de caracteres, de valores lógicos, mismos que podrán estar ordenados en estructuras de una, dos, tres o N dimensiones.  

<div class="figure" style="text-align: center">
<img src="figs/fotografias/gatobox.jpg" alt="(ref:gatocaja)" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-1)(ref:gatocaja)</p>
</div>
<br>


### Clases atómicas

Según su contenido, en R existen seis clases básicas (o atómicas) de variables:

- Clase lógica: identificado con el nombre `logical`
- Clase caracter o texto: identificado con el nombre `character`
- Clase número con decimales: conocidos como *doubles*, identificado con el nombre `numeric`
- Clase número entero: identificado con el nombre `integer`
- Clase número complejo: identificado con el nombre `complex`
- Clase crudo o en bits: identificado con el nombre `raw`

De estos, los últimos tres no serán utilizando a lo largo de este libro. Quizá surja la pregunta de por qué no usar números enteros. En realidad una variable del tipo `numeric` ya incluye enteros y con decimales (es decir, todos los números reales). Para efectos de una gran cantidad de funciones estadísticas, en R no es relevante brindarle números enteros como `integer`, o diferenciarlos de `numeric`.

### Estructuras de datos 

Según su estructura, las variables pueden tener una forma de almacenamiento con diferente dimensionalidad. 

- La estructura más básica de R es el vector, con una sola dimensión. 
- El vector se convierte en un factor si es que contiene información categorizada, y sigue teniendo una dimensión. 
- Si vectores se colocan verticalmente, y se apilan lado a lado, se convierten en una estructura de dos dimensiones. Dependiendo de sus características estas pueden ser: 
matrices, data frames o tibbles.
- Se puede considerar a los arrays como arreglos multidimensionales de vectores.
- Finalmente, las _listas_ son estructuras de datos básicas. No se consideran dimensionales dado que almacena a otras estructuras de datos secuencialmente. Una lista puede albergar vectores, factores, matrices, data frames, tibbles, arrays, incluso otras listas.

(ref:strdatos1) Estructuras informáticas para almacenar de datos en el lenguaje R.

<div class="figure" style="text-align: center">
<img src="figs/elaboradas/Estructuras de datos en R.png" alt="(ref:strdatos1)" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-2)(ref:strdatos1)</p>
</div>

## Vectores

R es un lenguaje basado en vectores. La estructura de almacenamiento de datos más básica es el vector. Un vector contiene elementos, que pueden ser números, textos, valores lógicos, y de cualquier clase atómica. No obstante, solamente puede almacenar elementos de una única clase atómica a la vez. Solo números, solo texto, solo valores lógicos.

### Crear un vector

Para crear un vector, se utiliza la función `c()` donde especifíco los elementos directamente:


```r
# Vector numérico
numeros <- c(1,2,3,4,5,6)
numeros
# [1] 1 2 3 4 5 6
```

Un operador de gran utilidad es `:` que permite crear rangos de números enteros.


```r
1:6
# [1] 1 2 3 4 5 6
```

Además de `c()`, existe la función `vector()` para crear vectores vacíos de una longitud y clase atómica determinado.


```r
# Vector lógico de longitud (length) 10
vLog <- vector("logical", length=10)
vLog
#  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE

# Vector de caracteres de longitud (length) 15
vCha <- vector("character", length=15)
vCha
#  [1] "" "" "" "" "" "" "" "" "" "" "" "" "" "" ""

# Vector de números de longitud (length) 20
vNum <- vector("numeric", length=20)
vNum
#  [1] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
```

La razón para usar `vector()` es para crear un *contenido vacío* de una longitud determinada, el cual podremos ir llenando con los resultados de un loop. Nos adelantaremos un poco con el código un tanto más avanzado, pero verás el uso de esta función.


```r
vNum <- vector("numeric", length=6)
vNum
# [1] 0 0 0 0 0 0

# Loop donde a una secuencia de números del 1 al 6
# se le multiplica a cada uno por 100
for (i in 1:6){
  vNum[i] <- i * 100
}

# Vector ya rellenado por el loop
vNum
# [1] 100 200 300 400 500 600
```

### Vectores de secuencias y repeticiones

Existen formas especiales de crear vectores implica el uso de `seq()` para crear secuencias numéricas, o `rep()` para repetir de algún valor una determinada cantidad de veces.

Para crear una secuencia del 10 al 100 cada 5 elementos, se usa el argument `by =` dentro de `seq()`


```r
seq(10, 100, by=5)
#  [1]  10  15  20  25  30  35  40  45  50  55  60  65  70  75  80  85  90  95 100
```

Para crear una secuencia del 36 números entre 10 y 100, se usa el argument `length =` dentro de `seq()`


```r
seq(10, 100, length=36)
#  [1]  10.00  12.57  15.14  17.71  20.29  22.86  25.43  28.00  30.57  33.14  35.71
# [12]  38.29  40.86  43.43  46.00  48.57  51.14  53.71  56.29  58.86  61.43  64.00
# [23]  66.57  69.14  71.71  74.29  76.86  79.43  82.00  84.57  87.14  89.71  92.29
# [34]  94.86  97.43 100.00
```

Las repeticiones implica definir dos argumentos: lo que se repetirá, y la cantidad de veces. Para repetir el carácter `América` 10 veces, se usa:


```r
rep("América", 10)
#  [1] "América" "América" "América" "América" "América" "América" "América" "América"
#  [9] "América" "América"
```

### Funciones útiles para vectores

Resulta útil conocer algunas de las funciones básicas en R para trabajar con vector.


Table: (\#tab:unnamed-chunk-10)Operaciones (símbolos) aritméticas en R

Función      Descripción                                                                                    Ejmplo.de.uso                
-----------  ---------------------------------------------------------------------------------------------  -----------------------------
`length()`   Reporta el número de elementos de un vector, o la cantidad de columnas de una base de datos.   `length(x)` o `length(iris)` 
`max()`      Valor máximo de un conjunto de datos `x`.                                                      `max(x)`                     
`mean()`     Promedio de un conjunto de datos `x`.                                                          `mean(x)`                    
`median()`   Mediana de un conjunto de datos `x`.                                                           `median(x)`                  
`min()`      Valor mínimo de un conjunto de datos `x`.                                                      `min(x)`                     
`range()`    Valor mínimo y máximo de un conjunto de datos `x`.                                             `range(x)`                   
`sd()`       Desviación estándar de un conjunto de datos `x`.                                               `sd(x)`                      
`sum()`      Suma de todos los elementos numéricos de un conjunto de datos `x`.                             `sum(x)`                     
`var()`      Varianza de un conjunto de datos `x`.                                                          `var(x)`                     
`prod()`     Multiplica de todos los elementos numéricos de un conjunto de datos `x`.                       `prod(x)`                    
`rep()`      Repite un vector una cantidad de veces definida.                                               `rep("Perú", 15)`            
`seq()`      Calcula una secuencia de números al ofrecerle un inicio, un final y cada cuántos valores.      `seq(0, 10, 2)`              

### Operaciones numéricas con vectores

Las operaciones matemáticas que involucran vectores se aplican con lo que se denomina *element-wise*, que se traduce como _**elemento a elemento**_.


```r
vector2 <- 10:20
vector2 + 5
#  [1] 15 16 17 18 19 20 21 22 23 24 25
```

En la operación anterior, se le sumó 5 unidades a cada elemento de `vector2`. Si se **operan dos vectores de igual longitud**, los elementos del primer vector se van operando uno por uno contra el elemento correspondiente en la posición homóloga del segundo vector.


```r
vector3 <- 0:10
vector2 * vector3
#  [1]   0  11  24  39  56  75  96 119 144 171 200
```

Si se **operan dos vectores de diferente longitud** de elementos, el resultado tendrá la longitud del mayor, y el menor se irá operando elemento a elemento, y se *recliclará* desde su primer elemento para aplicarse hasta culminar de operar todo.


```r
vector4 <- 1:3

# Revisar el contenido de los vectores
vector2
#  [1] 10 11 12 13 14 15 16 17 18 19 20
vector4
# [1] 1 2 3

# Producto de dos vectores de longitud desigual
vector2 * vector4
# Warning in vector2 * vector4: longer object length is not a multiple of shorter
# object length
#  [1] 10 22 36 13 28 45 16 34 54 19 40
```

### Valores perdidos en vectores

Estos elementos son los tipicos *NA* que aparecen cuando no hay un dato disponible en un conjunto de datos. Si operamos un vector con funciones estadísticas, como `mean()` o `sd()`, el resultado se verá afectado por la presencia del NA, y este impedirá que se genere el resultado correcto. Para evitarlo, es importante incorporar el argumento `na.rm = TRUE` para *remover* los NA de un conjunto de datos y operar sin ellos.


```r
vectorNA <- c(10, 20, NA, 40, 50)

# Operar directo (errado)
mean(vectorNA)
# [1] NA

# Operar incluyendo el argumento para remover NAs
mean(vectorNA, na.rm = TRUE)
# [1] 30
```

### Indexación de vectores

Indexar significa ubicar posiciones. Cada elemento dentro del vector tiene una posición única. Se puede **extraer el contenido de una posición única definida** dentro de un vector utilizando el operador `[]`. Utilicemos el objeto `vectorNA` creado en la sección anterior:


```r
vectorNA[1]
# [1] 10

vectorNA[3]
# [1] NA

vectorNA[5]
# [1] 50
```

Para **extraer más de un elemento a la vez**, en lugar de colocar una sola posición dentro de `[]`, se coloca un vector con las posiciones. 


```r
vectorNA[c(1,3)]
# [1] 10 NA

vectorNA[c(1,3,5)]
# [1] 10 NA 50
```

Otro modo es crear un vector de índice, **index**, que contenga las posiciones de interés:


```r
index <- c(1,3,5)
vectorNA[index]
# [1] 10 NA 50
```

**Indexar con operaciones lógicas** también es posible. El operador `[]` puede recibir vectores lógicos, para entregar como resultado aquellos elementos cuyas posiciones sean `TRUE` dentro del vector lógico. Si se define una operación lógica como ¿Qué elementos de un vector numérico `x` son valores mayores iguales a 25?, se debe escribir en R: `x>=25`.


```r
# Veamos el resultado para entender la operación lógica
# (nota que los elemento NA no se convierten a TRUE o FALSE)
vectorNA>=25
# [1] FALSE FALSE    NA  TRUE  TRUE
```

Conociendo esto, el resultado de la indexación sería:


```r
# En dos pasos
index <- vectorNA>=25
vectorNA[index]
# [1] NA 40 50

# En un paso
vectorNA[vectorNA>=25]
# [1] NA 40 50
```

En caso se requiera conocer en qué posiciones se cumple la condición lógica anterior, usa la función `which()`:


```r
which(vectorNA>=25)
# [1] 4 5
```

Dado que `which()` solo reporta posiciones `TRUE` y obvia las posiciones con NA, usarlo en la indexación es la mejor manera de reportar los elementos sin incluir en el resultado los valores NA:


```r
vectorNA[which(vectorNA>=25)]
# [1] 40 50
```

### Muestreo de vectores

En ocasiones es requerido realizar muestreos virtuales, en la que se especifique cuántos elementos se requieren extraer de un vector. En R, la extracción se realiza con la función `sample()`, como:

- **Muestreo con reemplazamiento:** donde cada elemento extraído se devuelve al conjunto inicial. Este elemento ya muestreado permanecer disponible para aparecer en siguiente muestreo aleatorio. Se especifica con el argumento `replace = TRUE`.

- **Muestreo sin reemplazamiento:** donde cada elemento extraído no vuelve a aparecer en el conjunto inicial. Este elemento ya muestreado no estará disponible para aparecer en siguiente muestreo aleatorio. Se especifica con el argumento `replace = FALSE`.

Si el muestreo es sin reemplazamiento, solo se puede extraer un máximo de elementos igual a la cantidad de elementos del conjunto inicial.

\BeginKnitrBlock{rmdnote}<div class="rmdnote">Antes de cualquier función de aleatorización, es importante establecer un conjunto de números aleatorios para que el código sea replicable. Asegurar replicabilidad de los experimentos y análisis es importante para las publicaciones científicas. Utiliza la función `set.seed(123)` definiendo un número cualquiera, como aquí se colocó 123.</div>\EndKnitrBlock{rmdnote}


```r
# Muestreo con reemplazamiento
# de un conjunto de 2 elementos
conjuntoInicial <- c("A","Z")

set.seed(123)
sample(conjuntoInicial, 25, replace = TRUE)
#  [1] "A" "A" "A" "Z" "A" "Z" "Z" "Z" "A" "A" "Z" "Z" "Z" "A" "Z" "A" "Z" "A" "A" "A"
# [21] "A" "Z" "A" "A" "A"

# Muestreo sin reemplazamiento
# de un conjunto con 30 elementos
conjuntoInicial2 <- rep(c("A","Z"), c(10,20))

set.seed(321)
sample(conjuntoInicial2, 25, replace = FALSE)
#  [1] "Z" "Z" "Z" "Z" "Z" "Z" "Z" "A" "Z" "Z" "Z" "Z" "A" "A" "Z" "Z" "Z" "Z" "A" "Z"
# [21] "Z" "A" "Z" "A" "A"
```

## Factores

Los factores son tipos especiales de vectores, donde R evalúa los valores únicos de la secuencia y los define como categorías. Son muy útiles en programación dado que permiten graficar, por ejemplo, con un color diferenciado cada nivel de una variable categorica. Imagina que se requiere hacer un gráfico de dispersión de puntos para ver la relación entre dos variables, pero permitiendo que el color de los puntos refleje el grupo al que pertenece cada observación:

(ref:factoresEjemplo) Ejemplo de uso del conjunto de datos _Grupos_ (que es un Factor) empleada para colorear los puntos del gráfico de enfrentamiento de las variables _Pétalo_ y _Sépalo_.

<div class="figure" style="text-align: center">
<img src="03-estructuras-datos_files/figure-html/unnamed-chunk-24-1.svg" alt="(ref:factoresEjemplo)" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-24)(ref:factoresEjemplo)</p>
</div>

### Crear un factor

Para crear un factor se utiliza la función `factor()`, y un vector dentro de ella. La función evaluará los valores únicos del vector y definirá los niveles del factor:


```r
# Crear un vector de texto cualquiera 
vectorC <- c("A","B","A","A","A","A","B","A","C","C","B")

# Crear un vector de texto cualquiera
vectorN <- c(1,1,2,1,2,2,1,1,2,1,2,1,2,2,2,1)

# Crear factores en base a los vectores
factor(vectorC)
#  [1] A B A A A A B A C C B
# Levels: A B C
factor(vectorN)
#  [1] 1 1 2 1 2 2 1 1 2 1 2 1 2 2 2 1
# Levels: 1 2
```

### Niveles de un factor

Cada factor muestra sus niveles (Levels) al final de la secuencia. Se puede conocer cuales son los niveles de un factor guardado en el ambiente, utilizando la función `levels()`:


```r
# Guardar el factor
F1 <- factor(vectorC)

# Revisar los niveles del factor
levels(F1)
# [1] "A" "B" "C"
```

### Reordenar los niveles

El orden de los niveles es importante. Por defecto se ordenan los niveles de menor a mayor (si son números), o de la A a la Z (sin son texto). Para una regresión, para un gráfico, el orden afecta los resultados. En una regresión lineal, el primer nivel de un factor puede ser considerado como _nivel base_, y las interpretaciones se harán como factores de aumento o disminución de los otros niveles respecto al nivel base. En un gráfico, el orden de los colores, o las etiquetas de un eje, seguirán este orden. 

Para cambiar el orden, las alternativas son variadas. Si solo se desea definir un nivel base, y el orden de los demás niveles no es importante, se usa `relevel()` con el segundo argumento especificando el nivel que será el nuevo nivel base.


```r
# Especificando el primer nivel como "C" 
F1_cambiado <- relevel(F1, "C")
F1_cambiado
#  [1] A B A A A A B A C C B
# Levels: C A B
```

Si se necesita especificar un orden definido manualmente para todos los niveles, es mejor definirlo al momento de crear el factor, usando el argumento `levels=`:


```r
# Crear un factor con niveles ordenados manualmente
F2 <- factor(vectorC, levels=c("B","C","A"))

# Revisar los niveles de F2
levels(F2)
# [1] "B" "C" "A"
```

### Etiquetas de un factor

En algunas ocasionas existe la necesidad de cambiar el nombre de algún (o algunos) nivel(es), se puede usar un vector con los cambios deseados como contenido del argumento `labels=`. El orden de las etiquetas cambiadas debe seguir el mismo orden original de los niveles:


```r
# Crear un factor con cambie de etiqueta
F3 <- factor(F1, labels=c("Absoluto", "B", "Cambio"))

# Revisar los niveles de F3
levels(F3)
# [1] "Absoluto" "B"        "Cambio"

# Revisando el contenido original (sin cambios) en F1
F1
#  [1] A B A A A A B A C C B
# Levels: A B C

# Revisar el contenido de F3
F3
#  [1] Absoluto B        Absoluto Absoluto Absoluto Absoluto B        Absoluto
#  [9] Cambio   Cambio   B       
# Levels: Absoluto B Cambio
```

Como fue evidente, al crear un factor se puede usar como insumo un vector, como `vectorN`, u otro factor previamente creado, como `F1`.

### Valores perdidos en un factor

Los valores perdidos no forman parte de los niveles de un factor. Se muestran como contenido del conjunto de datos, pero no son considerados niveles.


```r
conjunto1 <- c(1,2,1,1,NA,2,1,NA,3,2,1,3,2,3,3,NA)
fctConjunto1 <- factor(conjunto1)
fctConjunto1
#  [1] 1    2    1    1    <NA> 2    1    <NA> 3    2    1    3    2    3    3    <NA>
# Levels: 1 2 3
```

Por el contrario, si el investigador coloca deliberadamente los NA como texto, estos sí serán considerados como nivel:


```r
conjunto2 <- c(1,2,1,1,"NA",2,1,"NA",3,2,1,3,2,3,3,"NA")
fctConjunto2 <- factor(conjunto2)
fctConjunto2
#  [1] 1  2  1  1  NA 2  1  NA 3  2  1  3  2  3  3  NA
# Levels: 1 2 3 NA
```

### Indexación de factores

Indexar significa ubicar posiciones. Tal cual con un vector, en los factores cada elemento dentro del vector tiene una posición única. Para **extraer el contenido de una posición única definida** se utiliza igualmente el operador `[]`. Utilicemos el objeto `conjunto1` creado en la sección anterior:


```r
fctConjunto2[3]
# [1] 1
# Levels: 1 2 3 NA

fctConjunto2[5]
# [1] NA
# Levels: 1 2 3 NA
```

El resto de reglas para indexar varios elementos a la vez, o indexar con vectores lógicos, son las mismas que para un vector:


```r
# Indexar varios elementos a la vez
fctConjunto2[c(3,5,10)]
# [1] 1  NA 2 
# Levels: 1 2 3 NA
```

Indexar con operaciones relacionales puede ser engorroso. Debido a que los niveles del factor ya no son considerados *números per se*, sino que son categorías textuales, utiliza operaciones como *mayor qué*, *menor qué* y otras similares, produce resultados vacíos NA. Es imposible para R saber que *Categoría 1* es menor igual que *Categoría 2*. No obstante, se pueden aún utiliza operaciones relacionales de igualdad: 


```r
# Con operación relacional de menor qué
# obtendremos un resultado erróneo
index <- fctConjunto2 < 3
# Warning in Ops.factor(fctConjunto2, 3): '<' not meaningful for factors
fctConjunto2[index]
#  [1] <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA>
# Levels: 1 2 3 NA

# Con operación relacional de igualdad
index <- fctConjunto2 == 3
fctConjunto2[index]
# [1] 3 3 3 3
# Levels: 1 2 3 NA

# Utilizando el operador %in% podemos pedir 
# varias igualdades a la vez
index <- fctConjunto2 %in% c(1,2)
fctConjunto2[index]
# [1] 1 2 1 1 2 1 2 1 2
# Levels: 1 2 3 NA
```

Si se lidia con factores conteniendo NA (no su versión en texto "NA"), el indexar sin `which()` genera que se muestren los NA cuando no son requeridos. Utilicemos el objeto `fctConjunto1`: 


```r
index <- fctConjunto1 == 3
fctConjunto1[index]
# [1] <NA> <NA> 3    3    3    3    <NA>
# Levels: 1 2 3
```

Esto no ocurre al usar which() dentro de los `[]`:


```r
fctConjunto1[which(index)]
# [1] 3 3 3 3
# Levels: 1 2 3
```

## Matrices

Las matrices son la primera estructura de dos dimensiones aquí presentada. Son útiles cuando se desee aplicar álgebra de matrices. Pero en el día a día, son rudimentarias y limitantes. Sobre esto último, se comporta como un vector: permiten almacenar solamente un tipo de elemento en toda la tabla.

Para crear una matriz, podemos tomar un vector e ir ordenando los elementos de manera vertical u horizontal en una tabla de $n*p$ dimensiones (donde: $n$ es la cantidad de filas y $p$ de columnas), utilizando la función `matrix()`.


```r
# Crear un rango de valores cualquiera
vector1<-1:10
```

Al encajar el contenido del vector de longitud $n$ en forma de matriz (dos dimensiones) sin especificar la cantidad de columnas o filas, crea una matriz de una sola columna con $n$ filas.


```r
matrix(vector1)
#       [,1]
#  [1,]    1
#  [2,]    2
#  [3,]    3
#  [4,]    4
#  [5,]    5
#  [6,]    6
#  [7,]    7
#  [8,]    8
#  [9,]    9
# [10,]   10
```

Para definir la cantidad de columnas y filas se usan los argumentos `ncol=` y `nrow=`, respectivamente:


```r
matrix(vector1, ncol=2, nrow=5)
#      [,1] [,2]
# [1,]    1    6
# [2,]    2    7
# [3,]    3    8
# [4,]    4    9
# [5,]    5   10
```

Por defecto las columnas se llenan _columna por columna_. Para cambiar el comportamiento de llenado a _fila por fila_, se usa:


```r
matrix(vector1, ncol=2, nrow=5, byrow=TRUE)
#      [,1] [,2]
# [1,]    1    2
# [2,]    3    4
# [3,]    5    6
# [4,]    7    8
# [5,]    9   10
```

En este libro no se hace uso extenso de matrices, por lo que no es necesario conocerlas a mayor detalle.

## Data Frames

Esta estructura de datos de dos dimensiones es la más parecida a lo que una hoja de cálculo permite: colocar diferentes tipos de elementos dentro de la tabla, como texto, números, elementos lógicos, entre otros. Al cargar en RStudio una base de datos de un estudio, esta se almacenará como data frame casi siempre (cuando no, podrá ser un tibble o una lista).

Para crear data frames manualmente en R, se utiliza la función `data.frame()`, especificando como elementos el contenido de cada columna.


```r
DF <- data.frame(Col1 = 1:5, 
                 Col2 = c("Sit1","Sit1","Sit2","Sit2","Sit3"),
                 Log = c(T,T,F,F,T),
                 Fct = factor(c("A","B","C","B","A")))

DF
#   Col1 Col2   Log Fct
# 1    1 Sit1  TRUE   A
# 2    2 Sit1  TRUE   B
# 3    3 Sit2 FALSE   C
# 4    4 Sit2 FALSE   B
# 5    5 Sit3  TRUE   A
```

No obstante, el modo de trabajo habitual implica cargar archivos desde el computador hacia RStudio para guardar tablas de datos como objetos data frame en el ambiente. Para cargar archivos excel (.xlsx) o delimitados (.csv, .txt), o incluso archivos desde SPSS (.SAV), revisa la sección [4.2 Lectura de bases de datos](#lectura-de-bases-de-datos).

## Tibbles

Los Tibbles son estructuras de datos en dos dimensiones que tienen todas las ventajas de almacenaje que los data frame. Pueden almacenar datos de cualquier clase (texto, números, lógicos, etc). Pero presentan dos ventajas adicionales:

- Pueden almacenar objetos complejos, como modelos o fórmulas en las celdas, como si se tratase de un elemento cualquiera. 
- Al imprimir sus resultados en consola, brindan información extra sobre el tamaño de la tabla (filas por columnas), y el tipo de datos que almacena de cada columna (su clase).
- También, al ser vistos en consola, solo muestran las filas y columnas adecuadas para el pequeño tamaño de la consola, sin desbordarse como lo hacen los data frame. Esto último se verá reflejado cuando visualices en consola bases de datos grandes.


```r
TB <- tibble(Col1 = 1:5, 
                 Col2 = c("Sit1","Sit1","Sit2","Sit2","Sit3"),
                 Log = c(T,T,F,F,T),
                 Fct = factor(c("A","B","C","B","A")))
TB
# # A tibble: 5 x 4
#    Col1 Col2  Log   Fct  
#   <int> <chr> <lgl> <fct>
# 1     1 Sit1  TRUE  A    
# 2     2 Sit1  TRUE  B    
# 3     3 Sit2  FALSE C    
# 4     4 Sit2  FALSE B    
# 5     5 Sit3  TRUE  A
```

## Listas

Las listas son estructuras de datos primitivas. En teoría, los data frame y tibbles son estructuras internamente basadas en listas. En ellos, sus elementos son únicamente vectores de elementos que se comportan como columnas de las tablas cuando imprimidos el objeto. 

Las listas propiamente dichas, las que creamos con la función `list()`, son estructuras amigables, _almacenando prácticamente toda clase de objetos_: vectores, factores, matrices, data frames, tibbles, incluso otras listas.

Como se mencionó arriba, la función `list()` permite **crear listas no nombradas**. Cada elemento adquiere como nombre un número correlativo:


```r
# Creación de una lista no nombradas. Utilizaremos
# algunos objetos que hemos ido creando hasta aquí.
primeraLista <- list(TB, DF, vector1, F2)
primeraLista
# [[1]]
# # A tibble: 5 x 4
#    Col1 Col2  Log   Fct  
#   <int> <chr> <lgl> <fct>
# 1     1 Sit1  TRUE  A    
# 2     2 Sit1  TRUE  B    
# 3     3 Sit2  FALSE C    
# 4     4 Sit2  FALSE B    
# 5     5 Sit3  TRUE  A    
# 
# [[2]]
#   Col1 Col2   Log Fct
# 1    1 Sit1  TRUE   A
# 2    2 Sit1  TRUE   B
# 3    3 Sit2 FALSE   C
# 4    4 Sit2 FALSE   B
# 5    5 Sit3  TRUE   A
# 
# [[3]]
#  [1]  1  2  3  4  5  6  7  8  9 10
# 
# [[4]]
#  [1] A B A A A A B A C C B
# Levels: B C A
```

Para **crear una lista nombrada**, se puede colocar cada elemento precedido con un nombre y el símbolo igual.


```r
# Creación de una lista no nombradas. Utilizaremos
# algunos objetos que hemos ido creando hasta aquí.
L1 <- list(TB = TB, DF = DF, vecThor = vector1, factor = F2)
L1
# $TB
# # A tibble: 5 x 4
#    Col1 Col2  Log   Fct  
#   <int> <chr> <lgl> <fct>
# 1     1 Sit1  TRUE  A    
# 2     2 Sit1  TRUE  B    
# 3     3 Sit2  FALSE C    
# 4     4 Sit2  FALSE B    
# 5     5 Sit3  TRUE  A    
# 
# $DF
#   Col1 Col2   Log Fct
# 1    1 Sit1  TRUE   A
# 2    2 Sit1  TRUE   B
# 3    3 Sit2 FALSE   C
# 4    4 Sit2 FALSE   B
# 5    5 Sit3  TRUE   A
# 
# $vecThor
#  [1]  1  2  3  4  5  6  7  8  9 10
# 
# $factor
#  [1] A B A A A A B A C C B
# Levels: B C A
```

Resulta muy engorroso tener que colocar los nombres dado que las variables ya tienen uno, esto se puede solucionar si se usa la función `lst()` de la librería **dplyr**.


```r
L2 <- dplyr::lst(TB, DF, vector1, F2)
L2
# $TB
# # A tibble: 5 x 4
#    Col1 Col2  Log   Fct  
#   <int> <chr> <lgl> <fct>
# 1     1 Sit1  TRUE  A    
# 2     2 Sit1  TRUE  B    
# 3     3 Sit2  FALSE C    
# 4     4 Sit2  FALSE B    
# 5     5 Sit3  TRUE  A    
# 
# $DF
#   Col1 Col2   Log Fct
# 1    1 Sit1  TRUE   A
# 2    2 Sit1  TRUE   B
# 3    3 Sit2 FALSE   C
# 4    4 Sit2 FALSE   B
# 5    5 Sit3  TRUE   A
# 
# $vector1
#  [1]  1  2  3  4  5  6  7  8  9 10
# 
# $F2
#  [1] A B A A A A B A C C B
# Levels: B C A
```

Es más que seguro que en el futuro encontrarás ventajoso tener listas nombradas para el manejo de estructuras de datos.

## Coerción de variables

Existe la posibilidad de cambiar la naturaleza digital, es decir, la clase y/o estructura, de un objeto en R. Coercionar implica permitir que un objeto transforme su clase o estructura a otra diferente a la inicial, permitiendo flexibilizar el manejo de datos de una manera increíblemente sencilla. 

Para coercionar basta con usar las variables del grupo `as.---()`. Los tres guiones equivalen a un texto variable que le da la característica a cada función de dicho grupo. A continuación se muestran algunas de las funciones de coerción más importantes:


Table: (\#tab:unnamed-chunk-46)Principales funciones de coerción de clase de variable.

Función            Descripción                                                          
-----------------  ---------------------------------------------------------------------
`as.numeric()`     Cambia la naturaleza de un vector hacia clase numérica (decimales).  
`as.integer()`     Cambia la naturaleza de un vector hacia clase numérica (enteros).    
`as.character()`   Cambia la naturaleza de un vector hacia clase texto o carácter.      
`as.logical()`     Cambia la naturaleza de un vector hacia clase lógica (TRUE o FALSE). 



Table: (\#tab:unnamed-chunk-47)Principales funciones de coerción de estructura de variable.

Función                Descripción                                                              
---------------------  -------------------------------------------------------------------------
`as.vector()`          Coerciona un factor a vector.                                            
`as.factor()`          Coerciona un vector a factor.                                            
`as.matrix()`          Coerciona una estructura 2D cualquiera hacia matriz.                     
`as.data.frame()`      Coerciona una estructura 2D cualquiera hacia data frame.                 
`as.list()`            Coerciona una estructura N dimensional hacia una lista.                  
`dplyr::as_tibble()`   Coerciona una estructura 2D hacia Tibble (del entorno de **tidyverse**). 



Table: (\#tab:unnamed-chunk-48)Algunas funciones de coerción especiales.

Función             Descripción                                                                  
------------------  -----------------------------------------------------------------------------
`as.Date()`         Coerciona un texto o elemento numérico hacia fecha (formato calendario).     
`as.POSIXct()`      Coerciona un texto o elemento numérico hacia fecha UTC (formato calendario). 
`as.dengrogram()`   Coerciona un objeto de ordenamiento hcluster hacia dendrogram.               
`as.hclust()`       Coerciona un objeto de ordenamiento dendrogram hacia hcluster.               
`as.formula()`      Coerciona un texto hacia una fórmula estadística. Identico a `formula()`.    
`as.roman()`        Coerciona números enteros hacia números romanos.                             
`image()`           Coerciona una matriz numérica hacia una imagen raster.                       

## Ejercicios del capítulo

<div class="question">
  1. Crea una variable llamada `datosNumeros` que contenga 200 números (decimales) entre el 20 y 80. 
  1. Utilizando la función `sample()`, crea una variable llamada `niveles` que contenga el muestreo de 200 elementos (con repetición) 
  1. Coerciona hacia texto el objeto `datosNumeros`.
  1.</div>
