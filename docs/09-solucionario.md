# (PART\*) SOLUCIONARIO {.unnumbered}

# **Solucionario de los ejercicios del libro**

Este capítulo extra del libro permitirá al lector revisar si las soluciones realizadas a los ejercicios de cada capítulo son correctos. Recuerda que no existe una única solución a un problema en R. Uno es libre de *programar las soluciones* según su propio pensamiento creativo, nivel de conocimiento del código y practicidad. 

Se recomienda no revisar este capítulo antes de realizar los ejercicios, principalmente para permitir que el alumno desarrolle su pensamiento lógico respecto al código en R. Recuerda que la práctica hace al maestro.
  
## Cap. 2: Primer contacto con R
<div class="question">
  1. Soluciona la ecuación $\sqrt({\frac{24+12}{(2 * 3)^3})}$.
</div>

**Solución:**


```r
sqrt((24+12)/(2*3)^3)
# [1] 0.4082
```

<div class="question">
  1. Resuelve $\mathrm{log_{10}}(|\frac{\mathrm{exp(10)}^2}{-10*9^{6}}|)$. Las barras verticales implican aplicar valor absoluto antes de calcular el logaritmo en base 10.
</div>

**Solución:**


```r
log10(abs((exp(10)**2)/(-10*(9^6))))
# [1] 1.96
```

<div class="question">
  1.La función sigmoidal $\sigma(\mathrm{z}) = \frac{1}{1+e^{-\mathrm{z}}}$ es muy importante en estadística. Permite convertir el resultado de una regresión logística (Odds ratios) en probabilidades, facilitando la interpretación. Utiliza la fórmula $z = -1.69 + 1*0.56$, emulando el resultado hipotético de una regresión logística, como insumo para calcular su probabilidad correspondiente utilizando la función sigmoidal. Como dato extra, el resultado de $\sigma(\mathrm{z})$ por 100 para convertirlo a probabilidad porcentual.
</div>

**Solución:**


```r
### Crear z
z <- -1.69 + 1*0.56

### Calcular la función sigmoidal
1 / (1 + exp(-z))
# [1] 0.2442
```

