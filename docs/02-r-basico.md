# **R básico** {#rbasico}

Este capítulo se centra en el manejo y comprensión del lenguaje de programación R (en adelante: "R") en nivel introductorio. Se asume que el lector tiene instalados y configurados los programas R, RStudio y algún otro programa de soporte para el manejo de paquetes. Si no cuentas con ninguno en tu computadora, visita el capítulo [1 Esenciales de R y RStudio](#esencialesRRStudio).

Una ventaja de los lenguajes de programación es que permiten al usuario definir una secuencia de órdenes (comandos) adaptadas a los requerimientos analíticos que tenga. El flujo de trabajo completo, el paso a paso, queda escrito en el código. Este puede ser compartido con colegas en trabajos colaborativos. 

Antes de aprender sobre los métodos estadísticos de análisis que se revisarán en este libro, se necesita "hablar" correctamente el lenguaje R. Aprenderás a trabajar con el código básico en R, a crear variables para almacenar información, a crear funciones para agilizar el flujo de trabajo, a utilizar `tidyverse` para el manejo y limpieza de bases de datos, entre otros códigos útiles para inicar con R. 

## **Primer contacto con R**

La forma simplificada de cómo funciona R se resume en escribir una orden, presionar "algo" para que la computadora comience a procesar la orden, y luego recibir un resultado textual o gráfico. Básicamente lo que hace cualquier otro lenguaje de programación. 

No obstante, R es considerada una de los mejores lenguajes informáticos si nuestra orientación es más la investigación científica que el desarrollo informático. Otros lenguajes informáticos populares entre científicos son Python, MATLAB, C, C++, JavaScript, SQL, Scala, Julia, SAS, pero ninguno esta tan orientado al desarrollo estadístico como R.

(ref:vistprevRStudio) Ejemplo de uso de RStudio en el análisis estadístico.

<div class="figure" style="text-align: center">
<img src="figs/screenshots/tema BrackInstitute.png" alt="(ref:vistprevRStudio)" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-1)(ref:vistprevRStudio)</p>
</div>
<br>

