# **Programación Funcional e iteraciones**
## Control de flujo

## Creación de funciones {#creacion-fun}
La gran comunidad de desarrollo detrás de R ha creado una infinidad de funciones, almacenados en los miles de paquetes, o librerías, disponibles en el repositorio oficial `CRAN` y otras fuentes (ver sección [Librerías y repositorios](#librerías-y-repositorios). No obstante, algunas veces se necesita crear funciones personalizadas a los requerimientos del usuario. 

Cuando se detecta que algunas secuencias de órdenes se suelen repetir en el código, crear una función que empaquete dicha secuencia permitirá
_automatizar procedimientos y simplificar el código_. Como regla general, si copias y pegas una secuencia de órdenes para usarla más de 2 veces, ya se debería pensar en crear una función que compile la tarea. 

\BeginKnitrBlock{rmdnote}<div class="rmdnote">Crear un función involucra los siguientes pasos:

1. Darle un nombre. Crear una función es como crear una variable: hay que asignarle un contenido a un nombre.
2. Luego de escribir el nombre, se tiene que usar la función llamada `function()`para indicar qué argumentos tendrá la nueva función.
3. Definir el contenido de la función, la secuencia de órdenes, dentro de corchetes. Dentro de ellos se usarán los argumentos establecidos en `function()`.</div>\EndKnitrBlock{rmdnote}

Para crear una función que le sume 100 a un número, se puede usar:


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

Adicionalmente, se puede predefinir valores por defecto en `function()`, mismos que se podrán modificar al usar la función ya creada.


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

Como es notorio, se pueden crear variables dentro de una función, pero estas serán temporales. Una vez se imprime el resultado en consola, la variable desaparece. Para que algún paso realizado dentro de la función se guarde como una variable permanentemente en el ambiente, usa el símbolo especial `<<-`.


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


## `ifelse()`
## Iteraciones con for loops
## Aplicación de `purrr::map()`
