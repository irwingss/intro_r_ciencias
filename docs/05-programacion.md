# **Programación funcional**

R, en esencia, es un lenguaje de programación funcional. En R existen muchas herramientas y facilidades para la creación de funciones. Es posible hacer prácticamente de todo con funciones: crear nuevas variables, automatizar resultados de una secuencia de pasos de código usada frecuentemente, crear funciones dentro de funciones para automatizar procesos, por mencionar algunas posibilidades. En este capítulo, se comenzará describiendo la creación de funciones básicas para resolver problemas sencillos, se revisará el uso de operadores de control de flujo (`for`, `if`, `else`, `while`), y finalmente se utilizarán ambos conceptos para aplicaciones más avanzadas de programación con R.

Estos tópicos son considerados por muchos autores como el una introducción a R Avanzado, donde se explota al máximo el pensamiento funcional para aplicarlo en análisis de datos. Siéntete libre de revisar repetidamente el siguiente contenido porque será de muchísima utilidad en tu desarrollo como investigador usuario de R.

(ref:programming1) Ejemplo sencillo del uso de programación funcional con loops (ciclos o iteraciones repetidas *i* veces) para obtener un resultado.

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{figs/screenshots/programming} 

}

\caption{(ref:programming1)}(\#fig:figura48)
\end{figure}

## Creación de funciones {#creacion-fun}

La gran comunidad de desarrollo detrás de R ha creado una infinidad de funciones, almacenadas en los miles de paquetes (o librerías), disponibles en el repositorio oficial `CRAN`, así como en repositorios secundarios (ver sección [1.6 Librerías y repositorios](#librerías-y-repositorios)). Es casi seguro que más adelante te será útil crear funciones con las que suplir alguna necesidad en el análisis de datos. Cuando se detecta que algunas secuencias de órdenes se suelen repetir, crear una función que empaquete dicha secuencia permitirá *automatizar procedimientos y simplificar el código*. Como regla general, si copias y pegas una secuencia de órdenes para usarla más de 2 veces, ya se debería pensar en crear una función que compile la tarea. 

\BeginKnitrBlock{rmdnote}
**Crear un función involucra los siguientes pasos:**

1. Darle un nombre. Crear una función es como crear una variable: hay que asignarle un contenido a un nombre.
2. Luego de escribir el nombre, se tiene que usar la función llamada `function()`para indicar qué argumentos tendrá la nueva función.
3. Definir el contenido de la función, la secuencia de órdenes, dentro de corchetes. Dentro de ellos se usarán los argumentos establecidos en `function()`.
\EndKnitrBlock{rmdnote}

### Ejemplo simple

::: {.example}
Comenzando con ejemplo muy simple, se creará una función que le sume 100 a un número dado:


```r
### Modo 1: 
### Crear la función con corchetes
mi.fun1 <- function(x){
  x+100
}

### Modo 2:
### Cuando el contenido de una función es muy sencillo,
### el contenido puede ir sin llaves y en una sola línea:
mi.fun2 <- function(x) x+100

### Ambas funciones brindan el mismo resultado
mi.fun1(156)
# [1] 256
mi.fun2(156)
# [1] 256
```
::: 

### Función de Gauss

::: {.example}

Recrear la famosa función de [Carl Friedrich Gauss](https://es.wikipedia.org/wiki/Carl_Friedrich_Gauss) para calcular la suma de todos los números dentro de un rango numérico, implicar tomar su fórmula matemática:

$$ k = \frac{n * ( n + 1 )}{2} $$

y convertirla en código funcional:


```r
### Crear la función
k.Gauss <- function(n) {
  (n * (n+1))/2
}

### Usar la función
k.Gauss(100)
# [1] 5050
```
:::

### Variables y valores por defecto

Esa letra o palabra que se ha colocado dentro de la función `function()` recibe el nombre de variable de la función. Hasta aquí se definió una única variable dentro de cada función: `x` para `mi.fun1()` y `mi.fun2()`, o `n` para `k.Gaus()`. Pero se puede colocar más de una, e incluso definir valores por defecto en `function()`, mismos que se podrán modificar al usar la función ya creada. 

::: {.example}
La siguiente función permitirá hallar el logaritmo en base 2 (definido por defecto) de la función matemática de Gauss, pero podrás modificar el valor cuando quieras posteriormente:


```r
### Crear la función
log.Gauss <- function(n, base = 2) {
  resultado.Gauss <- (n * (n+1))/2
  logaritmo <- log(resultado.Gauss, base=base)
  return(logaritmo)
}

### Usar la función
log.Gauss(100)
# [1] 12.3

### Cambiando la base del logaritmo
log.Gauss(100, base = 10)
# [1] 3.703

### En casos como estos, donde la posición
### de un argumento es única, puedes obviar
### el nombre del mismo (base)
log.Gauss(100, 10)
# [1] 3.703
```
:::

### Almacenar variables directamente en el ambiente

Como es evidente en el ejemplo anterior, se pueden crear variables dentro de una función utilizando el operador `<-`, pero estas son de carácter temporal. Una vez se imprime el resultado en consola, la variable temporal desaparece. Para que algún paso realizado dentro de una función se guarde como un objeto permanentemente en el ambiente, usa el símbolo especial `<<-`. 

::: {.example}
En el siguiente ejemplo permitiremos que un paso de la función `log.Gauss()` se guarde en el ambiente:


```r
### Crear la función con guardado especial
log.Gauss <- function(n, base = 2) {
  resultado.Gauss <<- (n * (n+1))/2   # Este objeto se guardará
  logaritmo <- log(resultado.Gauss, base=base)
  print(logaritmo)
}

### Usar la función
log.Gauss(100, base = 5)
# [1] 5.298

### Mostrar el objeto resultado.Gauss que se creó 
### automáticamente tras ejecutar log.Gauss()
print(resultado.Gauss)
# [1] 5050
```
:::

## Control de flujo

En R existen algunos operadores para controlar el flujo de las acciones a tomar en la ejecución. Esto sucede solamente cuando se cumple una condición dada. Recordemos que las condiciones lógicas se resuelven como verdadera `TRUE` o falsa `FALSE`. Existen operadores de elección (`if`, `else`) y de iteración o *loop* (`for`,  `while`). Se revisará a detalle sus usos en las siguientes secciones.

(ref:control1) Diagramas de flujo para comprender cómo funcionan las principales estructuras de control de flujo en  programación con R.

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{figs/elaboradas/Contro de Flujo en R} 

}

\caption{(ref:control1)}(\#fig:figura65)
\end{figure}


### Control con `if`

El primer operador de control de flujo a destacar es el condicional `if`. Este significa `si`, y ejecuta la expresión: *si A se cumple (es decir, si A es `TRUE`), muestro un resultado*. Este tienen la estructura básica:


```r
if (condición) acción_si_la_condición_es_verdadera
```

::: {.example}
Para poner en contexto lo anterior:


```r
### Crear una condición verdadera
condicion <- TRUE

if(condicion) 1
# [1] 1
```

En este sentido,`if` mostrará como *resultado* lo que esté a la derecha del paréntesis de condición, siempre y cuando la condición sea verdadera. Cuando la condición es falsa, no muestra resultado alguno:


```r
### Crear una condición falsa
condicion <- FALSE

if (condicion) 1
```
:::

::: {.example}
En la siguiente expresión, reemplazaremos la condición `TRUE` por una condición real con un vector llamado `num`. Se hará la pregunta lógica ¿es el objeto `num` *numeric*?. El resultado será un texto indicando que `num` *es un número* siempre que la condición sea verdadera.


```r
### Cuando num es un número
num <- 123

if (is.numeric(num)) paste(num, "es un número")
# [1] "123 es un número"

### Cuando num no es un número
num <- "Andes Tropicales"

if (is.numeric(num)) paste(num, "es un número")
```
:::

En el ejemplo con `"Andes Tropicales"`, la condición no fue verdadera, `if` no mostró resultado alguno en consola. 

### Control completo con `if` y `else`

El segundo operador de control que uno debe conocer es `else`. Este significa `entonces`, y suele colocarse acompañando a `if` para completar la condición universal: *si A se cumple, muestro un resultado; si A no se cumple, entonces muestro otro resultado*. Utilizando ambis, se obtiene tienen la estructura básica:


```r
if (condición) acción_si_la_condición_es_verdadera else acción_si_la_condición_es_falsa
```

::: {.example} 
Poniendo en contexto lo mencionado:


```r
### Usar if y else con una condición lógica
condicion <- TRUE

if (condicion) 1 else 0
# [1] 1

### Usar if y else con una condición lógica
condicion <- FALSE

if (condicion) 1 else 0
# [1] 0
```

Es más frecuente **utilizar llaves** `{}` para definir el *resultado* de `if` o el *otro resultado* de `else`:


```r
### Usar if y else con una condición lógica
condicion <- TRUE

if (condicion) {1} else {0}
# [1] 1

### Usar if y else con una condición lógica
condicion <- FALSE

if (condicion) {1} else {0}
# [1] 0
```

Para **escribir un código con varias líneas** de `if` y `else`, es necesario respetar el sangrado (espacio desde el borde), siendo que `else` se muestre sangrado dentro de la cadena de código iniciada con `if`.


```r
### Código de if y else en varias líneas
condicion <- FALSE

if (condicion) {
  1
  } else {
    0}
# [1] 0
```
:::

::: {.example}
Veamos una aplicación más completa de todo lo discutido hasta el momento:


```r
### Cuando num es un número
num <- 123

if (is.numeric(num)) {
  paste(num, "es un número")
  } else {
  paste(num, "no es un número")
    }
# [1] "123 es un número"

### Cuando num no es un número
num <- "Andes Tropicales"

if (is.numeric(num)) {
  paste(num, "es un número")
  } else {
    paste(num, "no es un número")
    }
# [1] "Andes Tropicales no es un número"
```
::: 

::: {.example}
A continuación varias aplicaciones para identificar si un valor numérico es par o impar, para identificar si un valor es NA, y para identificar si un valor es del tipo carácter o texto:


```r
### Con valor numérico para identificar par o impar
valor <- 120

if((valor %% 2) == 0) {
  print(paste(valor,"es par"))
  } else if ((valor %% 2) != 0) {
    print(paste(valor,"es impar")) 
    }
# [1] "120 es par"

### Con valor NA para identificar si es NA o un texto
valor <- NA

if (is.na(valor)) {
      print(paste(valor, "es un valor perdido"))
    } else {
      print(paste(valor, "no es un valor perdido, debe ser un texto"))
    }
# [1] "NA es un valor perdido"

### Con valor NA para identificar si es NA o un texto
valor <- "América"

if (is.na(valor)) {
      print(paste(valor, "es un valor perdido"))
    } else {
      print(paste(valor, "no es un valor perdido, debe ser un texto"))
    }
# [1] "América no es un valor perdido, debe ser un texto"
```
:::

::: {.example}
Crear un proceso complejo que involucre una respuesta para cualquiera de los tipos de elementos ofrecidos en el ejemplo anterior (valor numérico, NA y textual) puede ser un dolor de cabeza. Si se concatenan las condiciones con `else` e `if` de manera errada, generará un error:


```r
### Forma errada
valor <- "Mil quinientos veinte"

if((valor %% 2) == 0) {
  print(paste(valor,"es par"))
  } else if ((valor %% 2) != 0) {
    print(paste(valor,"es impar")) 
    } else if (is.na(valor)) {
      print(paste(valor, "es un valor perdido"))
    } else {
      print(paste(valor, "no es un valor perdido, debe ser un texto"))
    }
# Error in valor%%2 : non-numeric argument to binary operator
```

La manera correcta de crear esta condición compleja se obtiene primero preguntando si el elemento `valor` es número o no. Este paso es fundamental debido a las limitaciones razonables de operar numéricamente con `%%` un texto, generando un error:


```r
"Mil quinientos veinte" %% 2
# Error in "Texto"%%2 : non-numeric argument to binary operator
```

Incluyendo la pregunta ¿es verdad `TRUE` que el valor es un número? con `is.numeric(valor) == TRUE` para cuando valor es número; y la pregunta ¿es falso `FALSE` que el valor es un número? con `is.numeric(valor) == FALSE`, para cuando valor es texto:


```r
### Tómate el tiempo que necesites para 
### entender cómo funciona esta estructura
### Prueba su aplicación cambiando el contenido de valor:
valor <- "Mil quinientos veinte"

if (is.numeric(valor) == TRUE) {
  if((valor %% 2) == 0) {
    print(paste(valor,"es par"))
    } else if ((valor %% 2) != 0) {
      print(paste(valor,"es impar"))
      }
  } else if (is.numeric(valor) == FALSE) {
    if (is.na(valor)) {
      print(paste(valor, "es un valor perdido"))
      } else {
        print(paste(valor, "no es un valor perdido, debe ser un texto"))
      }
    }
# [1] "Mil quinientos veinte no es un valor perdido, debe ser un texto"
```
:::

\BeginKnitrBlock{rmdnote}
Tanto `if` como `else` permiten evaluar elementos dentro de una función y pueden funcionar como **interruptores** que de decanten en la elección de una ruta de análisis en relación a una condición relacionada con el elemento u objeto de entrada.
\EndKnitrBlock{rmdnote}

Para entender la importancia de estos **interruptores** en la creación de funciones, revisemos el contenido de la función `dist()`, que calcula una matriz de distancias para análisis multivariados. Para esta función, es importante especificar qué método de cálculo de distancias se debe usar. Siempre existirá alguno definido por defecto, en este caso `"euclidean"` (distancia euclidiana). Reconoce las estructuras `if` y `else` que usa la función para decidir qué hacer cuando se le a otorgado uno u otro valor en el argumento `method`.


```r
dist
# function (x, method = "euclidean", diag = FALSE, upper = FALSE, 
#     p = 2) 
# {
#     if (!is.na(pmatch(method, "euclidian"))) 
#         method <- "euclidean"
#     METHODS <- c("euclidean", "maximum", "manhattan", "canberra", 
#         "binary", "minkowski")
#     method <- pmatch(method, METHODS)
#     if (is.na(method)) 
#         stop("invalid distance method")
#     if (method == -1) 
#         stop("ambiguous distance method")
#     x <- as.matrix(x)
#     N <- nrow(x)
#     attrs <- if (method == 6L) 
#         list(Size = N, Labels = dimnames(x)[[1L]], Diag = diag, 
#             Upper = upper, method = METHODS[method], p = p, call = match.call(), 
#             class = "dist")
#     else list(Size = N, Labels = dimnames(x)[[1L]], Diag = diag, 
#         Upper = upper, method = METHODS[method], call = match.call(), 
#         class = "dist")
#     .Call(C_Cdist, x, method, attrs, p)
# }
# <bytecode: 0x000001c83ede14d0>
# <environment: namespace:stats>
```

### Condicionales en vectores de más de un elemento con `ifelse()`

De manera similar al uso de `if` y `else`, es posible operar de manera vectorial. Esto significa: aplicar una condición a cada elemento de un vector, para que cuando esta se cumpla (sea `TRUE`) se de un resultado, mientras que otorgue otro cuando no se cumpla (sea `FALSE`). La función `ifelse()`, encargada de ello, requiere como argumentos una condición lógica, un valor para cuando la condición sea `TRUE` y otro valor para cuando sea `FALSE`. La estructura básica es:


```r
ifelse(condicion, "acción_si_la_condición_es_verdadera", "acción_si_la_condición_es_falsa")
```

::: {.example}
Usando `ifelse()` para identificar los valores pares e impares de un vector numérico:


```r
### Crear un vector cualquiera
vector <- 1:50

### Usar ifelse()
ifelse((vector %% 2) == 0, "Par", "Impar")
#  [1] "Impar" "Par"   "Impar" "Par"   "Impar" "Par"   "Impar" "Par"   "Impar" "Par"  
# [11] "Impar" "Par"   "Impar" "Par"   "Impar" "Par"   "Impar" "Par"   "Impar" "Par"  
# [21] "Impar" "Par"   "Impar" "Par"   "Impar" "Par"   "Impar" "Par"   "Impar" "Par"  
# [31] "Impar" "Par"   "Impar" "Par"   "Impar" "Par"   "Impar" "Par"   "Impar" "Par"  
# [41] "Impar" "Par"   "Impar" "Par"   "Impar" "Par"   "Impar" "Par"   "Impar" "Par"
```
:::

Es posible incluir una función `ifelse()` dentro de otra en la posición de resultado `FALSE` para **concatenar varias condiciones aplicadas al mismo vector**:


```r
### Usar ifelse()
ifelse((vector %% 2) == 0 & vector > 10, "Par >10", 
       ifelse((vector %% 2) == 0 & vector <= 10, "Par <=10", 
              ifelse((vector %% 2) != 0 & vector > 10, "impar >10", "impar <=10")))
#  [1] "impar <=10" "Par <=10"   "impar <=10" "Par <=10"   "impar <=10" "Par <=10"  
#  [7] "impar <=10" "Par <=10"   "impar <=10" "Par <=10"   "impar >10"  "Par >10"   
# [13] "impar >10"  "Par >10"    "impar >10"  "Par >10"    "impar >10"  "Par >10"   
# [19] "impar >10"  "Par >10"    "impar >10"  "Par >10"    "impar >10"  "Par >10"   
# [25] "impar >10"  "Par >10"    "impar >10"  "Par >10"    "impar >10"  "Par >10"   
# [31] "impar >10"  "Par >10"    "impar >10"  "Par >10"    "impar >10"  "Par >10"   
# [37] "impar >10"  "Par >10"    "impar >10"  "Par >10"    "impar >10"  "Par >10"   
# [43] "impar >10"  "Par >10"    "impar >10"  "Par >10"    "impar >10"  "Par >10"   
# [49] "impar >10"  "Par >10"
```

### Condicionales en vectores `case_when()` de **dplyr**

La función `case_when()` de la librería **dplyr** es la solución para cuando se necesita utilizar muchos `ifelse()` concatenados. Su uso, como otras funciones de **dplyr**, es sencillo. La estructura básica es:


```r
case_when(
  condicion ~ "resultado_verdadero",
  condicion ~ "resultado_verdadero",
  condicion ~ "resultado_verdadero",
  condicion ~ "resultado_verdadero"
)
```

::: {.example}
Resolviendo el último ejemplo de la sección anterior con `case_when()`:


```r
### Crear un vector
vector <- 1:50

### Evaluar el vector con case_when()
library(dplyr)
case_when(
  (vector %% 2) == 0 & vector > 10 ~ "Par >10",
  (vector %% 2) == 0 & vector <= 10 ~ "Par <=10",
  (vector %% 2) != 0 & vector > 10 ~ "impar >10",
  (vector %% 2) != 0 & vector <= 10 ~ "impar <=10"
)
#  [1] "impar <=10" "Par <=10"   "impar <=10" "Par <=10"   "impar <=10" "Par <=10"  
#  [7] "impar <=10" "Par <=10"   "impar <=10" "Par <=10"   "impar >10"  "Par >10"   
# [13] "impar >10"  "Par >10"    "impar >10"  "Par >10"    "impar >10"  "Par >10"   
# [19] "impar >10"  "Par >10"    "impar >10"  "Par >10"    "impar >10"  "Par >10"   
# [25] "impar >10"  "Par >10"    "impar >10"  "Par >10"    "impar >10"  "Par >10"   
# [31] "impar >10"  "Par >10"    "impar >10"  "Par >10"    "impar >10"  "Par >10"   
# [37] "impar >10"  "Par >10"    "impar >10"  "Par >10"    "impar >10"  "Par >10"   
# [43] "impar >10"  "Par >10"    "impar >10"  "Par >10"    "impar >10"  "Par >10"   
# [49] "impar >10"  "Par >10"
```

Cuando hay elementos que no cumplen con ninguna condición ofrecida, el elemento se reemplaza por `NA` en el vector de resultado:


```r
### Crear un vector
vector <- 1:50

### Evaluar el vector con case_when()
### con una sola condición
library(dplyr)
case_when(
  (vector %% 2) == 0 & vector > 10 ~ "Par >10"
)
#  [1] NA        NA        NA        NA        NA        NA        NA        NA       
#  [9] NA        NA        NA        "Par >10" NA        "Par >10" NA        "Par >10"
# [17] NA        "Par >10" NA        "Par >10" NA        "Par >10" NA        "Par >10"
# [25] NA        "Par >10" NA        "Par >10" NA        "Par >10" NA        "Par >10"
# [33] NA        "Par >10" NA        "Par >10" NA        "Par >10" NA        "Par >10"
# [41] NA        "Par >10" NA        "Par >10" NA        "Par >10" NA        "Par >10"
# [49] NA        "Par >10"
```
:::

### Ciclos o Loops con `for`

El segundo grupo de operadores de control de flujo incluye a los responsables de ciclos, iteraciones o loops. Un loop con `for` tienen la siguiente estructura básica:


```r
for (elemento in vector_secuencial) {acciones a realizar}
```

#### Entendiendo la estructura básica de `for`

`Elemento` y `vector_secuencial` son dos cosas que no se han visto hasta el momento. Elemento se comporta como una variable de posición. Es clásico que se coloque a `i` como elemento, pero puede ser cualquier letra o palabra, siempre y cuando esta se utilice dentro del loop. El elemento funciona como variable de posición, y en cada vuelta del loop, `i` será reemplazado con un elemento del `vector_secuencial`, uno a uno en orden correlativo.

El `vector_secuencial`, por su parte, es un vector que debe contener la secuencia correlativa de números que vaya desde 1 hasta la cantidad máxima de elementos que tiene el vector sobre el que se pretende aplicar el loop. Si el vector inicial al que se le aplicará el loop contiene solo cuatro elementos: `c(10.1, 50.9, 23.4, 31.5)`, se debe colocar una de las siguientes opciones dentro del paréntesis de `for`:


```r
### Vector sobre el que aplicar el loop
vector <- c(10.1, 50.9, 23.4, 31.5)
```


```r
### Opción 1: colocar un rango manualmente (poco eficiente)
for (i in 1:4)

### Opción 1: colocar un rango con length() (no recomendado)
for (i in 1:length(vector))

### Opción 1: usando seq_along() para crear el rango (recomendado)
for (i in seq_along(vector))
```

#### Uso de `for`

::: {.example} 
Utilizando un loop para obtener solo los valores mayores igual al promedio de un conjunto de datos:


```r
### Crear aleatoriamente un conjunto de datos 
### que siga la distribución normal
set.seed(123)
aleatorio <- rnorm(200, mean = 20, sd=5.6)

### Crear un objeto vacío para rellenarlo
### con el resultado de cada vuelta del loop
res <- c()

### Loop sin importar que se generen NA
for (i in seq_along(aleatorio)){
  if (aleatorio[i] >= mean(aleatorio)) {
    res[i] <- aleatorio[i]
  }
}

### Resultado
res
#   [1]    NA    NA 28.73 20.39 20.72 29.60 22.58    NA    NA    NA 26.85 22.01 22.24
#  [14] 20.62    NA 30.01 22.79    NA 23.93    NA    NA    NA    NA    NA    NA    NA
#  [27] 24.69 20.86    NA 27.02 22.39    NA 25.01 24.92 24.60 23.86 23.10    NA    NA
#  [40]    NA    NA    NA    NA 32.15 26.76    NA    NA    NA 24.37    NA 21.42    NA
#  [53]    NA 27.66    NA 28.49    NA 23.27 20.69 21.21 22.13    NA    NA    NA    NA
#  [66] 21.70 22.51 20.30 25.16 31.48    NA    NA 25.63    NA    NA 25.74    NA    NA
#  [79] 21.02    NA 20.03 22.16    NA 23.61    NA 21.86 26.14 22.44    NA 26.43 25.56
#  [92] 23.07 21.34    NA 27.62    NA 32.25 28.58    NA    NA    NA 21.44    NA    NA
# [105]    NA    NA    NA    NA    NA 25.15    NA 23.40    NA    NA 22.91 21.69 20.59
# [118]    NA    NA    NA 20.66    NA    NA    NA 30.33    NA 21.32 20.44    NA    NA
# [131] 28.09 22.53 20.23    NA    NA 26.34    NA 24.14 30.69    NA 23.93    NA    NA
# [144]    NA    NA    NA    NA 23.85 31.76    NA 24.41 24.31 21.86    NA    NA    NA
# [157] 23.15    NA 25.47    NA 25.90    NA    NA 38.15    NA 21.67 23.56    NA 22.89
# [170] 22.07    NA 20.37    NA 31.92    NA    NA 20.21 21.74 22.44    NA    NA 27.07
# [183]    NA    NA    NA    NA 26.22 20.47 24.22    NA 21.20    NA 20.53    NA    NA
# [196] 31.18 23.36
```

Para no generar `NA` en el resultado se usa un truco: ir adicionando el resultado a `res` como un vector que concatena el contenido de hasta la iteración anterior de `res`, más el contenido de la iteración actual:


```r
### Loop sin NA
res <- c()
for (i in seq_along(aleatorio)){
  if (aleatorio[i] >= mean(aleatorio)) {
    res <- c(res, aleatorio[i]) # aquí está el truco
  }
}

### Resultado
res
#  [1] 28.73 20.39 20.72 29.60 22.58 26.85 22.01 22.24 20.62 30.01 22.79 23.93 24.69
# [14] 20.86 27.02 22.39 25.01 24.92 24.60 23.86 23.10 32.15 26.76 24.37 21.42 27.66
# [27] 28.49 23.27 20.69 21.21 22.13 21.70 22.51 20.30 25.16 31.48 25.63 25.74 21.02
# [40] 20.03 22.16 23.61 21.86 26.14 22.44 26.43 25.56 23.07 21.34 27.62 32.25 28.58
# [53] 21.44 25.15 23.40 22.91 21.69 20.59 20.66 30.33 21.32 20.44 28.09 22.53 20.23
# [66] 26.34 24.14 30.69 23.93 23.85 31.76 24.41 24.31 21.86 23.15 25.47 25.90 38.15
# [79] 21.67 23.56 22.89 22.07 20.37 31.92 20.21 21.74 22.44 27.07 26.22 20.47 24.22
# [92] 21.20 20.53 31.18 23.36
```
::: 

::: {.example}
Otra manera de conseguir el efecto visto en el ejemplo anterio es utilizando el operador condicional `next`. Este "salta" un ciclo cuando se cumple la condición del `if` previo. Nota como la condición en `if` pide lo contrario a lo que se necesita, para que cuando se cumpla se active `next` y cuando no se cumpla se guarda el valor concatenado en res.


```r
### Crear un objeto vacío 
res <- c()

### Loop con next y condición if inversa a lo requerido
for (i in seq_along(aleatorio)){
  if (aleatorio[i] < mean(aleatorio)) # condición inversa para usar next
    next
  res <- c(res, aleatorio[i])
}

### Resultado
res
#  [1] 28.73 20.39 20.72 29.60 22.58 26.85 22.01 22.24 20.62 30.01 22.79 23.93 24.69
# [14] 20.86 27.02 22.39 25.01 24.92 24.60 23.86 23.10 32.15 26.76 24.37 21.42 27.66
# [27] 28.49 23.27 20.69 21.21 22.13 21.70 22.51 20.30 25.16 31.48 25.63 25.74 21.02
# [40] 20.03 22.16 23.61 21.86 26.14 22.44 26.43 25.56 23.07 21.34 27.62 32.25 28.58
# [53] 21.44 25.15 23.40 22.91 21.69 20.59 20.66 30.33 21.32 20.44 28.09 22.53 20.23
# [66] 26.34 24.14 30.69 23.93 23.85 31.76 24.41 24.31 21.86 23.15 25.47 25.90 38.15
# [79] 21.67 23.56 22.89 22.07 20.37 31.92 20.21 21.74 22.44 27.07 26.22 20.47 24.22
# [92] 21.20 20.53 31.18 23.36
```
:::

::: {.example}
Si es requerido frenar el loop antes de que culmine, en base a una nueva condición definida, se debe utilizar `break`. En nuestro ejemplo, para frenar el loop cuando aparezca el primer valor mayor a 30.5, es necesario ir evaluando en cada iteración del loop si existe al menos un valor `> 30.5` en el objeto `res`. Esto se obtiene con `any(res > 30.5)`. En el momento que se cumpla, `break` frena el loop.


```r
### Crear un objeto vacío 
res <- c()

### Loop con next y condición if inversa a lo requerido
for (i in seq_along(aleatorio)){
  if (aleatorio[i] < mean(aleatorio)) 
    next
  res <- c(res, aleatorio[i])
  
  if (any(res > 30.5)) # hay que evaluar si hay algún (any)
    break
}

### Resultado
res
#  [1] 28.73 20.39 20.72 29.60 22.58 26.85 22.01 22.24 20.62 30.01 22.79 23.93 24.69
# [14] 20.86 27.02 22.39 25.01 24.92 24.60 23.86 23.10 32.15
```
:::

### Ciclos o loops con `replicate()`

La función `replicate()` facilita mucho procesos iterativos para simulación. Permite replicar una o varias líneas de código las veces que sean definidas, para almacenarlas como una lista de vectores (con el argumento `simplify = FALSE`), o como un vector único (con el argumento `simplify = TRUE`, como está por defecto). Ejemplificaremos su uso con un **caso de estudio**: 

::: {.example}
Se ha evaluado una población, de la cual se obtuvo como muestra 100 medidas de una longitud. Al obtener el valor más grande de dicha muestra se obtiene:


```r
### Valores del estudio
muestra <- c(155.62, 158.5, 174.06, 161.11, 161.62, 175.42, 164.51, 149.49, 
         154.52, 156.62, 171.15, 163.63, 163.99, 161.46, 155.66, 176.05,
         164.83, 143.39, 166.6, 156.39, 151.21, 158.6, 151.57, 154.16, 
         155.06, 145.83, 167.79, 161.83, 150.6, 171.41, 164.21, 157.93, 
         168.29, 168.14, 167.65, 166.49, 165.32, 159.96, 157.84, 157.19,
         154.46, 158.69, 149.49, 179.37, 171.01, 150.73, 156.99, 156.44, 
         167.29, 159.77, 162.7, 160.25, 160.13, 172.41, 158.54, 173.69, 
         147.03, 165.59, 161.58, 162.38, 163.8, 156.13, 157.6, 151.64, 
         151.18, 163.14, 164.4, 160.96, 168.52, 178.34, 156.23, 140.41, 
         169.25, 154.33, 154.51, 169.42, 158.02, 149.88, 162.08, 159.29, 
         160.55, 163.85, 157.28, 166.11, 158.58, 163.39, 170.04, 164.29, 
         157.66, 170.49, 169.14, 165.27, 162.58, 155.04, 172.34, 155.28, 
         179.53, 173.83, 158.45, 151.57)

### El valor más alto de dicha población
max(muestra)
# [1] 179.5
```

Pero ¿Siempre será así?. ¿Será que si evaluo nuevamente la población obtendré el mismo valor máximo?. Como no tenemos dinero ni tiempo para volver a evaluar dicha población, decidimos simularla. En este paso necesitamos información de la muestra:


```r
### Promedio
promedio <- mean(muestra)

### Desviación estándar
desvest <- sd(muestra)
```

Con estos datos se puede simular una población en R. Asumiendo que esta siguen una distribución normal, utilizamos:


```r
### Simular los datos 
set.seed(123)
muestra_simulada <- rnorm(100, mean = promedio, sd = desvest)

### Ver los resultados
muestra_simulada
#   [1] 156.8 159.5 173.7 161.8 162.3 174.9 164.9 151.2 155.8 157.7 171.0 164.1 164.5
#  [14] 162.2 156.9 175.5 165.2 145.7 166.9 157.5 152.8 159.6 153.1 155.5 156.3 147.9
#  [27] 167.9 162.5 152.2 171.2 164.7 158.9 168.4 168.3 167.8 166.8 165.7 160.8 158.9
#  [40] 158.3 155.8 159.6 151.2 178.5 170.9 152.4 158.1 157.6 167.5 160.6 163.3 161.1
#  [53] 160.9 172.2 159.5 173.3 149.0 165.9 162.3 163.0 164.3 157.3 158.6 153.2 152.8
#  [66] 163.7 164.8 161.7 168.6 177.6 157.4 142.9 169.3 155.7 155.8 169.4 159.0 151.6
#  [79] 162.7 160.2 161.3 164.3 158.3 166.4 159.5 163.9 170.0 164.7 158.7 170.4 169.2
#  [92] 165.6 163.2 156.3 172.1 156.5 178.7 173.5 159.4 153.1
```

Para repetir esta simulación diez mil veces, y obtener estadísticos descriptivos de los valores máximos de dichas muchas simuladas, utilizaremos `replicate()` con dos pasos internos por cada iteración del loop:

- Crear un conjunto de números aleatorios para la iteración.
- Hallar el valor máximo de la longitud en dicho conjunto.


```r
### Usar replicate()
set.seed(123)
resultados <- replicate(n = 10000, {
  parcial <- rnorm(100, mean = promedio, sd = desvest)
  max(parcial)
  }
) 

### Revisar el valor máximo, mínimo y promedio de longitudes 
### máximas obtenidas por el loop de replicate()
min(resultados)
# [1] 171.8
max(resultados)
# [1] 199.8
mean(resultados)
# [1] 181.2

### Valor máximo de la muestra original
max(muestra)
# [1] 179.5
```
:::

Con ello nos hemos dado cuenta que, asumiendo que la variable tiene distribución de probabilidades normal, el valor máximo de la muestra original (179.53), es menor al promedio poblacional simulado con diez mil réplicas (199.809). Por el contrario, está más cerca del valor máximo más pequeño dentro de los diez mil datos (171.7636).

### Ciclos o Loops con `while`

Otro operador de control de flujo con el que se crea loops es `while`. A diferencia de `for`, que opera hasta que se acaben las iteraciones definidas por el rango `1:n`, `while` se detendrá solo hasta que se cumpla una condición. Si dicha condición nunca se cumple, se crea un loop infinito. Un loop con `while` tienen la siguiente estructura básica:


```r
# Posición inicial
index <- 1

# Loop con while
while (condicion_respecto_a_index) {
  acciones a realizar
  index <- index + 1
  }
```

Es la segunda línea de la condición a realizar dentro del loop `while` lo que le da la continuidad. En alguna iteración, el ir "sumando" valores al index hará que se cumpla la condición definida.

::: {.example}
Veamos su aplicación:


```r
# Posición inicial
index <- 1

# Loop con while
while (index <= 5) {
  # Acción a realizar
  print(paste("El número es", index))
  # Suma una posición para la siguiente iteración
  index <- index + 1
}
# [1] "El número es 1"
# [1] "El número es 2"
# [1] "El número es 3"
# [1] "El número es 4"
# [1] "El número es 5"
```
:::

Una segunda manera de operar es indicar que se frene el loop hasta que una condición lógica cambie de estado (`FALSE` a `TRUE`, o viceversa). 

::: {.example}
Se aplicará el imprimir la secuencia de bases nitrogenadas (letras `A`, `C`, `G`, `T`) hasta que se ubique la primera base G. Trata de interpretar cada paso dentro de una iteración del loop `while`:


```r
### Vector sobre el cual hacer la impresión de elementos
vector <- c("A","T","C","A","T","G","G","G","G","C","C")

### Condición en estado falso
condicion <- FALSE

### Índice
index <- 1

### Loop con while
### Aquí !condicion significa: 
### "mientras que condición no sea verdadera, continuar" 
while ( !condicion ) { 
  print(vector[index]) # imprime el elemento
  index <- index + 1   # adiciona una posición
  condicion <- vector[index] == "G" # evalúa si es G la siguiente posición
}
# [1] "A"
# [1] "T"
# [1] "C"
# [1] "A"
# [1] "T"
```
:::

Intentar con `for` lo explicado en el ejemplo anterior llevaría al **resultado erróneo** de imprimir todo menos los elementos que se soliciten, como "G":


```r
### Vector sobre el cual hacer la impresión de elementos
vector <- c("A","T","C","A","G","T","C","A",
            "T","G","G","C","G","G","C","C")

### Loop con for
for(i in seq_along(vector)){
  if(vector[i]!="G")
  print(vector[i])
}
# [1] "A"
# [1] "T"
# [1] "C"
# [1] "A"
# [1] "T"
# [1] "C"
# [1] "A"
# [1] "T"
# [1] "C"
# [1] "C"
# [1] "C"
```

Algo más interesante para el loop `while` podría ser frenar la impresión de elementos cuando se identifique que a partir de la siguiente iteración aparecerá una secuencia definida. 

::: {.example}
Imagina que necesitas frenar la impresión hasta que aparezca la primera secuencia `TGC`, en ese orden:


```r
# Objetos necesarios
vector <- c("A","T","C","A","G","T","C","A",
            "T","G","G","C","G","G","C","C")
condicion <- FALSE
index <- 1

### Loop con while
while ( !condicion ) { 
  print(vector[index]) 
  index <- index + 1 
  condicion <- identical(c(vector[index], vector[index+1], 
                           vector[index+2]), c("T","G","G"))
}
# [1] "A"
# [1] "T"
# [1] "C"
# [1] "A"
# [1] "G"
# [1] "T"
# [1] "C"
# [1] "A"
```
:::

## Operadores de función {#operadoresfuncion}

Los **operadores de función** son funciones que toman como entrada una función y devuelven como resultado otra función generada como una modificación de la inicial. Esto es diferente de lo mostrado hasta el momento, donde una función usualmente genera un objeto como resultado. 

::: {.example}
Veamos un ejemplo sobre la identificación de números primos. La forma más sencilla de hacer es creando una función que identifique si un número dado es primo o no. El proceso de idear esta función comienza con crear una función que identifique si un número es primo o no. Esta función inicial debe ser pensada como una función que se le puede aplicar a un solo elemento, no a un conjunto de datos.


```r
### Crear la función primo.logic() para identificar números primos
primo.logic <- function(x) {
  if (x == 2) {
    TRUE
  } else if (any(x %% 2:(x-1) == 0)) {
    FALSE
  } else { 
    TRUE
  }
}

### Probar la función con los números primos 2, 3, 5, y no primos 4, 9, 27
primo.logic(2)
# [1] TRUE
primo.logic(3)
# [1] TRUE
primo.logic(5)
# [1] TRUE
primo.logic(4)
# [1] FALSE
primo.logic(9)
# [1] FALSE
primo.logic(27)
# [1] FALSE
```

El resultado es excelente, `primo.logic()` identifica si un número es primo o no. Sin embargo, no es eficiente ir probando elemento a elemento el contenido de un conjunto de datos. Automatizar `primo.logic()` para que aplique la búsqueda de números primos elemento a elemento (*element-wise*) a un vector completo, implica vectorizar `primo.logic()` usando la función `Vectorize()`. Este es el **operador de funciones** que nos devolverá como resultado la función `primo.logic()` aplicable a un vector:


```r
### Crear un vector para buscar los números primos en él
sec <- 1:100

### Vectorizar la función primo.logic() y 
### guardarla como una nueva función primoV
primoV <- Vectorize(primo.logic) 

### Usar primoV()
primoV(sec)
#   [1] FALSE  TRUE  TRUE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE
#  [14] FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
#  [27] FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
#  [40] FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
#  [53]  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE
#  [66] FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
#  [79]  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
#  [92] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE

### Filtrar los números primos de la secuencia
sec[primoV(sec)]
#  [1]  2  3  5  7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97
```
:::

De manera similar a lo mostrado con `Vectorize()`, existen otros enfoques en R que utilizan funciones de la familia `apply()`. Este tema es abordado en la siguiente sección.

## Familia `apply()` 

### Función `apply()`

La familia de funciones `apply()` reúne a varias funciones que permiten, como se implica de su nombre, aplicar algo a un objeto. Ese algo es una función. 

::: {.example}
Para explorar los beneficios de este grupo de funciones, comencemos con un problema básico: calcular el promedio de varias columnas numéricas de una data frame.


```r
### Activar la data frame de ejemplo llamada iris
data(iris)

### Ver las primeras 10 filas de la tabla
head(iris, 10)
#    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1           5.1         3.5          1.4         0.2  setosa
# 2           4.9         3.0          1.4         0.2  setosa
# 3           4.7         3.2          1.3         0.2  setosa
# 4           4.6         3.1          1.5         0.2  setosa
# 5           5.0         3.6          1.4         0.2  setosa
# 6           5.4         3.9          1.7         0.4  setosa
# 7           4.6         3.4          1.4         0.3  setosa
# 8           5.0         3.4          1.5         0.2  setosa
# 9           4.4         2.9          1.4         0.2  setosa
# 10          4.9         3.1          1.5         0.1  setosa
```

Calcular el promedio de las primeras cuatro columnas (las únicas numéricas), se puede hacer manualmente:


```r
mean(iris$Sepal.Length)
# [1] 5.843
mean(iris$Sepal.Width)
# [1] 3.057
mean(iris$Petal.Length)
# [1] 3.758
mean(iris$Petal.Width)
# [1] 1.199
```

O con `apply()`. Esta función necesita que especifiquemos como argumentos: una base de datos tabular (DF), un modo de aplicación de la función (fila por fila: MARGIN = 1, columna por columna: MARGIN = 2), y la función (sin paréntesis) a ser aplicada. El resultado obtenido es un vector, cuyos elementos reciben el nombre de la columna de la cual proceden. En consecuencia, la estructura básica es:


```r
### Modo largo
apply(DF, MARGIN = 2, FUN = FUNCIÓN)

### Modo corto
apply(DF, 2, FUNCIÓN)
```

Poniendo en contexto `apply()` para el ejemplo planteado:


```r
### Seleccionando las 4 primeras columnas de iris
apply(iris[,1:4], 2, FUN = mean)
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
#        5.843        3.057        3.758        1.199
```
:::

Dentro de la familia `apply()` podrás encontrar:


Table: (\#tab:unnamed-chunk-49)Funciones de la familia apply() que se pueden utilizar en R para automatizar la aplicación de funciones sobre diferentes estructuras de datos.

Función      Descripción                                                                                                                                                                                                                                                                                  
-----------  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
`apply()`    Aplica una función a las columnas (MARGIN = 2) o filas (MARGIN = 1) de una base de datos en dos dimensiones (tablas, matrices, data frames). Produce un vector nombrado como resultado.                                                                                                      
`lapply()`   Aplicar una función sobre un vector o lista. Produce una lista como resultado.                                                                                                                                                                                                               
`sapply()`   Igual que `lapply()` pero produce un vector o matriz como resultado.                                                                                                                                                                                                                         
`vapply()`   Igual que `sapply()` pero produce un resultado con estructura predefinida por el usuario.                                                                                                                                                                                                    
`tapply()`   Aplica una función a un vector separándolo primero por grupos en base a otro vector. Devuelve como resultado un array.                                                                                                                                                                       
`mapply()`   Es la versión "multivariada" de `sapply()`. Aplica una función a la vez sobre varios vectores. En estos evalúa sobre la función de manera agrupada los primeros elementos, segundos elementos, terceros elementos, y así para delante, hasta acabar con los elementos de todos los vectores. 

### Función `lapply()`

La función `lapply()` se aplica tanto a una base de datos tabular o sobre una lista. Si se aplica a una tabla (DF), lo hace siempre de manera columna a columa, lo mismo que hace `apply()` con el argumento `MARGIN = 2`. No obstante, el resultado es siempre una lista, no un vector. La estructura básica es:


```r
lapply(DF,  FUN = FUNCIÓN)
```

::: {.example}
Aplicando `lapply()` al ejemplo propuesto anteriormente, se tiene:


```r
lapply(iris[,1:4],  FUN = mean)
# $Sepal.Length
# [1] 5.843
# 
# $Sepal.Width
# [1] 3.057
# 
# $Petal.Length
# [1] 3.758
# 
# $Petal.Width
# [1] 1.199
```

Siempre que se necesite "deslistar" una lista y extraer los elementos como un único vector, se utiliza `unlist()`:


```r
lista <- lapply(iris[,1:4],  FUN = mean)
unlist(lista)
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
#        5.843        3.057        3.758        1.199
```
:::

En este último ejemplo, vemos como el resultado converge con el de `apply()`.

### Función `tapply()`

Esta función es excepcional. Permite calcular el resultado de una función aplicada sobre un vector, pero muestra los resultados agrupados en base a las categorías de otro vector de misma longitud. El resultado obtenido es un vector. La estructura básica es:


```r
tapply(VECTOR_NUMÉRICO, VECTOR_DE_AGRUPAMIENTO, FUN = FUNCIÓN)
```

::: {.example}
El siguiente código sirve para calcular el promedio por especie (grupo especificado en la columna `Species`), de la variable en la columna 1 de la base de datos iris:


```r
tapply(iris[,1], iris$Species, FUN = mean)
#     setosa versicolor  virginica 
#      5.006      5.936      6.588
```
:::

Recuerda que siempre que necesites puedes crear una función. Si unificamos el uso de `lapply()` para aplicar `tapply()` a cada elemento de columna de `iris[,1:4]`, es necesario crear una función con `tapply()` dentro del cual se especifique el uso de la función `mean()`:


```r
lapply(iris[,1:4],  FUN = function(x) tapply(x, iris$Species, mean))
# $Sepal.Length
#     setosa versicolor  virginica 
#      5.006      5.936      6.588 
# 
# $Sepal.Width
#     setosa versicolor  virginica 
#      3.428      2.770      2.974 
# 
# $Petal.Length
#     setosa versicolor  virginica 
#      1.462      4.260      5.552 
# 
# $Petal.Width
#     setosa versicolor  virginica 
#      0.246      1.326      2.026
```

### Función `sapply()`

Una forma de usar funciones elemento a elemento (*element-wise*) en un vector sin tener que vectorizar (ver [Sección 5.3](#operadoresfuncion)), y que otorgue como resultado un vector, se obtiene con `sapply()`. Esta se puede aplicar sobre vectores. La estructura básica es:


```r
sapply(VECTOR, FUN = FUNCIÓN)
```

::: {.example}
Aplicado al caso de la [Sección 5.3 Operadores de Función](#operadoresfuncion) en el que se requería aplicar `primo.logic()` sobre un vector numérico llamado `sec` para la búsqueda de números primos, se tiene:


```r
### Recreando sec para buscar los números primos en él
sec <- 1:100

### Aplicar sapply()
sapply(sec, FUN = primo.logic)
#   [1] FALSE  TRUE  TRUE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE
#  [14] FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
#  [27] FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
#  [40] FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
#  [53]  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE
#  [66] FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
#  [79]  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
#  [92] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
```
:::

## Ejercicios del capítulo

<div class="question">
  1. Reproduce el resultado del siguiente loop `for`, utilizando la función `replicate()`:


```r
set.seed(123)
lista1 <- list() # Lista vacía
for (i in 1:3) { # Número de iteraciones = 5
  lista1[[i]] = rnorm(6, 0, 1) # Conjunto aleatorio normal para cada iteración
}
lista1
# [[1]]
# [1] -0.56048 -0.23018  1.55871  0.07051  0.12929  1.71506
# 
# [[2]]
# [1]  0.4609 -1.2651 -0.6869 -0.4457  1.2241  0.3598
# 
# [[3]]
# [1]  0.4008  0.1107 -0.5558  1.7869  0.4979 -1.9666
```

  1. Crea la base de datos DF numérica (código ya definido en el siguiente chunk), que tiene las dimensiones 12 (filas) x 5 (columnas). Esta base contiene valores no deseados: `-999`. Crea y utiliza una función llamada `cambiarNA()` que te permita cambiar estos valores por `NA`. 


```r
# Base de datos DF
set.seed(123)
secuencia <- c(seq(0.5, 7.9, length = 10), -999, 5555)
DF <- data.frame(replicate(5, 
                           sample(secuencia, 12, rep = TRUE)))
DF <- round(DF,2)

# Darle nombre a sus columnas
colnames(DF) <- paste0("Var", 1:5)

# Revisar el contenido de DF
DF 
#       Var1    Var2    Var3    Var4    Var5
# 1     2.14    3.79    7.08    7.90    6.26
# 2     2.14    2.14    2.14    5.43 5555.00
# 3     7.90 -999.00    2.97 -999.00    1.32
# 4     1.32    7.08    0.50 5555.00    0.50
# 5     4.61 5555.00 -999.00    3.79    7.08
# 6  -999.00    7.08    5.43    5.43 -999.00
# 7     3.79    7.08    3.79    3.79    7.08
# 8     2.97    2.14 5555.00 -999.00    4.61
# 9     4.61    6.26    7.90    4.61    3.79
# 10    7.08    7.90    5.43    7.08    7.08
# 11    7.90    5.43    7.08    1.32    7.90
# 12 -999.00    7.90    7.08    3.79 5555.00
```

  1. Utilizando la base de datos DF creada inicialmente en el ejercicio 2, modifica la función `cambiarNA()` para que no solo cambie `-999` a `NA`, sino que cambie cualquier valor que tú le proporciones con un argumento. Llama a esta función `cambiarNA2()`. Utilízala para reemplazar los valores `5555` a `NA`.
 
  1. Utilizando la base de datos DF creada inicialmente en el ejercicio 2, modifica la función `cambiarNA2()` de tal manera que te permita definir más de un valor (un vector numérico) como elementos a ser reemplazados por `NA`. Llama a esta función `cambiarNA3()`. Cambia por `NA` los valores `-999` y `5555`. Pista: Esta función deberá contener un loop para aplicarle la función de cambio por NA a un elemento del vector a la vez en cada iteración.

  1. Crea un loop `for` que itere sobre los números del 1 al 50 y calcule el cubo de cada número, de manera que los resultados se vayan guardando en un vector llamado `preliminar`. Luego, crea un segundo loop que te permita identificar y almacenar solamente los números menores a la mediana `median()` del conjunto de datos `preliminar` en un nuevo vector llamado `final`.

  1. En R ya existe una función para calcular la varianza y es `var()`. Pero este ejercicio se trata de poner en juego lo que aprendiste sobre programación en R. La fórmula matemática de la varianza poblacional, con denominador $n$, Ecuación \@ref(eq:varianzapob). Pero la función `var()` de R contiene la fórmula matemática para calcular la varianza de muestras, no de poblaciones enteras. La fórmula matemática de la varianza muestral que usa R tiene como denominador $n-1$, Ecuación \@ref(eq:varianzamuestral). Crea una función llamada `var2()` que calcule la varianza del conjunto de datos llamado `vector`. Finalmente, compara tus resultados con los obtenidos por `var()`.
  
  \begin{align}
  \sigma^2 = \frac{1}{n}*{\displaystyle\sum_{i=1}^{n}(x_i - \mu)^2} (\#eq:varianzapob)
  \end{align}

  \begin{equation}
  \sigma^2 = \frac{1}{n-1}*{\displaystyle\sum_{i=1}^{n}(x_i - \mu)^2} (\#eq:varianzamuestral)
  \end{equation}


```r
set.seed(123)
vector <- rnorm(50, 21, 1.6)
```
  
  1. Carga la base de datos npk. Usando una función de la familia apply(), calcula la el promedio, mediana y desviación estándar de la columna `yield` para cada categoría (numérica) de la columna `block`. Con ello, se conocerá el promedio de producción que se obtuvo en cada bloque para un estudio de mejora fitogenética:


```r
data("npk")
```

  1. Ejecuta el siguiente código para crear una lista llamada `iris3Lista` a partir de la base de datos de ejemplo `iris3` (un array). Si revisas `iris3Lista`, notarás que continene 3 elementos, cada uno de ellos es una matriz de datos de cuatro columnas (`Sepal L.`, `Sepal W.`, `Petal L.`, y `Petal W.`). Utilizando dos funciones de la familia `apply()`, calcula el promedio de cada columna de cada elemento de la lista `iris3Lista`.
  

```r
# Cargar iris3
data("iris3")

# Convertirla a lista
iris3Lista <- list(setosa = iris3[,,1],
                versicolor = iris3[,,2],
                virginica = iris3[,,3])
```
</div>