R es considerada como una _calculadora con esteroides_ dado que puedes aplicar matemáticas con él; aquella ciencia sobre la que se cimentan casi todas las demás. Si puedes hacer ello, tienes las puertas abiertas a aplicar análisis estadísticos, generar gráficos y todo lo que te imagines. Y pues sí, también hay cosas algo bizarras en R, como poder crear tu propio [calendario](https://r-coder.com/calendarios-r/) o usar [gatitos](https://github.com/R-CoderDotCom/ggcats) en un gráfico de dispersión de puntos.

A diferencia de los lenguajes humanos (idiomas), un lenguaje de programación debe estar escrito a la perfección. No hay espacio para una coma mal puesta, un paréntesis olvidado, o un nombre errado. La computadora solo ejecutará la orden si todo está escrito exactamente, tal y como debe ser. Todos los ejemplos de este libro pueden ser ejecutados correctamente si se escriben como es mostrado, y si instalaste todo lo necesario para trabajar (revisa las secciones [Prerrequisitos](#prerrequisitos) y [1 Esenciales de R y RStudio](#esencialesRRStudio). 

## **Ejecutar código**

¿Alguna vez hiciste un histograma de frecuencias?. Hacer uno de manera exploratoria es muy sencillo en R. El siguiente código hará dos cosas en un solo paso: 

1. Creará un conjunto de 10,000 datos aleatorios que siguen en la distribución normal.
2. Generará el gráfico del histograma de frecuencias utilizando el conjunto previamente creado. 

Por ahora no se ahondará en el detalle de qué cosa es `rnorm()` o `hist()`.


```r
hist(rnorm(10000))
```

<img src="02-r-basico_files/figure-html/unnamed-chunk-2-1.png" width="100%" style="display: block; margin: auto;" />

Para replicarlo, es necesario escribir el código exacto, para luego dar la orden, es decir, ejecutar el código. La ejecución se hace presionando en el teclado de tu computador `control + enter` o `command + enter` (usuarios macOS).

\BeginKnitrBlock{rmdnote}<div class="rmdnote">Existen otros atajos de teclado para ejecuciones especiales.

- Ejecutar todas las líneas de código del script: `control (o command) + shift + enter`.
- Ejecutar desde el inicio del script hasta la línea actual: `control (o command) + Alt + B`.
- Ejecutar desde la línea actual hasta el final del script: `control (o command) + Alt + E`.

No obstante, no son necesarias. Es suficiente con conocer la ejecución básica, dado que para **ejecutar varias líneas de código a la vez** solo se deben seleccionar las requeridas y ejecutar con  `control + enter` o `command + enter`.</div>\EndKnitrBlock{rmdnote}

Una pregunta que siempre genera confusión es la presencia de unos corchetes `[1]` en los resultados vistos tanto en consola como en este libro. Esto no es parte de un resultado por si mismo, es la posición del elemento mostrado justo a la derecha del corchete. 

Si se ejecuta el símbolo `:` entre dos números, R generará el rango de valores enteros entre dichos números, incluyéndolos.


```r
1:100
##   [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19
##  [20]  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38
##  [39]  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57
##  [58]  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76
##  [77]  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95
##  [96]  96  97  98  99 100
```

El resultado muestra los confusos `[]` a la izquierda del primer elemento de cada fila del conjunto de datos resultante, indicando su posición dentro de la secuencia de elementos.

## **Operaciones aritméticas**

Como ya se había mencionado antes, R nos permite operar con código. La cosa más sencilla para hacer en R es sumar. 


```r
10 + 10
## [1] 20
```


\BeginKnitrBlock{rstudio-tip}<div class="rstudio-tip">En adelante se visualizará tanto el código a ejecutar (primera línea del ejemplo de suma aquí propuesto) como su resultado textual, mismo que obtendrás en la consola de RStudio (segunda línea del ejemplo) si sigues los pasos de cada ejemplo o ejercicio.</div>\EndKnitrBlock{rstudio-tip}

<br>


Table: (\#tab:unnamed-chunk-7)Operaciones (símbolos) aritméticas en R

Operador   Operación                                 Ejemplo        Resultado
---------  ----------------------------------------  ------------  ----------
`+`        Suma                                      `10 + 3`          13.000
`-`        Resta                                     `10 -  3`          7.000
`*`        Multiplicación                            `10 * 3`          30.000
`/`        División                                  `10 / 3 `          3.333
`^`        Potencia                                  `10 ^ 3 `       1000.000
`%/%`      División entera (parte entera)            `10 %% 3 `         3.000
`%%`       Residuo de dividir un número entre otro   `10 %/% 3 `        1.000

## **Funciones matemáticas**

Operaciones más complejas necesitan el uso de **funciones**. Estas son "secuencias de ordenes empaquetadas con un nombre pequeño y recordable" — la información sobre las funciones será desarrollada más adelante ([sección 2.2](#funciones)). En la siguiente tabla se presentan las funciones matemáticas más comunes en R: 


Table: (\#tab:unnamed-chunk-8)Operaciones matemáticas en R. Estos procedimientos matemáticos vienen predefinidos como ordenes denominadas "Funciones"

Operador      Operación                   Ejemplo         Resultado
------------  --------------------------  -------------  ----------
`exp(n)`      Eleva e a la n              `exp(3)`           20.086
`sqrt(n)`     Raíz cuadrada de n          `sqrt(3)`           1.732
`log(n)`      Logaritmo natural de n      `log(3)`            1.099
`log(n, b)`   Logaritmo de n en base b    `log(3, 10)`        0.477
`log10(n)`    Logaritmo de n en base 10   `log10(3)`          0.477
`log1p(n)`    Logaritmo natural de n +1   `log1p(2)`          1.099
`log2(n)`     Logaritmo en base 2         `log2(10)`          3.322
`pi`          Número pi                   `pi`                3.142
`abs(n)`      Convierte n en absoluto     `abs(-10.2)`       10.200

## **Comentar el código**

Una forma de asegurar que en el futuro el código escrito sea entendible, incluso por nosotros mismos, es comentándolo. Dejar comentarios nos ayudará a recordar la intención con la que se escribió una sección determinada de los comandos.

Para comentar en R, se requiere colocar el símbolo `#` a la izquierda del texto a ser considerado comentario. 


```r
# Esta es una suma 
2 + 2 
## [1] 4

10 * 2 # + 3029
## [1] 20
```

Como queda en evidencia, no importa si el comentario está en solitario en una línea de código, o si está a la derecha de algo que sí se quiere ejecutar. Esto no afecta el resultado de la operación.

## **Creación de variables**

Las variables son espacios virtuales, que puede contener de elementos o estar vacíos. Imagina que en una tabla de datos es un objeto "contenedor de mediciones" de un trabajo de investigación. Dicha tabla puede ser considerada una variable u objeto en R. Más adelante se hablará sobre los tipos de variables que existen en R.

Una forma sencilla de comenzar con variables es guardar un valor numérica en la memoria de trabajo de RStudio, también llamado ambiente (pestaña _Environment_). En este sentido, se necesita _asignar_ el contenido a un nombre para que RStudio lo "recuerde", haciendo uso de un **operador de asignación** `<-`. Para crear una variable llamada NUM conteniendo el número 2022.


```r
NUM <- 2022
```

Si se desea **ver el contenido de una variable** previamente guardada en el ambiente, basta con ejecutar el nombre d ela variable:


```r
NUM
## [1] 2022
```

o usar la función `print()` para imprimirla en la consola:


```r
print(NUM)
## [1] 2022
```

Una versión frecuentemente usada en ejemplos de R, involucra **colocar a la asignación entre paréntesis** para que hacer dos cosas a la vez: guardar la variable en el ambiente y mostrar su contenido en la consola.


```r
(NUM <- 2022)
## [1] 2022
```

Existe la posibilidad de asignar con un **operador de asignación inverso** `->`. Toma en cuenta qué debe ir en la cola (contenido) y en la cabeza (nombre) del operador. En otras palabras, la "flecha" que se forma con este operador siempre apunta al futuro nombre de la variable. Recuerda, la variable no existe hasta que no se ejecute y aparezca dicho nombre en el ambiente de RStudio.


```r
# Operador de asignación inverso
2022 -> NUM
```

El símbolo `=` también funciona, pero, por convención, este **no se debe usar para crear variables**. Se usará dentro de las funciones para "asignar" contenido a los argumentos de las mismas (se explicará a continuación).


```r
# Mal uso del símbolo =
NUM = 2022

# Buen uso del símbolo = : siempre dentro de una función.
# Calcular el logaritmo en base 2 de 10
bs <- 2 + 8
log(10, base = bs)
## [1] 1
```


\BeginKnitrBlock{rstudio-tip}<div class="rstudio-tip">Ciertamente, en el ejemplo anterior no fue esencial guardar la variable `bs` en el ambiente para su uso posterior dentro de `log()`. Sabemos de antemano que la suma es `10`. No obstante, este ejemplo nos da idea de como aplicar el guardar un resultado para usarlo luego en ejercicios más complejos.</div>\EndKnitrBlock{rstudio-tip}

No es posible continuar hablando de variables sin antes hacer una introducción a las funciones en R. 

## **Funciones** {#funciones}

Se puede idealizar una función como una secuencia de órdenes (líneas de código) que tienen como objetivo aplicarle un procedimiento (gráfico, estadístico, de modificación o transformación, entre otros) a un objeto de entrada (input) para generar un resultado (ouput). Dichas líneas de código están empaquetadas y almacenadas con un nombre. 

Reconocer una función en R es tarea sencilla, siempre será un **nombre seguido de paréntesis**. Por ejemplo, la función para calcular la desviación estándar de un conjunto de datos es `sd()`, que proviene del inglés _standard deviation_. Dentro de los paréntesis se deben colocar los **argumentos** de la función. El argumento más sencillo que algunas funciones necesitan es un conjunto de datos, y es justamente lo único que necesita `sd()`.


```r
# Para crear un conjunto de datos en R se usa la función c()
x <- c(7,9,3,4,5,3,7,8)

# Usando sd() para hallar la desviación estándar de x
sd(x)
## [1] 2.315
```

Si se ejecuta únicamente el nombre de una función existente en RStudio, en la consola se mostrará el contenido de la misma, la secuencia de órdenes que le dan forma a la función. Ejecuta el `sd` para ver su contenido:


```r
sd
## function (x, na.rm = FALSE) 
## sqrt(var(if (is.vector(x) || is.factor(x)) x else as.double(x), 
##     na.rm = na.rm))
## <bytecode: 0x0000000030f415c8>
## <environment: namespace:stats>
```

La secuencia de órdenes dentro de `sd` es corta. Básicamente utiliza la función `sqrt()` para sacarle la raíz cuadrada a la función `var()`, esta última calcula la varianza de un conjunto de datos. La estructura del código es propiamente la fórmula matemática para el cálculo de la desviación estándar. Aunque, a decir verdades, el código luce más complejo, y es debido a que aquí la función `var()` contiene argumentos condicionales para pedir que evalúe si el objeto `x` es correcto para la función, o si se necesita un cambio antes de procesar`x` en `sd()`. Pierde cuidado si no se entiende mucho por ahora, no es necesario comprender las funciones a este nivel al iniciar con R.

### **Creación de funciones** {#creacion-fun}

La gran comunidad de desarrollo detrás de R ha creado una infinidad de funciones, almacenados en los miles de paquetes, o librerías, disponibles en el repositorio oficial `CRAN` y otras fuentes (ver sección [Librerías y repositorios](#librerías-y-repositorios). No obstante, algunas veces se necesita crear funciones personalizadas a los requerimientos del usuario. 

Cuando se detecta que algunas secuencias de órdenes se suelen repetir en el código, crear una función que empaquete dicha secuencia permitirá
_automatizar procedimientos y simplificar el código_. Como regla general, si copias y pegas una secuencia de órdenes para usarla más de 2 veces, ya se debería pensar en crear una función que compile la tarea. 

\BeginKnitrBlock{rmdnote}<div class="rmdnote">**Crear un función involucra los siguientes pasos:**

1. Darle un nombre. Crear una función es como crear una variable: hay que asignarle un contenido a un nombre.
2. Luego de escribir el nombre, se tiene que usar la función llamada `function()`para indicar qué argumentos tendrá la nueva función.
3. Definir el contenido de la función, la secuencia de órdenes, dentro de corchetes. Dentro de ellos se usarán los argumentos establecidos en `function()`.</div>\EndKnitrBlock{rmdnote}

Para **crear una función** que le sume 100 a un número, se puede usar:


```r
# Esta función admitirá como objeto de entrada un 
# valor x, definido en function(), para sumarle 100
mi.fun <- function(x){
  x+100
}

# Usando mi.fun() con 10
mi.fun(10)
## [1] 110
```

Para recrear la famosa función de [Carl Friedrich Gauss](https://es.wikipedia.org/wiki/Carl_Friedrich_Gauss) para calcular la suma de todos los números dentro de un rango numérico, usaremos la fórmula matemática:

$$ k = \frac{n * ( n + 1 )}{2} $$


```r
k.Gauss <- function(n) {
  (n * (n+1))/2
}

k.Gauss(100)
## [1] 5050
```

Adicionalmente, se puede **predefinir valores por defecto** en `function()`, mismos que se podrán modificar al usar la función ya creada.


```r
# Esta función hallará el logaritmo con base 2 
# (por defecto) de la función matemática de Gauss
log.Gauss <- function(n, base = 2) {
  resultado.Gauss <- (n * (n+1))/2
  logaritmo <- log(resultado.Gauss, base=base)
  print(logaritmo)
}

# Aplicando la función al valor 100
log.Gauss(100)
## [1] 12.3
```

Como es notorio, se pueden **crear variables dentro de una función**, pero estas serán temporales. Una vez se imprime el resultado en consola, la variable desaparece. Para que algún paso realizado dentro de la función se guarde como una variable permanentemente en el ambiente, usa el símbolo especial `<<-`.


```r
# Se guardará resultado.Gauss en la consola
log.Gauss <- function(n, base = 2) {
  resultado.Gauss <<- (n * (n+1))/2
  logaritmo <- log(resultado.Gauss, base=base)
  print(logaritmo)
}

# Aplicando la función al valor 100
log.Gauss(100)
## [1] 12.3

# Mostrando el objeto que se creó automáticamente
# en el ambiente tras ejecutar log.Gauss()
print(resultado.Gauss)
## [1] 5050
```

## **Clasificación de variables**

Toda variable cuenta con dos atributos: clase y estructura. Para entender cómo se almacenan los datos en R, se necesita conocerlas a detalle.

(ref:gatocaja) Analogía del gato en la caja para entender a las variables. Aquí, el gato es el contenido; la caja, la estructura. Esta "variable" puede ser de la clase "contenedora de gatos" y estructura "cartón". Así mismo, habrán variables contenedoras de números, de caracteres, de valores lógicos, y estos estarán ordenados de diferente manera.  

<div class="figure" style="text-align: center">
<img src="figs/fotografias/gatobox.jpg" alt="(ref:gatocaja)" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-24)(ref:gatocaja)</p>
</div>
<br>


### **Clases atómicas**

Según su contenido, en R existen **seis clases básicas (o atómicas) de variables**:

- Clase **lógica:** identificado con el nombre `logical`
- Clase **caracter o texto:** identificado con el nombre `character`
- Clase **número con decimales:** conocidos como _doubles_, identificado con el nombre `numeric`
- Clase **número entero:** identificado con el nombre `integer`
- Clase **número complejo:** identificado con el nombre `complex`
- Clase **crudo o en bits:** identificado con el nombre `raw`

De estos, los últimos tres no serán utilizando a lo largo de este libro. Quizá surja la pregunta de por qué no usar números enteros. En realidad una variable del tipo `numeric` ya incluye enteros y con decimales (es decir, todos los números reales). Para efectos de una gran cantidad de funciones estadísticas, en R no es relevante brindarle números enteros como `integer`, o diferenciarlos de `numeric`.

### **Estructuras de datos** 

Según su estructura, las variables pueden tener una forma de almacenamiento con diferente dimensionalidad. 

- La estructura más básica de R es el **vector**, con una sola dimensión. 
- El vector se convierte en un **factor** si es que contiene información categorizada, y sigue teniendo una dimensión. 
- Si vectores se colocan verticalmente, y se apilan lado a lado, se convierten en una estructura de dos dimensiones. Dependiendo de sus características estas pueden ser: 
**matrices**, **data frames** o **tibbles**.
- Se puede considerar a los **arrays** como arreglos multidimensionales de vectores.
- Finalmente, las _listas_ son estructuras de datos básicas. No se consideran dimensionales dado que almacena a otras estructuras de datos secuencialmente. Una lista puede albergar vectores, factores, matrices, data frames, tibbles, arrays, incluso otras listas.

(ref:strdatos1) Estructuras informáticas para almacenar de datos en el lenguaje R.

<div class="figure" style="text-align: center">
<img src="figs/elaboradas/Estructuras de datos en R.png" alt="(ref:strdatos1)" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-25)(ref:strdatos1)</p>
</div>

## **Vectores**

R es un lenguaje basado en vectores. La estructura de almacenamiento de datos más básica es el vector. Un vector contiene elementos, que pueden ser números, textos, valores lógicos, y de cualquier clase atómica. No obstante, solamente puede almacenar elementos de una única clase atómica a la vez. Solo números, solo texto, solo valores lógicos.

Para crear un vector, se utiliza la función `c()` donde especifíco los elementos directamente:


```r
# Vector numérico
numeros <- c(1,2,3,4,5,6)
numeros
## [1] 1 2 3 4 5 6
```

Un operador de gran utilidad es `:` que permite crear rangos de números enteros.


```r
1:6
## [1] 1 2 3 4 5 6
```

Además de `c()`, existe la función `vector()` para crear vectores vacíos de una longitud y clase atómica determinado.


```r
# Vector lógico de longitud (length) 10
vLog <- vector("logical", length=10)
vLog
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE

# Vector de caracteres de longitud (length) 15
vCha <- vector("character", length=15)
vCha
##  [1] "" "" "" "" "" "" "" "" "" "" "" "" "" "" ""

# Vector de números de longitud (length) 20
vNum <- vector("numeric", length=20)
vNum
##  [1] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
```

La razón para usar `vector()` es para crear un _contenedo_ vacío de una longitud determinada, el cual podremos ir llenando con los resultados de un loop. Nos adelantaremos un poco con el código un tanto más avanzado, pero verás el uso de esta función.


```r
vNum <- vector("numeric", length=6)
vNum
## [1] 0 0 0 0 0 0

# Loop donde a una secuencia de números del 1 al 6
# se le multiplica a cada uno por 100
for (i in 1:6){
  vNum[i] <- i * 100
}

# Vector ya rellenado por el loop
vNum
## [1] 100 200 300 400 500 600
```

Otras formas especiales de crear vectores implica el uso de `seq()` para crear secuencias numéricas, o `rep()` para repetir de algún valor una determinada cantidad de veces.

Para crear una secuencia del 10 al 100 cada 5 elementos, se usa el argument `by =` dentro de `seq()`


```r
seq(10, 100, by=5)
##  [1]  10  15  20  25  30  35  40  45  50  55  60  65  70  75  80  85  90  95 100
```

Para crear una secuencia del 36 números entre 10 y 100, se usa el argument `length =` dentro de `seq()`


```r
seq(10, 100, length=36)
##  [1]  10.00  12.57  15.14  17.71  20.29  22.86  25.43  28.00  30.57  33.14  35.71
## [12]  38.29  40.86  43.43  46.00  48.57  51.14  53.71  56.29  58.86  61.43  64.00
## [23]  66.57  69.14  71.71  74.29  76.86  79.43  82.00  84.57  87.14  89.71  92.29
## [34]  94.86  97.43 100.00
```

Las repeticiones implica definir dos argumentos: lo que se repetirá, y la cantidad de veces. Para repetir el carácter `América` 10 veces, se usa:


```r
rep("América", 10)
##  [1] "América" "América" "América" "América" "América" "América" "América" "América"
##  [9] "América" "América"
```

## **Factores**

Los factores son tipos especiales de vectores, donde R evalúa los valores únicos de la secuencia y los define como categorías. Son muy útiles en programación dado que nos permiten graficar, por ejemplo, con un color diferenciado cada nivel de una variable categorica. Imagina que se requiere hacer un gráfico de dispersión de puntos para ver la relación entre dos variables, pero permitiendo que el color de los puntos refleje el grupo al que pertenece cada observación:

(ref:factoresEjemplo) Ejemplo de uso del conjunto de datos _Grupos_ para colorear los puntos del gráfico de enfrentamiento de las variables _Pétalo_ y _Sépalo_.

<div class="figure" style="text-align: center">
<img src="02-r-basico_files/figure-html/unnamed-chunk-33-1.png" alt="(ref:factoresEjemplo)" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-33)(ref:factoresEjemplo)</p>
</div>

Para crear un factor se utiliza la función `factor()`, y un vector dentro de ella. La función evaluará los valores únicos del vector y definirá los niveles del factor:


```r
# Crear un vector de texto cualquiera 
vectorC <- c("A","B","A","A","A","A","B","A","C","C","B")

# Crear un vector de texto cualquiera
vectorN <- c(1,1,2,1,2,2,1,1,2,1,2,1,2,2,2,1)

# Crear factores en base a los vectores
factor(vectorC)
##  [1] A B A A A A B A C C B
## Levels: A B C
factor(vectorN)
##  [1] 1 1 2 1 2 2 1 1 2 1 2 1 2 2 2 1
## Levels: 1 2
```

Cada factor muestra sus niveles (Levels) al final de la secuencia. Se puede conocer cuales son los niveles de un factor guardado en el ambiente, utilizando la función `levels()`:


```r
# Guardar el factor
F1 <- factor(vectorC)

# Revisar los niveles del factor
levels(F1)
## [1] "A" "B" "C"
```

El orden de los niveles es importante. Por defecto se ordenan los niveles de menor a mayor (si son números), o de la A a la Z (sin son texto). Para una regresión, para un gráfico, el orden afecta los resultados. En una regresión lineal, el primer nivel de un factor puede ser considerado como _nivel base_, y las interpretaciones se harán como factores de aumento o disminución de los otros niveles respecto al nivel base. En un gráfico, el orden de los colores, o las etiquetas de un eje, seguirán este orden. 

Para cambiar el orden, las alternativas son variadas. Si solo se desea definir un nivel base, y el orden de los demás niveles no es importante, se usa `relevel()` con el segundo argumento especificando el nivel que será el nuevo nivel base.


```r
# Especificando el primer nivel como "C" 
F1_cambiado <- relevel(F1, "C")
F1_cambiado
##  [1] A B A A A A B A C C B
## Levels: C A B
```

Si se necesita especificar un orden definido manualmente para todos los niveles, es mejor definirlo al momento de crear el factor, usando el argumento `levels=`:


```r
# Crear un factor con niveles ordenados manualmente
F2 <- factor(vectorC, levels=c("B","C","A"))

# Revisar los niveles de F2
levels(F2)
## [1] "B" "C" "A"
```

Por otro lado, si hay necesidad de cambiar el nombre de algún (o algunos) nivel(es), se puede usar un vector con los cambios deseados como contenido del argumento `labels=`. El orden de las etiquetas cambiadas debe seguir el mismo orden original de los niveles:


```r
# Crear un factor con cambie de etiqueta
F3 <- factor(F1, labels=c("Absoluto", "B", "Cambio"))

# Revisar los niveles de F3
levels(F3)
## [1] "Absoluto" "B"        "Cambio"

# Revisando el contenido original (sin cambios) en F1
F1
##  [1] A B A A A A B A C C B
## Levels: A B C

# Revisar el contenido de F3
F3
##  [1] Absoluto B        Absoluto Absoluto Absoluto Absoluto B        Absoluto
##  [9] Cambio   Cambio   B       
## Levels: Absoluto B Cambio
```

Como fue evidente, al crear un factor se puede usar como insumo un vector, como `vectorN`, u otro factor previamente creado, como `F1`.

## **Matrices**

Las matrices son la primera estructura de dos dimensiones aquí presentada. Son útiles cuando se desee aplicar álgebra de matrices. Pero en el día a día, son rudimentarias y limitantes. Sobre esto último, se comporta como un vector: permiten almacenar solamente un tipo de elemento en toda la tabla.

Para crear una matriz, podemos tomar un vector e ir ordenando los elementos de manera vertical u horizontal en una tabla de $n*p$ dimensiones (donde: $n$ es la cantidad de filas y $p$ de columnas), utilizando la función `matrix()`.


```r
# Crear un rango de valores cualquiera
vector1<-1:10
```

Al encajar el contenido del vector de longitud $n$ en forma de matriz (dos dimensiones) sin especificar la cantidad de columnas o filas, crea una matriz de una sola columna con $n$ filas.


```r
matrix(vector1)
##       [,1]
##  [1,]    1
##  [2,]    2
##  [3,]    3
##  [4,]    4
##  [5,]    5
##  [6,]    6
##  [7,]    7
##  [8,]    8
##  [9,]    9
## [10,]   10
```

Para definir la cantidad de columnas y filas se usan los argumentos `ncol=` y `nrow=`, respectivamente:


```r
matrix(vector1, ncol=2, nrow=5)
##      [,1] [,2]
## [1,]    1    6
## [2,]    2    7
## [3,]    3    8
## [4,]    4    9
## [5,]    5   10
```

Por defecto las columnas se llenan _columna por columna_. Para cambiar el comportamiento de llenado a _fila por fila_, se usa:


```r
matrix(vector1, ncol=2, nrow=5, byrow=TRUE)
##      [,1] [,2]
## [1,]    1    2
## [2,]    3    4
## [3,]    5    6
## [4,]    7    8
## [5,]    9   10
```

En este libro no se hace uso extenso de matrices, por lo que no es necesario conocerlas a mayor detalle.

## **Data Frames**

Esta estructura de datos de dos dimensiones es la más parecida a lo que una hoja de cálculo permite: colocar diferentes tipos de elementos dentro de la tabla, como texto, números, elementos lógicos, entre otros. Al cargar en RStudio una base de datos de un estudio, esta se almacenará como data frame casi siempre (cuando no, podrá ser un tibble o una lista).

Para crear data frames manualmente en R, se utiliza la función `data.frame()`, especificando como elementos el contenido de cada columna.


```r
DF <- data.frame(Col1 = 1:5, 
                 Col2 = c("Sit1","Sit1","Sit2","Sit2","Sit3"),
                 Log = c(T,T,F,F,T),
                 Fct = factor(c("A","B","C","B","A")))

DF
##   Col1 Col2   Log Fct
## 1    1 Sit1  TRUE   A
## 2    2 Sit1  TRUE   B
## 3    3 Sit2 FALSE   C
## 4    4 Sit2 FALSE   B
## 5    5 Sit3  TRUE   A
```

Cargar una base de datos de un archivo como data frame en R, dependerá del tipo de archivo

Para cargar un excel, se recomienda usar




## **Tibbles**


## **Listas**



## **Indexación de variables**

### **Indexación en variables 1D**

### **Indexación en variables 2D**

### **Indexación en listas**


## **Coerción de variables**