<div class="question">
  1. Este ejercicio avanzado es de carácter explicativo. Sigue el ejercicio en la sección del [Solucionario: Cap. 2, pregunta 3](#cap.-2-primer-contacto-con-r) correspondiente. Para calcular la derivaba de una función matemática, primero se debe crear la estructura matemática utilizando la función `expression()`. Una vez guardada la expresión, se utiliza la función `D()` para derivar. <br>
  <br>Calcula la primera derivada de:
  <br>$f(x)=-2x+2$
  <br>$f(x)=-2x^2-5$
  <br>$f(x)=\frac{x^3+2}{3}$
  <br>
  <br>
  Calcula la primera derivada de una expresión con dos variables:
  <br>$f(x)=x^2+y^2+2*x*y-3*x+4*y+4$
  <br>
  <br>
  Calcula la segunda derivada de:
  <br>$f(x)=x^2+3*x$
</div>

**Solución:**


```r
### Crear las expresiones matemáticas
eMat1 <- expression((-2*x)+2)
eMat2 <- expression((-2*(x^2))-5)
eMat3 <- expression(((x^3)+2)/3)

### Función D() para derivar las expresiones sobre x
D(eMat1, "x")
# -2
D(eMat2, "x")
# -(2 * (2 * x))
D(eMat3, "x")
# 3 * x^2/3

### Crear la expresión matemática con dos variables (x e y)
eMat4 <-expression(x^2+y^2+2*x*y-3*x+4*y+4)

### Función D() para derivar la expresiones sobre x
D(eMat4, "x")
# 2 * x + 2 * y - 3

### Función D() para derivar la expresiones sobre y
D(eMat4, "y")
# 2 * y + 2 * x + 4

### Crear la expresión matemática para obtener segunda derivada
eMat5 <- expression(x^2+3*x)

### Primera derivada
D(eMat5, "x")
# 2 * x + 3
  
### Segunda derivada
D(D(eMat5, "x"),'x')
# [1] 2
```

Para resolver **integrales en R**, puedes revisar la documentación de la función `integrate()` en [RDocumentation](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/integrate).


```r
# Un ejemplo rápido de uso extraído de la documentación
integrand <- function(x) {1/((x+1)*sqrt(x))}
integrate(integrand, lower = 0, upper = Inf)
# 3.142 with absolute error < 2.7e-05
```

\BeginKnitrBlock{rmdtip}<div class="rmdtip">Se recomienda la lectura del libro [R for Calculus](https://dtkaplan.github.io/RforCalculus/integrals-and-integration.html) de [Daniel Kaplan](https://github.com/dtkaplan) para profundizar en cálculo diferencial e integral en R.</div>\EndKnitrBlock{rmdtip}

<br>

<div class="question">
  1. Crea un vector con llamado `num1` conteniendo 1000 números aleatorios con distribución normal, con promedio 19 y desviación estándar 1.29 (revisa la [TABLA 2.4](#funciones-básica-útiles)).
  Asegúrate de ejecutar previamente la función `set.seed(123)` para que el ejercicio sea replicable.
</div>

**Solución:**


```r
set.seed(123)
num1 <- rnorm(1000, mean=19, sd=1.29)

### La función head() permite ver los primeros N elementos del vector
### Aquí se define N como 20 elementos
head(num1, 20)
#  [1] 18.28 18.70 21.01 19.09 19.17 21.21 19.59 17.37 18.11 18.43 20.58 19.46 19.52
# [14] 19.14 18.28 21.31 19.64 16.46 19.90 18.39
```

<div class="question">
  1. Calcula el promedio y la desviación estándar del objeto `num1`. ¿Son exactamente iguales a los valores definidos con los que creaste el conjunto de datos usando `rnorm()`?.
</div>

**Solución:**


```r
mean(num1)
# [1] 19.02
sd(num1)
# [1] 1.279
```

Como habrás notado. Los valores obtenidos no son exactamente los valores de promedio y desviación estándar con los que se generaron los mil números aleatorios con `rnorm()`. La aleatorización impide que los valores sean idénticos, no obstante siempre tienden a lo solicitado. No que sucede exclusivamente en R, de hecho ningún lenguaje de programación lo hace idéntico.

<div class="question">
  1. Calcula los cuartiles de dicho conjunto de datos. ¿Cuál es el valor del cuartil 50% (que es conocido como mediana) (revisa la [TABLA 2.4](#funciones-básica-útiles))?
</div>

**Solución:**


```r
### Para ver los cuartiles por defecto
quantile(num1)
#    0%   25%   50%   75%  100% 
# 15.38 18.19 19.01 19.86 23.18

### Para obtener el cuartil 50% o mediana
quantile(num1, probs=0.5)
#   50% 
# 19.01
```

<div class="question">
  1. Utilizando los operadores relacionales, convierte el vector numérico `num1` a vector lógico, aplicando la pregunta lógica "números mayores a 20.0". Guarda el resultado en el ambiente con el nombre `VL20` (revisa la [TABLA 2.3](#operadores-lógicos-y-relacionales)).
</div>

**Solución:**


```r
VL20 <- num1 > 20.0

### La función head() permite ver los primeros N elementos del vector
### Aquí se define N como 35 elementos
head(VL20, 35)
#  [1] FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
# [14] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
# [27]  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE  TRUE  TRUE
```

<div class="question">
  1. Coloca el objeto `VL20` dentro de la función `mean()`. La función mean calcula normalmente el promedio de un conjunto de datos numéricos. No obstante, cuando se le ofrece un vector lógico, contabiliza la cantidad de elementos `TRUE` y ofrece la proporción de verdaderos respecto al total de elemento del conjunto. ¿Cuál es la proporción de elementos `FALSE` del vector `VL20`? (revisa la [TABLA 2.3](#operadores-lógicos-y-relacionales)).
</div>

**Solución:**


```r
### Proporción de TRUE en el conjunto
mean(VL20)
# [1] 0.221

### Proporción de FALSE en el conjunto
1 - mean(VL20)
# [1] 0.779
```


<div class="question">
  1. Utilizando los operadores lógicos y relacionales, convierte el vector numérico `num1` a vector lógico, aplicando la pregunta lógica "números menor igual a 19.5 y números mayor a 15.7". (revisa la [TABLA 2.3](#operadores-lógicos-y-relacionales)). Si se sabe que son 1000 elementos los que contiene el vector, ¿Cuántos elementos del conjunto encajan dentro de la premisa lógica anterior?.
</div>

**Solución:**


```r
### Crear el vector lógico, dándole un nombre cualquiera
num1LOGICO <- (num1 < 19 & num1 > 15.7)

### Proporción de elementos TRUE
### Es decir, que cumplieron la premisa anterior
mean(num1LOGICO)
# [1] 0.491

### Convertir proporción a cantidad,
### multiplicando por el total de datos del vector
mean(num1LOGICO) * length(num1LOGICO)
# [1] 491
```


## Cap. 3: Estructuras de datos {#preg-estructurasdatos}

<div class="question">
  1. Crea una variable llamada `datosNumeros` que contenga 200 números (decimales) entre el 20 y 80.
</div>

**Solución:**


```r
datosNumeros <- seq(20, 80, length=200)

### Función head() para ver los 20 primeros elementos del vector
head(datosNumeros, 20)
#  [1] 20.00 20.30 20.60 20.90 21.21 21.51 21.81 22.11 22.41 22.71 23.02 23.32 23.62
# [14] 23.92 24.22 24.52 24.82 25.13 25.43 25.73
```

<div class="question">
  1. Utilizando la función `sample()`, crea una variable llamada `muestr4` que contenga el muestreo de 10 elementos (con repetición) del objeto `datosNumeros`. Utiliza `set.seed(123)`
antes del muestro para asegurar la replicabilidad del mismo.
</div>

**Solución:**


```r
set.seed(123)
muestr4 <- sample(datosNumeros, 10, replace = TRUE)

### Revisar el contenido
muestr4
#  [1] 67.64 73.67 23.92 78.49 70.95 34.77 55.28 32.66 23.92 55.28
```

<div class="question">
  1. Redondea todos los elementos del vector `datosNumeros` a dos decimales, coerciona el objeto a texto, y guarda el resultado en el ambiente con el nombre `coer`.
</div>

**Solución:**


```r
### Redondear datosNumeros
r <- round(datosNumeros, 2)

### Coercer hacia texto
coer <- as.character(r) 

### Revisar el contenido
head(coer, 20)
#  [1] "20"    "20.3"  "20.6"  "20.9"  "21.21" "21.51" "21.81" "22.11" "22.41" "22.71"
# [11] "23.02" "23.32" "23.62" "23.92" "24.22" "24.52" "24.82" "25.13" "25.43" "25.73"
```

Se puede coercer un número a texto, dado que solo se necesita colocar el número entre comillas para sea considerado así. 
 
<div class="question">
  1. Utiliza `coer` para coercer el objeto hacia número nuevamente.
</div>

**Solución:**


```r
### Redondear datosNumeros
as.numeric(coer)
#   [1] 20.00 20.30 20.60 20.90 21.21 21.51 21.81 22.11 22.41 22.71 23.02 23.32 23.62
#  [14] 23.92 24.22 24.52 24.82 25.13 25.43 25.73 26.03 26.33 26.63 26.93 27.24 27.54
#  [27] 27.84 28.14 28.44 28.74 29.05 29.35 29.65 29.95 30.25 30.55 30.85 31.16 31.46
#  [40] 31.76 32.06 32.36 32.66 32.96 33.27 33.57 33.87 34.17 34.47 34.77 35.08 35.38
#  [53] 35.68 35.98 36.28 36.58 36.88 37.19 37.49 37.79 38.09 38.39 38.69 38.99 39.30
#  [66] 39.60 39.90 40.20 40.50 40.80 41.11 41.41 41.71 42.01 42.31 42.61 42.91 43.22
#  [79] 43.52 43.82 44.12 44.42 44.72 45.03 45.33 45.63 45.93 46.23 46.53 46.83 47.14
#  [92] 47.44 47.74 48.04 48.34 48.64 48.94 49.25 49.55 49.85 50.15 50.45 50.75 51.06
# [105] 51.36 51.66 51.96 52.26 52.56 52.86 53.17 53.47 53.77 54.07 54.37 54.67 54.97
# [118] 55.28 55.58 55.88 56.18 56.48 56.78 57.09 57.39 57.69 57.99 58.29 58.59 58.89
# [131] 59.20 59.50 59.80 60.10 60.40 60.70 61.01 61.31 61.61 61.91 62.21 62.51 62.81
# [144] 63.12 63.42 63.72 64.02 64.32 64.62 64.92 65.23 65.53 65.83 66.13 66.43 66.73
# [157] 67.04 67.34 67.64 67.94 68.24 68.54 68.84 69.15 69.45 69.75 70.05 70.35 70.65
# [170] 70.95 71.26 71.56 71.86 72.16 72.46 72.76 73.07 73.37 73.67 73.97 74.27 74.57
# [183] 74.87 75.18 75.48 75.78 76.08 76.38 76.68 76.98 77.29 77.59 77.89 78.19 78.49
# [196] 78.79 79.10 79.40 79.70 80.00
```

Como es notorio, se puede coercer un texto que contenga "números" hacia numeric sin problema, dado que R, al quitarle las comillas a cada elemento, se encuentra con un valor numérico correcto.

<div class="question">
  1. Crea el vector `miPais` que contenga únicamente el nombre de tu país de residencia. Coerce `miPais`hacia vector numérico. ¿Notas la advertencia?
</div>

**Solución:**


```r
### Crear la variable
miPais <- "Peru"

### Coercer hacia número
as.numeric(miPais)
# Warning: NAs introduced by coercion
# [1] NA
```

La advertencia *NAs introduced by coercion* implica que como al quitar las comillas, lo que queda es una palabra en lugar de un número, R no puede darle valor numérico y lo reemplaza por un `NA`.

<div class="question">
  1. Crea una data frame llamada `DF10`, cuyo contenido sea: una columna numérica, otra de texto, y otra lógica, todas de 5 elementos. Coerce `DF10` hacia matriz. ¿Notas algo particular en los elementos de la matriz?
</div>

**Solución:**


```r
### Crear la variable
DF10 <- data.frame(
  COL1 = 1:5,
  COL2 = c("Text1", "Text2", "Text3", "Text4", "Text5"),
  COL3 = c(T, F, T, F, T)
)

### Coercer hacia matriz
as.matrix(DF10)
#      COL1 COL2    COL3   
# [1,] "1"  "Text1" "TRUE" 
# [2,] "2"  "Text2" "FALSE"
# [3,] "3"  "Text3" "TRUE" 
# [4,] "4"  "Text4" "FALSE"
# [5,] "5"  "Text5" "TRUE"
```

Todos los elementos de una matriz deben pertenecer a la misma clase. No puede haber matrices con columnas numérica y de texto a la vez. Aquí entra en juego el **concepto de supremacía de clase**. Esto aplica cuando la estructura hacia la cual se está coerciendo tiene como limitación el contener solo una clase de elementos (i.e., vectores y matrices).

- La clase carácter prima sobre las demás clases en el lenguaje R. En presencia de tan solo un elemento de texto, toda la matriz se convierte en elementos textuales.
- En ausencia de elementos de clase carácter, los elementos numéricos (decimales o enteros) priman sobre los lógicos. Los `TRUE` se convierten en 1, y los `FALSE` en 0.

<div class="question">
  1. Crea una lista que contenga los objetos: `muestr4`, `datosNumeros`,`DF10`. Para hacer el ejercicio replicable, respeta el orden mencionado. Luego, indexa las posiciones:
    <br>- Fila 2, columna 3 del objeto `DF10`.
    <br>- Elemento 150 del objeto `datosNumeros`.
    <br>- El elemento 5 del objeto `muestr4`.<br>
  <br>Realiza esto utilizando tanto una lista nombra (`list1`) como no nombrada (`list2`).
</div>

**Solución:**


```r
### Crear la lista nombrada
list1 <- dplyr::lst(muestr4, datosNumeros, DF10)

### Ubicar las indexaciones de la lista nombrada
list1$DF10$COL3[2]
# [1] FALSE
list1$datosNumeros[150]
# [1] 64.92
list1$muestr4[5]
# [1] 70.95

### Crear la lista no nombrada
list2 <- list(muestr4, datosNumeros, DF10)

### Ubicar las indexaciones de la lista no nombrada
list2[[3]][2,3]
# [1] FALSE
list2[[2]][150]
# [1] 64.92
list2[[1]][5]
# [1] 70.95
```

## Cap. 5: Programación funcional

<div class="question">
  1. Reproduce el resultado del siguiente loop `for`, utilizando la función replicate():


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

**Solución:**


```r
# Importante simplify = FALSE para obtener una lista 
# de vectores y no un solo vector con todos los resultados
set.seed(123)
lista1 <- replicate(3, {
  rnorm(6, 0, 1)
  }, 
  simplify = FALSE) 

### Resultado
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

**Solución:**


```r
### Crear función
cambiarNA <- function(x) {
  x[x == -999] <- NA
  print(x)
}

### Usar la función
cambiarNA(DF)
#    Var1    Var2    Var3    Var4    Var5
# 1  2.14    3.79    7.08    7.90    6.26
# 2  2.14    2.14    2.14    5.43 5555.00
# 3  7.90      NA    2.97      NA    1.32
# 4  1.32    7.08    0.50 5555.00    0.50
# 5  4.61 5555.00      NA    3.79    7.08
# 6    NA    7.08    5.43    5.43      NA
# 7  3.79    7.08    3.79    3.79    7.08
# 8  2.97    2.14 5555.00      NA    4.61
# 9  4.61    6.26    7.90    4.61    3.79
# 10 7.08    7.90    5.43    7.08    7.08
# 11 7.90    5.43    7.08    1.32    7.90
# 12   NA    7.90    7.08    3.79 5555.00

### Para guardar sus resultados permanentemente
resultados <- cambiarNA(DF)
#    Var1    Var2    Var3    Var4    Var5
# 1  2.14    3.79    7.08    7.90    6.26
# 2  2.14    2.14    2.14    5.43 5555.00
# 3  7.90      NA    2.97      NA    1.32
# 4  1.32    7.08    0.50 5555.00    0.50
# 5  4.61 5555.00      NA    3.79    7.08
# 6    NA    7.08    5.43    5.43      NA
# 7  3.79    7.08    3.79    3.79    7.08
# 8  2.97    2.14 5555.00      NA    4.61
# 9  4.61    6.26    7.90    4.61    3.79
# 10 7.08    7.90    5.43    7.08    7.08
# 11 7.90    5.43    7.08    1.32    7.90
# 12   NA    7.90    7.08    3.79 5555.00
resultados
#    Var1    Var2    Var3    Var4    Var5
# 1  2.14    3.79    7.08    7.90    6.26
# 2  2.14    2.14    2.14    5.43 5555.00
# 3  7.90      NA    2.97      NA    1.32
# 4  1.32    7.08    0.50 5555.00    0.50
# 5  4.61 5555.00      NA    3.79    7.08
# 6    NA    7.08    5.43    5.43      NA
# 7  3.79    7.08    3.79    3.79    7.08
# 8  2.97    2.14 5555.00      NA    4.61
# 9  4.61    6.26    7.90    4.61    3.79
# 10 7.08    7.90    5.43    7.08    7.08
# 11 7.90    5.43    7.08    1.32    7.90
# 12   NA    7.90    7.08    3.79 5555.00
```

  1. Utilizando la base de datos DF creada inicialmente en el ejercicio 2, modifica la función `cambiarNA()` para que no solo cambie `-999` a `NA`, sino que cambie cualquier valor que tú le proporciones con un argumento. Llama a esta función `cambiarNA2()`. Utilízala para reemplazar los valores `5555` a `NA`.

**Solución:**


```r
# Crear la función con un argumento extra que te 
# permita modificar el número a reemplazar por NA 
cambiarNA2 <- function(x, valor) {
  x[x == valor] <- NA
  print(x)
}

# Usar la función
cambiarNA2(DF, 5555)
#       Var1    Var2    Var3    Var4    Var5
# 1     2.14    3.79    7.08    7.90    6.26
# 2     2.14    2.14    2.14    5.43      NA
# 3     7.90 -999.00    2.97 -999.00    1.32
# 4     1.32    7.08    0.50      NA    0.50
# 5     4.61      NA -999.00    3.79    7.08
# 6  -999.00    7.08    5.43    5.43 -999.00
# 7     3.79    7.08    3.79    3.79    7.08
# 8     2.97    2.14      NA -999.00    4.61
# 9     4.61    6.26    7.90    4.61    3.79
# 10    7.08    7.90    5.43    7.08    7.08
# 11    7.90    5.43    7.08    1.32    7.90
# 12 -999.00    7.90    7.08    3.79      NA
```
  
  1. Utilizando la base de datos DF creada inicialmente en el ejercicio 2, modifica la función `cambiarNA2()` de tal manera que te permita definir más de un valor (un vector numérico) como elementos a ser reemplazados por `NA`. Llama a esta función `cambiarNA3()`. Cambia por `NA` los valores `-999` y `5555`. Pista: Esta función deberá contener un loop para aplicarle la función de cambio por NA a un elemento del vector a la vez en cada iteración.
  
  **Solución:**
  

```r
### Crear la función con un argumento que admita 
### un vector de varios elementos a cambiar por NA
cambiarNA3 <- function(x, vector) {
  for (i in seq_along(vector)) {
    x[x == vector[i]] <- NA
  }
  print(x)
}

### Usar la función
cambiarNA3(DF, c(5555, -999))
#    Var1 Var2 Var3 Var4 Var5
# 1  2.14 3.79 7.08 7.90 6.26
# 2  2.14 2.14 2.14 5.43   NA
# 3  7.90   NA 2.97   NA 1.32
# 4  1.32 7.08 0.50   NA 0.50
# 5  4.61   NA   NA 3.79 7.08
# 6    NA 7.08 5.43 5.43   NA
# 7  3.79 7.08 3.79 3.79 7.08
# 8  2.97 2.14   NA   NA 4.61
# 9  4.61 6.26 7.90 4.61 3.79
# 10 7.08 7.90 5.43 7.08 7.08
# 11 7.90 5.43 7.08 1.32 7.90
# 12   NA 7.90 7.08 3.79   NA
```
  

  1. Crea un loop `for` que itere sobre los números del 1 al 50 y calcule el cubo de cada número, de manera que los resultados se vayan guardando en un vector llamado `preliminar`. Luego, crea un segundo loop que te permita identificar y almacenar solamente los números menores a la mediana `median()` del conjunto de datos `preliminar` en un nuevo vector llamado `final`.
 
 **Solución:**
 

```r
### Secuencia numérica
secuencia <- 1:50

### Primer loop con for
preliminar <- c()
for(i in seq_along(secuencia)){
  preliminar[i] <- secuencia[i]^3
}

### Resultado preliminar
preliminar
#  [1]      1      8     27     64    125    216    343    512    729   1000   1331
# [12]   1728   2197   2744   3375   4096   4913   5832   6859   8000   9261  10648
# [23]  12167  13824  15625  17576  19683  21952  24389  27000  29791  32768  35937
# [34]  39304  42875  46656  50653  54872  59319  64000  68921  74088  79507  85184
# [45]  91125  97336 103823 110592 117649 125000

### Segundo loop con for
final <- c()
for( i in seq_along(preliminar)) {
  if(preliminar[i] <= median(preliminar)){
    final <- c(final, preliminar[i])
  }
}

### Resultado final
final
#  [1]     1     8    27    64   125   216   343   512   729  1000  1331  1728  2197
# [14]  2744  3375  4096  4913  5832  6859  8000  9261 10648 12167 13824 15625
```
  

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
  
  **Solución:**
  
  Dentro de la función necesitas:
  
  - Un código que calcule el promedio de los valores de `vector`.
  - Una estructura que le reste el promedio a cada elemento de `vector` y eleve cada resta al cuadrado.
  - Sumar todos los cuadrados obtenidos.
  - Identificar la longitud de `vector` (denotada por `n`), y dividir la sumatoria de cuadrados entre `n`.
  

```r
### Crear la función
var2 <- function(x) {
  promedio <- mean(x)
  cuadrados <- c()
  for(i in seq_along(x)) {
    valor <- (x[i] - promedio)^2
    cuadrados <- c(cuadrados, valor)
  }
  n <- length(x)
  sumatoria <- sum(cuadrados)
  varianza <- sumatoria / (n-1)
  return(varianza)
}

### Usar la función
var2(vector)
# [1] 2.195

### Comparar con la el resultado de var()
var(vector)
# [1] 2.195
```
  
  Si necesitas en algún momento, ya conoces cómo crear la fórmula de la varianza poblacional en R.

  1. Carga la base de datos npk. Usando una función de la familia apply(), calcula la el promedio, mediana y desviación estándar de la columna `yield` para cada categoría (numérica) de la columna `block`. Con ello, se conocerá el promedio de producción que se obtuvo en cada bloque para un estudio de mejora fitogenética:


```r
data("npk")
```
  
  **Solución:**
  

```r
tapply(npk$yield, npk$block, FUN = mean)
#     1     2     3     4     5     6 
# 54.02 57.45 60.77 50.12 50.52 56.35
tapply(npk$yield, npk$block, FUN = median)
#     1     2     3     4     5     6 
# 53.25 57.25 59.30 47.15 50.65 56.60
tapply(npk$yield, npk$block, FUN = sd)
#     1     2     3     4     5     6 
# 7.269 2.044 6.790 8.150 1.486 2.435
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
  
  **Solución:**
  

```r
lapply(iris3Lista, FUN = function(x) {
  apply(x, 2, mean)
})
# $setosa
# Sepal L. Sepal W. Petal L. Petal W. 
#    5.006    3.428    1.462    0.246 
# 
# $versicolor
# Sepal L. Sepal W. Petal L. Petal W. 
#    5.936    2.770    4.260    1.326 
# 
# $virginica
# Sepal L. Sepal W. Petal L. Petal W. 
#    6.588    2.974    5.552    2.026
```

</div>
