# (PART\*) SOLUCIONARIO {.unnumbered}

# **Solucionario de los ejercicios del libro**

Este capítulo extra del libro permitirá al lector revisar si las soluciones realizadas a los ejercicios de cada capítulo son correctos. Recuerda que no existe una única solución a un problema en R. Uno es libre de *programar las soluciones* según su propio pensamiento creativo, nivel de conocimiento del código y practicidad. 

Se recomienda no revisar este capítulo antes de realizar los ejercicios, principalmente para permitir que el alumno desarrolle su pensamiento lógico respecto al código en R. Recuerda que la práctica hace al maestro.
  
## Cap. 2: Primer contacto con R
<div class="question">
  1. Soluciona la ecuación $\sqrt({\frac{24+12}{(2 * 3)^3})}$.
</div>


```r
sqrt((24+12)/(2*3)^3)
# [1] 0.4082
```

<div class="question">
  1. Resuelve $\mathrm{log_{10}}(|\frac{\mathrm{exp(10)}^2}{-10*9^{6}}|)$. Las barras verticales implican aplicar valor absoluto antes de calcular el logaritmo en base 10.
</div>


```r
log10(abs((exp(10)**2)/(-10*(9^6))))
# [1] 1.96
```

<div class="question">
  1.La función sigmoidal $\sigma(\mathrm{z}) = \frac{1}{1+e^{-\mathrm{z}}}$ es muy importante en estadística. Permite convertir el resultado de una regresión logística (Odds ratios) en probabilidades, facilitando la interpretación. Utiliza la fórmula $z = -1.69 + 1*0.56$, emulando el resultado hipotético de una regresión logística, como insumo para calcular su probabilidad correspondiente utilizando la función sigmoidal. Como dato extra, el resultado de $\sigma(\mathrm{z})$ por 100 para convertirlo a probabilidad porcentual.
</div>


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
