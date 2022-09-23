# **Manejo de datos con** **tidyverse** {#tidyversecap}

En esta capítulo brindaremos las pautas de trabajo de uno de los paquetes más importantes para análisis de datos. Esta colección de paquetes ha sido diseñado para facilitar el flujo de trabajo en estadística y análisis de datos. Tareas recurrentes que se realizan con este objetivo son cubiertas por diferentes paquetes de tidyverse: importar datos, reordarlos, transformarlos y manipularlos para que estén listos para el análisis, y visualización. Los paquetes que pertenecen al núcleo de tidyverse se activan en la sesión de RStudio tras ejecutar `library(tidyverse)`. Estos son:

-   **readr**: carga de archivos orientada a producir tibbles.
-   **dplyr**: manipulación, arreglo y ordenamiento de bases de datos.
-   **ggplot2**: reconocida como la mejor librería de graficación estadística.
-   **tibble**: modernización de las capacidades de un data frame.
-   **tidyr**: complemento de **dplyr** limpieza de datos.
-   **purrr**: trabajo mejorado en programación funcional.
-   **stringr**: trabajo con cadenas de texto de una manera cohesiva y simple.
-   **forcats**: manejo de variables categóricas (factores).

Para más detalles, visita la página web de [tidyverse](https://www.tidyverse.org/packages/).

(ref:tidyverse1) Librerías de tidyverse y asociadas. Se ha creado una masiva cantidad de librerías que mejoran las particularidades de tidyverse para ofrecer una experiencia de usuario más completa en diferentes áreas:carga de datos, reordenamiento, transformación, programación, manipulación de datos, graficación, modelamiento y publicación.

<div class="figure" style="text-align: center">
<img src="figs/elaboradas/tidyverse universo.png" alt="(ref:tidyverse1)" width="100%" />
<p class="caption">(\#fig:figura49)(ref:tidyverse1)</p>
</div>

<br>

Más allá de los ocho paquetes núcleo de **tidyverse**, se ha desarrollado una gran batería de paquetes asociados, diseñados en el entorno de la sintaxis especial de esta librería. El ecosistema de **tidyverse** incluye librerías para la carga de bases de datos provenientes de softwares estadísticos (e.g., SPSS con **haven**), manejo de variables especiales (e.g., datos de fechas con **lubridate**), modelamiento estadístico (con **tidymodels**) y revisión de modelos (con **broom**). Otros paquetes se han desarrollado para cubrir funciones que interactúen en las pipelines (pipe original `%>%` del paquete **magrittr**), para crear código más legible (e.g., funciones de **rstatix**).

(ref:pipelineejemeplo1) Ejemplo del uso de pipe (`%>%`) en una pipeline para trabajar con tidyverse.

<div class="figure" style="text-align: center">
<img src="figs/screenshots/pipeline ejemplo.png" alt="(ref:pipelineejemeplo1)" width="100%" />
<p class="caption">(\#fig:figura50)(ref:pipelineejemeplo1)</p>
</div>

#### Activación de **tidyverse** {.unnumbered}

Para instalar **tidyverse** en tu equipo, ejecuta:


```r
install.packages("tidyverse")
```

Para activar **tidyverse**, ejecuta:


```r
library(tidyverse)
```

#### Resolver conflictos {.unnumbered}

Tras activar **tidyverse**, aparecerán en la consola los paquetes nucleo que estan siendo activados (**Attaching packages**) y los conflictos que tienen con otras librerías (**Conflicts**) (Figura \@ref(fig:conflictotidyverse)). Un **conflicto** significa que dentro de la librería activada (**tidyverse** en este caso) existen una o más funciones que tienen el mismo nombre que una función alojada en otra librería actualmente activa en la sesión de RStudio. El texto `dplyr::filter() masks stats::filter()` indica que la función `filter()` de la librería **dplyr** es idéntica en nombre a `filter()` de la librería **stats**.

(ref:conflictostidyverse) Vista previa de los conflictos detectados en consola tras la activación de la librería **tidyverse**.

<div class="figure" style="text-align: center">
<img src="figs/screenshots/conflictos tidyverse.jpg" alt="(ref:conflictostidyverse)" width="100%" />
<p class="caption">(\#fig:conflictotidyverse)(ref:conflictostidyverse)</p>
</div>

Para **resolver el conflicto**, cada vez que se use una función conflictiva se debe especificar la librería de origen con el operador `::`; el código debe ser como el siguiente: `dplyr::filter()`. R reconocerá que se está utilizando la función `filter()` del paquete **dplyr**.

## Datos ordenados (tidy) {#datosordenados}



Un gran porcentaje del tiempo que se suele emplear en el análisis de datos en R está dedicado a manipular objetos para su limpieza y preparación. Este lenguaje de programación necesita datos ordenados (del inglés **tidy**) para que su sintaxis de código funcione sin errores. Para R, datos ordenados implica tener objetos tabulares (2D) en los que:

-   Cada fila contenga información de una sola observación o unidad muestral (e.g., parcela, punto, transecto, paciente, placa, o el nombre que reciba su unidad muestral).
-   Cada columnas contenga una única variable de medición y esta sea independiente de las demás.

(ref:tidy1) Datos ordenados correctamente para analizar en R

<div class="figure" style="text-align: center">
<img src="figs/elaboradas/datos tidy.png" alt="(ref:tidy1)" width="100%" />
<p class="caption">(\#fig:figura51)(ref:tidy1)</p>
</div>

El estructurar las bases de datos de esta manera se puede hacer fuera del entorno de R, utilizando el gestor de hojas de cálculo de tu preferencia.

### ¿Qué evitar para tener datos tidy?

En principio, recordando que cada columna es una variable en las que cada fila solo podrá tener un solo valor, se deben evitar las siguientes situaciones:

(ref:excel1) Evitar poner encabezados (texto en negritas), comentarios o usar columnas que no contengan datos (texto resaltado). Celdas fusionadas (texto en rojo) generan problemas porque al cargarse en RStudio, las celdas se desagregan y dejan espacios en blanco.

<div class="figure" style="text-align: center">
<img src="figs/screenshots/excel1.jpg" alt="(ref:excel1)" width="100%" />
<p class="caption">(\#fig:figura52)(ref:excel1)</p>
</div>

(ref:excel2) Evitar colocar más de una variable de medición en una columna. En este caso, la columna `Status` contiene información de estado, categoría y nivel. Estas deben ser tratadas como variables independientes unas de otras.

<div class="figure" style="text-align: center">
<img src="figs/screenshots/excel2.jpg" alt="(ref:excel2)" width="100%" />
<p class="caption">(\#fig:figura53)(ref:excel2)</p>
</div>

(ref:excel3) Evitar nombres complejos como nombre de variable (columna). Al cargar en R, dependiendo de la función, los espacios en blanco entre palabras se autocorregirán por `.` o `_`. Es mejor modificar estos nombres para simplificarlos, acortarlos y evitar espacios en blanco.

<div class="figure" style="text-align: center">
<img src="figs/screenshots/excel3.jpg" alt="(ref:excel3)" width="100%" />
<p class="caption">(\#fig:figura54)(ref:excel3)</p>
</div>

(ref:excel4) Si una variable contiene categorías, es probable que en R la quieras tratar como factor para análisis o graficación. Evita nombres de categorías excesivamente largos o con símbolos extraños. Puedes asegurarte en convertirlos a categorías numéricas (1, 2, 3, etc.).

<div class="figure" style="text-align: center">
<img src="figs/screenshots/excel4.jpg" alt="(ref:excel4)" width="100%" />
<p class="caption">(\#fig:figura55)(ref:excel4)</p>
</div>

Como dato adicional. Trata de utilizar una sola hoja de cálculo por archivo. Facilitará la carga de datos.

### ¿Cómo se debe ver una base tidy?

Con todas las consideraciones mencionadas, una base de datos perfectamente tidy se vería:

(ref:excel5) Tabla de datos ordenada. Vista de hoja de cálculo.

<div class="figure" style="text-align: center">
<img src="figs/screenshots/excel5.jpg" alt="(ref:excel5)" width="100%" />
<p class="caption">(\#fig:figura56)(ref:excel5)</p>
</div>

Asumiendo que se está utilizando proyectos de RStudio, y que la base de datos `WHO_tidy.xlsx` existe dentro de dicha carpeta, el código para cargar la base datos en R es:


```r
WHO <- openxlsx::read.xlsx("WHO_tidy.xlsx")
```

(ref:excel6) Tabla perfectamente ordenada vista en RStudio.

<div class="figure" style="text-align: center">
<img src="figs/screenshots/excel6.jpg" alt="(ref:excel6)" width="100%" />
<p class="caption">(\#fig:figura57)(ref:excel6)</p>
</div>



## Introducción a `dplyr` y `tidyr`

En el universo de **tidyverse** existen dos asombrosa librerías para realizar limpieza y manejo de datos: `dplyr` y `tidyr`. De manera sencilla, las funciones más útiles que contienen son:


Table: (\#tab:unnamed-chunk-6)Funciones útiles para la limpieza y manejo de datos con **tidyr**.

Función        Descripción                                                             
-------------  ------------------------------------------------------------------------
`gather()`     Permite convertir una tabla ancha a una tabla larga                     
`spread()`     Permite convertir una tabla larga a una tabla ancha                     
`unite()`      Permite unir el contenido textual varias columnas en una sola.          
`separate()`   Permite separar el contenido textual de una columna en varias columnas. 
`drop_na()`    Elimina las filas que contengan NA en una tabla.                        


Table: (\#tab:unnamed-chunk-7)Funciones útiles para la limpieza y manejo de datos con **dplyr**.

Función             Descripción                                                                                             
------------------  --------------------------------------------------------------------------------------------------------
`filter()`          Filtra filas en base a criterios lógicos.                                                               
`select()`          Familia de funciones que permite seleccionar columnas por su nombre o indexación.                       
`group_by()`        Agrupa virtualmente las filas en base a una columna categórica.                                         
`arrange()`         Reordena verticalmente columnas, sea de menor a mayor o de A a Z.                                       
`arrange(desc())`   Reordena verticalmente columnas, sea de mayor a menor o de Z a A.                                       
`count()`           Cuenta las veces que cada valor se repite en una columna.                                               
`mutate()`          Familia de funciones que permite crear nuevas columnas o modificar las existentes.                      
`summarize()`       Familia de funcione generan resúmenes estadísticos.                                                     
`anti_join()`       Función para fusionar tablas A y B, devuelve las filas de A que no existen B.                           
`semi_join()`       Función para fusionar tablas A y B, devuelve las filas que existen en A y B. Puede duplicar filas de A. 
`inner_join()`      Función para fusionar tablas A y B, devuelve las filas que existen en A y B. No duplica filas de A.     
`full_join()`       Función para fusionar tablas A y B, devuelve todas las filas de A y B.                                  
`right_join()`      Función para fusionar tablas A y B, devuelve A más las filas de B que existan en A.                     
`left_join()`       Función para fusionar tablas A y B, devuelve B más las filas de A que existan en B.                     

## Pipelines con tidyverse

Cuando se inicia en el lenguaje de R, la manera intuitiva de aplicar secuencialmente varias funciones a una base de datos puede lucir así:


```r
Res1 <- Funcion1(BASE_DE_DATOS)
Res1 <- Funcion2(Res1)
Res3 <- Funcion3(Res2)
```

Pero existe un concepto para explorar en este contexto: anidar variables. Implica colocar funciones una dentro de otra de manera que la aplicación se hace de adentro hacia afuera: sobre `BASE_DE_DATOS` se aplicará `Funcion1()`; al resultado de ella, se aplicará `Funcion2()`; y al siguiente resultado, `Funcion3()`.


```r
Funcion3(Funcion2(Funcion1(BASE_DE_DATOS)))
```

Los programadores de la librería **magrittr** diseñaron un operador llamado *pipe*, en Español tubo, `%>%`. Este permite ir pasando el resultado de una función como primer argumento (o argumento de `data`) de la siguiente función. Este sencillo operador mejora enormemente la lectura y compresión del código, haciéndolo incluso más elegante. Con *pipe*, el ejemplo secuencial explicado arriba se convierte en:


```r
# Pipeline
BASE_DE_DATOS %>% 
  Funcion1() %>% 
  Funcion2() %>% 
  Funcion3()
```

La gran ventaja es que **tidyverse** ha sido diseñado en torno a la creación de *pipelines*, en Español tuberías. Siendo que todo se simplifica para su uso con estas librerías y otras que sean consideradas *pipe-friendly*, como **rstatix**. A lo largo del capítulo, se irá aplicando el concepto de tuberías para que te familiarices con su uso.

Como un ejemplo definitivo, así es como se crean *pipelines* que generen gráficos con **ggplot2** y **dplyr**:




```r
# Cargar la base de datos Boston
library(MASS)
data("Boston")

# Pipeline
Boston %>% 
  filter(rad %in% 1:3 & zn != 0) %>%
  group_by(tax) %>% 
  summarise(age_promedio = mean(age),
            rad = unique(rad)) %>% 
  mutate(tax = paste0("N_",tax),
         tax = as.factor(tax),
         rad = as.factor(rad)) %>% 
  ggplot(aes(x=reorder(tax, age_promedio), y=age_promedio, fill=rad))+
  geom_bar(stat="identity")+
  geom_text(aes(label=round(age_promedio,2)), color ="white",
            hjust = 1.1)+
  scale_y_discrete(expand = c(0,0,0,10))+
  scale_fill_manual(values = colorPal)+
  labs(x="Nivel de Tax", y="Edad promedio", fill="Grupo",
       title = "Edad promedio por nivel de Tax",
       subtitle = "Datos obtenidos de Boston (1969)")+
  coord_flip()+ 
  theme_minimal()+
  theme(legend.position = "bottom", 
        axis.ticks.length.y = unit(0, "cm"),
        legend.key.height = unit(0.2,"cm"),
        legend.key.width = unit(1.5, "cm"),
        title = element_text(face = 2))
```

<div class="figure" style="text-align: center">
<img src="06-tidyverse_files/figure-html/figura58-1.svg" alt="Ejemplo de código con ggplot2 y dplyr utilizando una pipeline." width="100%" />
<p class="caption">(\#fig:figura58)Ejemplo de código con ggplot2 y dplyr utilizando una pipeline.</p>
</div>

## Tablas anchas y largas con tidyr

En general, mucho de lo que se puede hacer en R necesita de tablas anchas. Este es el nombre que reciben las tablas que cumplen con ser *tidy* (ordenadas, revisa la [Sección 6.1 Datos ordenados](#datosordenados)):

-   cada columna es una variable.
-   cada fila es una observación.

(ref:anchasylargas1) Comparativa entre tabla ancha y larga, y las funciones para pasar de una estructura a otra.

<div class="figure" style="text-align: center">
<img src="figs/elaboradas/tablas ancha y larga.png" alt="(ref:anchasylargas1)" width="100%" />
<p class="caption">(\#fig:figura59)(ref:anchasylargas1)</p>
</div>

### De ancha a larga

En ciertas ocasiones, trabajar con tablas largas es lo que necesitamos para analizar o generar gráficos con los datos. La función `gather()` de la librería **tidyr** permite convertir una tabla ancha en larga, apilando dos o más variables en tan solo dos columnas: una de etiquetas (argumento `key`) y una de valores o contenidos de las celdas (argumento `value`). La estructura básica es:


```r
gather(DF,             # base de datos
       key = "COL1",   # nombre de la futura columna de etiquetas
       value = "COL2", # nombre de la futura columna de valores
       COL3:COL4)      # columnas a apilar (e.g, posiciones 3:4)
```

::: {.example} 
Considera la tabla `mice2`:


```r
# install.packages("datarium")
library(datarium)
data("mice2")

# Ver el contenido
mice2
#    id before after
# 1   1  187.2 429.5
# 2   2  194.2 404.4
# 3   3  231.7 405.6
# 4   4  200.5 397.2
# 5   5  201.7 377.9
# 6   6  235.0 445.8
# 7   7  208.7 408.4
# 8   8  172.4 337.0
# 9   9  184.6 414.3
# 10 10  189.6 380.3
```

`mice2` es una tabla ancha. Para apilar sus columnas `before` y `after` en una nueva columna llamada `Tiempo`, mientras que sus valores se apilan en `Valores`, se tiene:


```r
# Utilizar gather() para apilar las columnas 2 y 3
# en las columnas Tiempo (etiquetas) y Valor (valores)
ratones_larga <- gather(mice2, key="Tiempo", value="Valor", 2:3)

# Ver el contenido
ratones_larga
#    id Tiempo Valor
# 1   1 before 187.2
# 2   2 before 194.2
# 3   3 before 231.7
# 4   4 before 200.5
# 5   5 before 201.7
# 6   6 before 235.0
# 7   7 before 208.7
# 8   8 before 172.4
# 9   9 before 184.6
# 10 10 before 189.6
# 11  1  after 429.5
# 12  2  after 404.4
# 13  3  after 405.6
# 14  4  after 397.2
# 15  5  after 377.9
# 16  6  after 445.8
# 17  7  after 408.4
# 18  8  after 337.0
# 19  9  after 414.3
# 20 10  after 380.3
```
::: 

### De larga a ancha

Apilar variables en tablas largas es muy frecuente en procesos de toma de datos, quizá por facilidad o rapidez en el almacenamiento de los mismos durante los estudios. La función `spread()` permite dispersar datos partiendo de dos columnas: una de etiquetas apiladas (`key`) y otra de valores apilados (`values`), hacia las columnas que sean necesarias (igual a la cantidad de niveles en `key`). La estructura básica es:


```r
spread(DF,           # base de datos
       key = COL1,   # columna de etiquetas
       value = COL2) # columna de valores
```

::: {.example} 
Considera la tabla `ratones_larga` obtenida en el ejemplo anterior:


```r
# Utilizar gather() para apilar las columnas 2 y 3
# en las columnas Tiempo (etiquetas) y Valor (valores)
spread(ratones_larga, key=Tiempo, value=Valor)
#    id after before
# 1   1 429.5  187.2
# 2   2 404.4  194.2
# 3   3 405.6  231.7
# 4   4 397.2  200.5
# 5   5 377.9  201.7
# 6   6 445.8  235.0
# 7   7 408.4  208.7
# 8   8 337.0  172.4
# 9   9 414.3  184.6
# 10 10 380.3  189.6
```
:::

## Filtrado

Conocer cómo filtrar correctamente una base de datos es fundamental en el manejo de bases de datos. Implica escoger del total de filas solo aquellas que cumplan con ciertos criterios lógicos. 

### Procedimiento de filtrado

**Primer paso:** saber qué se va a filtrar. Por ejemplo: en la base de datos `DF` se desea filtrar solo aquellas filas que en la columna A tengan valores mayores iguales a 5.32. 

**Segundo paso:** formalizar la petición en sintaxis de R, utilizando  operadores lógicos y/o relacionales. Para escribir en R *"todos los valores de un vector A mayor igual a 5.32"*, colocamos:


```r
A >= 5.32
```

**Tercer paso:** incluir esta petición lógica en la función de filtrado de **dplyr**:


```r
DF %>% filter(A >= 5.32)
```

### Aplicaciones de filtrado

Considera la base de datos `WHO_tidy.xlsx`:




```r
WHO <- openxlsx::read.xlsx("WHO_tidy.xlsx")
```

::: {.example}
Filtrar únicamente las filas de la categoría `Category B` columna  `Category`.
¿Cuál es el porcentaje de filas que tiene esta nueva base de datos respecto a la original?


```r
# Número de filas de WHO
nrow(WHO)
# [1] 2938

# Filtrado
WHO1 <- WHO %>% filter(Category == "Category B")

# Número de filas de WHO1
nrow(WHO1)
# [1] 963

# Porcentaje de filas en WHO1 respecto a WHO
(nrow(WHO1) / nrow(WHO)) * 100
# [1] 32.78
```
:::

Para incorporar más de una condición relacional, utiliza los operadores lógicos "y" `&` u "o" `|`. 

::: {.example}
Filtrar únicamente las filas con cumplan con tener `Category B` en la columna `Category` y Level 1 en la columna `Level`. Calcular el número de filas de la tabla:


```r
WHO %>% 
  filter(Category == "Category B" & Level == "Level 1") %>% 
  nrow()
# [1] 309
```
:::

Cuando se necesita filtrar más de un nivel para una columna, se utiliza el operador `%in%` (ver [sección 2.3 Operadores lógicos y relacionales](#operadores-lógicos-y-relacionales)). Cuando se deba filtrar todos los niveles excepto uno, es más sencillo el proceso utilizando el operador `!=`.

::: {.example}
Filtrar las categorías `Category A` y `Category B` en la columna `Category`, además de y Level 1 en la columna `Level`. Calcular el número de filas de la tabla:


```r
WHO %>% 
  filter(Category %in% c("Category A", "Category B") & Level == "Level 1") %>% 
  nrow()
# [1] 645
```
:::

Como era de esperar, ahora hay más filas en la tabla filtrada. 

::: {.example}
Considera adicionar una tercer condición lógica al ejemplo anterior. Esta vez, se requiere filtrar aquellas filas que con valores de expectativa de vida (columna `Life_exp`) mayor a 60:


```r
WHO %>% 
  filter(Category %in% c("Category A", "Category B") & Level == "Level 1" & Life_exp > 80) %>% 
  nrow()
# [1] 49
```
:::

::: {.example}
Aprovechemos a adicionar una cuarta condición de filtrado: años (columna `Year`) 2013 a 2015.


```r
WHO %>% 
  filter(Category %in% c("Category A", "Category B")) %>%  
  filter(Level == "Level 1" & Life_exp > 80) %>% 
  filter(Year %in% 2013:2015) %>% 
  nrow()
# [1] 18
```
:::

## Selección

Al igual que con el filtrado de filas, una sola función para seleccionar columnas, `select()`. La función devuelve solo las columnas seleccionadas, ya sea utilizando sus nombres o su indexación de posición. El orden en el que coloques las columnas dentro de la función será el orden en el que aparecerán en el resultado final.

\BeginKnitrBlock{rmdtip}<div class="rmdtip">A partir de la reciente versión de R 4.1.3., en algunos equipos es necesario colocar `dplyr::select()` en lugar de simplemente usar `select()`. Si en tu equipo funciona directamente `select()`, no te preocupes en mencionar de qué paquete procede.</div>\EndKnitrBlock{rmdtip}

::: {.example}
Considerando la base de datos `WHO`, seleccionar las columnas `Country`, `Year`, `Polio`, `Diph`, utilizando posición y nombre. Mostrar las primeras 6 filas.


```r
# Por posición
WHO %>% 
  dplyr::select(1,2,17,18) %>% 
  head()
#       Country Year Polio Tot_exp
# 1 Afghanistan 2015     6    8.16
# 2 Afghanistan 2014    58    8.18
# 3 Afghanistan 2013    62    8.13
# 4 Afghanistan 2012    67    8.52
# 5 Afghanistan 2011    68    7.87
# 6 Afghanistan 2010    66    9.20

# Por nombre
WHO %>% 
  dplyr::select(Country, Year, Polio, Diph) %>% 
  head()
#       Country Year Polio Diph
# 1 Afghanistan 2015     6   65
# 2 Afghanistan 2014    58   62
# 3 Afghanistan 2013    62   64
# 4 Afghanistan 2012    67   67
# 5 Afghanistan 2011    68   68
# 6 Afghanistan 2010    66   66
```
:::

Lo más complicado de indexar por posición es justamente saber el número exacto de cada columna. En cualquiera de los casos, revisar los nombres de columnas se puede realizar con `names()`:


```r
names(WHO)
#  [1] "Country"    "Year"       "Status1"    "Category"   "Level"      "Status2"   
#  [7] "St2_categ"  "Life_exp"   "Ad_mort"    "Inf_deaths" "Alcohol"    "Per_exp"   
# [13] "Hep_B"      "Measles"    "BMI"        "U5Y"        "Polio"      "Tot_exp"   
# [19] "Diph"       "AIDS"       "GDP"        "Pop"        "Thin1_19"   "Thin5_9"   
# [25] "Income"     "Schooling"
```

### Seleccionar con funciones especiales

Para aprovechar al máximo la función `select()`, se puede incluir en ella funciones de selección específicas con funciones de ayuda. 


Table: (\#tab:unnamed-chunk-29)Funciones de selección específicas utilizando funciones de ayuda

Función                             Descripción                                                 
----------------------------------  ------------------------------------------------------------
`select(DF, contains("."))`         Selecciona las columnas cuyo nombre contengan ese carácter. 
`select(DF, num_range("a", 1:5))`   Selecciona las columnas a1, a2, a3, a4, y a5.               
`select(DF, starts_with("XYZ"))`    Selecciona las columnas cuyo nombre comience con "XYZ".     
`select(DF, ends_with("XYZ"))`      Selecciona las columnas cuyo nombre termina en "XYZ".       
<br>

::: {.example}
Seleccionar todas las columnas que contengan el carácter `_`. Mostrar las primeras 6 filas.


```r
WHO %>% 
  dplyr::select(contains("_")) %>% 
  head()
#   St2_categ Life_exp Ad_mort Inf_deaths Per_exp Hep_B Tot_exp Thin1_19 Thin5_9
# 1         1     65.0     263         62  71.280    65    8.16     17.2    17.3
# 2         2     59.9     271         64  73.524    62    8.18     17.5    17.5
# 3         2     59.9     268         66  73.219    64    8.13     17.7    17.7
# 4         1     59.5     272         69  78.184    67    8.52     17.9    18.0
# 5         2     59.2     275         71   7.097    68    7.87     18.2    18.2
# 6         1     58.8     279         74  79.679    66    9.20     18.4    18.4
```
:::

La función `num_range("TEXTO", RANGO)` crea un vector de caracteres de la misma manera que lo hace `paste0()`. La diferencia es que `num_range()` solo funciona dentro de `select()`.

```r
# Resultado de paste0() idéntico a lo que se obtendría con num_range()
paste0("Status", 1:5)
# [1] "Status1" "Status2" "Status3" "Status4" "Status5"
```

::: {.example}
Seleccionar todas las columnas `Status1` y `Status2` con la función `num_range()`. Mostrar las primeras 6 filas. 


```r
# Con num_range()
WHO %>% 
  dplyr::select(num_range("Status", 1:2)) %>% 
  head()
#      Status1                                       Status2
# 1 Developing Developing in an inconsisten rate of increase
# 2 Developing          No deteminated by the OMS, but is OK
# 3 Developing          No deteminated by the OMS, but is OK
# 4 Developing Developing in an inconsisten rate of increase
# 5 Developing          No deteminated by the OMS, but is OK
# 6 Developing Developing in an inconsisten rate of increase

# Con paste0()
WHO %>% 
  dplyr::select(paste0("Status", 1:2)) %>% 
  head()
#      Status1                                       Status2
# 1 Developing Developing in an inconsisten rate of increase
# 2 Developing          No deteminated by the OMS, but is OK
# 3 Developing          No deteminated by the OMS, but is OK
# 4 Developing Developing in an inconsisten rate of increase
# 5 Developing          No deteminated by the OMS, but is OK
# 6 Developing Developing in an inconsisten rate of increase
```
:::

\BeginKnitrBlock{rmdnote}<div class="rmdnote">Las dos funciones que se verán a continuación permiten seleccionar utilizando una o varias letras iniciales o finales de cada nombre. La búsqueda no es sensible a si la letra es mayúscula o minúscula.</div>\EndKnitrBlock{rmdnote}

::: {.example}
Seleccionar las columnas **cuyo nombre comience con** la letra S. Mostrar las primeras 6 filas.


```r
# Con num_range()
WHO %>% 
  dplyr::select(starts_with("S")) %>% 
  head()
#      Status1                                       Status2 St2_categ Schooling
# 1 Developing Developing in an inconsisten rate of increase         1      10.1
# 2 Developing          No deteminated by the OMS, but is OK         2      10.0
# 3 Developing          No deteminated by the OMS, but is OK         2       9.9
# 4 Developing Developing in an inconsisten rate of increase         1       9.8
# 5 Developing          No deteminated by the OMS, but is OK         2       9.5
# 6 Developing Developing in an inconsisten rate of increase         1       9.2
```
:::

::: {.example}
Seleccionar las columnas **cuyo nombre termine con** la letra o. Mostrar las primeras 6 filas. 


```r
# Con num_range()
WHO %>% 
  dplyr::select(ends_with("o")) %>% 
  head()
#   Polio
# 1     6
# 2    58
# 3    62
# 4    67
# 5    68
# 6    66
```
:::

## Agrupamiento

La función `group_by()` genera **agrupamientos virtuales**. Divide a una base de datos en función de una columna categórica (factor), pero esta división no se almacena como tal. Si se escogiera como columna de agrupamiento un factor con tres niveles, no esperes ver como resultado tres tablas, cada una con las filas de cada nivel. Este agrupamiento virtual solo permite que las siguientes funciones de la *pipeline* traten por separado a cada nivel.

Esto es muy útil cuando se debe generar resúmenes estadísticos, por ejemplo promedio y desviación estándar, de variables separado por niveles de un factor en la tabla.

En el siguiente ejemplo solo veremos la agrupación, visible como un dato extra mostrado en consola impreso encima la tabla. Más adelante se usará agrupamiento dentro de una *pipeline* más realista.

\BeginKnitrBlock{rmdwarning}<div class="rmdwarning">Es **importante desagrupar** una vez que se acabaron los cálculos hechos con la pipeline. El no colocar `ungroup()` al final producirá errores cuando más adelante se usa la base de datos resultante en otras *pipelines*. Nunca dejes un `group_by()` sin desagrupar al final.</div>\EndKnitrBlock{rmdwarning}

::: {.example}
Seleccionar las columnas `Country`, `Year`, `Polio`, `Diph`, y agrupar la base de datos `WHO` por año (columna `Year`). Mostrar las primeras 6 filas.


```r
# Para este ejemplo no usaremos ungroup()
# con la finalidad de mostrar el resultado
# textual que aparece sobre una tabla agrupada
# indicando los grupos >> Groups:   Year [6]
WHO %>% 
  dplyr::select(Country, Year, Polio, Diph) %>%
  group_by(Year) %>% 
  head()
# # A tibble: 6 × 4
# # Groups:   Year [6]
#   Country      Year Polio  Diph
#   <chr>       <dbl> <dbl> <dbl>
# 1 Afghanistan  2015     6    65
# 2 Afghanistan  2014    58    62
# 3 Afghanistan  2013    62    64
# 4 Afghanistan  2012    67    67
# 5 Afghanistan  2011    68    68
# 6 Afghanistan  2010    66    66
```
:::

\BeginKnitrBlock{rmdnote}<div class="rmdnote">Si estas seleccionando y luego agrupando, asegúrate de que la columna de agrupamiento esté dentro de las seleccionadas. La función antagonista de `group_by()` es `ungroup()`.</div>\EndKnitrBlock{rmdnote}

## Conteo

La función de conteo es muy sencilla. Utilizar `count()` brinda el número de veces que cada nivel de una columna del tipo factor aparece en la misma.

::: {.example}
Considerando la base de datos `WHO`, filtrar la base para que aparezcan solo las filas que tengan valores mayor igual a 80 de expectativa de vida (columna `Life_exp`). Realizar un conteo de la veces que cada año (columna `Year`) aparece en la base de datos. Año es una variable numérica de valores enteros, y puede ser tratada como factor.


```r
WHO %>% 
  filter(Life_exp >= 80) %>% 
  count(Year)
#    Year  n
# 1  2000  1
# 2  2001  3
# 3  2002  4
# 4  2003  5
# 5  2004 10
# 6  2005 12
# 7  2006 12
# 8  2007 15
# 9  2008 18
# 10 2009 21
# 11 2010 23
# 12 2011 25
# 13 2012 28
# 14 2013 29
# 15 2014 29
# 16 2015 29
```
:::

Es notable, ahora, que con el pasar de los años la cantidad de filas con expectativa mayor igual a 80 años ha ido incrementando. Es una respuesta a que la calidad de vida ha mejorado en el mundo.

## Resúmenes estadísticos

Realizar resúmenes estadísticos es uno de los grandes motivos de aprender a trabajar con *pipelines*. Puede aplicarse promedio `mean()`, mediana `median()`, desviación estándar `sd()`, varianza `var()`, suma `sum()`, mínimo `min()`, máximo `max()`, además de cualquier función existente o creada siempre y cuando el resultado de dichas funciones sea un único valor (es decir, un vector de un elemento). 

El resultado final de cualquier función de la familia de `summarise()` es una tabla conteniendo las columnas que se solicitaron como resumen estadístico. La estructura base es:


```r
BASE_DE_DATOS %>% ... %>% 
  summarise(COLUMNA_NUEVA = FUNCION_ESTADÍSTICA(COLUMNA_ANTIGUA))
```

\BeginKnitrBlock{rmdtip}<div class="rmdtip">Las funciones estadísticas como `mean()`, `median()` y las demás mencionadas arriba, tienen problemas lidiando con valores `NA`. Si se calcula el promedio de una columna que se conoce contiene `NA`, se debe colocar el argumento `na.rm = TRUE` dentro de cada función para hacer esta obvie los `NA` y calcule el estimados estadístico deseado. Por ejemplo `mean(vector, na.rm = TRUE)`.</div>\EndKnitrBlock{rmdtip}

<br>

::: {.example} 
Considerando la base de datos `WHO`, calcular el promedio de la columna `Life_exp`, la mediana de la columna `Polio`, y el promedio y desviación estándar de `GDP`. Agrupa previamente por año (columna `Year`). 


```r
# Sin consideraro los NA
WHO %>% 
  group_by(Year) %>% 
  summarise(Promed = mean(Life_exp),
            Pol = median(Polio),
            GDP_prom = mean(GDP),
            GDP_sd = sd(GDP)) %>% 
  ungroup()
# # A tibble: 16 × 5
#    Year Promed   Pol GDP_prom GDP_sd
#   <dbl>  <dbl> <dbl>    <dbl>  <dbl>
# 1  2000   66.8    NA       NA     NA
# 2  2001   67.1    NA       NA     NA
# 3  2002   67.4    NA       NA     NA
# 4  2003   67.4    NA       NA     NA
# 5  2004   67.6    NA       NA     NA
# 6  2005   68.2    NA       NA     NA
# # … with 10 more rows
```


```r
# Especificando el argumento na.rm = TRUE 
# para obviar los NA de cada columna
WHO %>% 
  group_by(Year) %>% 
  summarise(Promed = mean(Life_exp, na.rm = TRUE),
            Pol = median(Polio, na.rm = TRUE),
            GDP_prom = mean(GDP, na.rm = TRUE),
            GDP_sd = sd(GDP, na.rm = TRUE)) %>% 
  ungroup()
# # A tibble: 16 × 5
#    Year Promed   Pol GDP_prom GDP_sd
#   <dbl>  <dbl> <dbl>    <dbl>  <dbl>
# 1  2000   66.8    88    4709.  9182.
# 2  2001   67.1    89    4855.  8892.
# 3  2002   67.4    91    4599.  8541.
# 4  2003   67.4    91    4775.  9144.
# 5  2004   67.6    91    7056. 13504.
# 6  2005   68.2    93    7250. 13107.
# # … with 10 more rows
```
:::

### Otras funciones de la familia `summarise()`

En dplyr existen algunas funciones que tienen versiones similares a ellas. Consideremos esta agrupaciones como familias de funciones. En estas familias, como la de `summarise()`, encontrarás funciones de aplicación específica:


Table: (\#tab:unnamed-chunk-44)Funciones de la familia `summarise()`

Función              Descripción                                                                                                                                                           
-------------------  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
`summarise()`        Permite realizar resúmenes estadísticos especificados columna a columna.                                                                                              
`summarise_all()`    Permite realizar resúmenes estadísticos aplicando una o más funciones a todas las columnas de la tabla.                                                               
`summarise_at()`     Permite realizar resúmenes estadísticos aplicando una o más funciones a un grupo de columnas de la tabla.                                                             
`summarise_if()`     Permite realizar resúmenes estadísticos aplicando una o más funciones si se cumple una condición lógica definida.                                                     
`summarise_each()`   Idéntica a `summarise_all()` es considerada obsoleta (deprecated).                                                                                                    
Variantes            Algunas funciones tienes variantes escritas con "\_" al final o con la palabra summarize (con z), hacen lo mismo que las originales sin "\_" o con summarise (con s). 

<br>

#### `summarise_all()`

Aplicará la o las funciones especificadas a todas las columnas. Si alguna columna no cumple con lo necesario para se analizada (por ejemplo: intentar obtener el promedio de una columna categórica), se genera error. Asegúrate de que la tabla por completo es analizable, o utiliza la función de **dplyr** `select()` para seleccionar las columnas de trabajo antes de aplicar `summarise_all()`. La estructura básica es:


```r
BASE_DE_DATOS %>% 
  summarise_all(.funs = lst(LISTA_DE_FUNCIONES))
```

::: {.example #summariseall}
Obtener el promedio, y varianza de las columnas `GDP`, `Life_exp` y `Pop` por país de Colombia, México y Perú (recuerda que la base tiene estos nombres en inglés).


```r
WHO %>% 
  filter(Country %in% c("Colombia","Mexico","Peru")) %>% 
  group_by(Country) %>% 
  dplyr::select(GDP, Life_exp, Pop) %>% 
  summarise_all(.funs = lst(mean, var), 
                na.rm=TRUE)%>% 
  ungroup()
# Adding missing grouping variables: `Country`
# # A tibble: 3 × 7
#   Country  GDP_mean Life_exp_mean  Pop_mean   GDP_var Life_exp_var Pop_var
#   <chr>       <dbl>         <dbl>     <dbl>     <dbl>        <dbl>   <dbl>
# 1 Colombia    3322.          73.3 31767433.  7555129.        1.16  4.08e14
# 2 Mexico      5179.          75.7 27585265. 15368266.        0.386 2.02e15
# 3 Peru        2929.          73.7 16854322.  5660203.        1.64  1.77e14
```
:::

#### `summarise_at()`

Otra función muy útil al momento de aplicar diferentes funciones estadísticas a varias columnas es `summarise_at()`. Esta función permite seleccionar las columnas de trabajo, como si incorporara su propia función `select()`. La estructura básica es:


```r
BASE_DE_DATOS %>% 
  summarise_at(.vars = vars(COLUMNAS_DE_TRABAJO),
               .funs = lst(LISTA_DE_FUNCIONES))
```

::: {.example}
Siguiendo el ejemplo \@ref:(exm:summariseall), recrear el resultado utilizando `summarise_at()`:


```r
WHO %>% 
  filter(Country %in% c("Colombia","Mexico","Peru")) %>% 
  group_by(Country) %>% 
  summarise_at(.vars = vars(GDP, Life_exp, Pop), 
               .funs = lst(mean, median, sd),  
               na.rm=TRUE)%>% 
  ungroup()
# # A tibble: 3 × 10
#   Country  GDP_mean Life_exp…¹ Pop_m…² GDP_m…³ Life_…⁴ Pop_m…⁵ GDP_sd Life_…⁶ Pop_sd
#   <chr>       <dbl>      <dbl>   <dbl>   <dbl>   <dbl>   <dbl>  <dbl>   <dbl>  <dbl>
# 1 Colombia    3322.       73.3  3.18e7   2434.    73.5  4.30e7  2749.   1.08  2.02e7
# 2 Mexico      5179.       75.7  2.76e7   6976.    75.6  1.15e7  3920.   0.621 4.50e7
# 3 Peru        2929.       73.7  1.69e7   2601.    73.8  2.61e7  2379.   1.28  1.33e7
# # … with abbreviated variable names ¹​Life_exp_mean, ²​Pop_mean, ³​GDP_median,
# #   ⁴​Life_exp_median, ⁵​Pop_median, ⁶​Life_exp_sd
```
:::

#### `summarise_if()`

Aplicar condicionales para seleccionar columnas es muy útil. Esta función permite indicar una condición lógica con funciones de la familia `is()`, como `is.numeric()` que haría la petición de seleccionar solo las funciones numéricas y sobre todas ellas aplicar alguna función estadística. La estructura básica es:


```r
BASE_DE_DATOS %>% 
  summarise_if(.predicate = FUNCIÓN_IS_SIN_PARÉNTESIS,
               .funs = lst(LISTA_DE_FUNCIONES))
```

::: {.example}
Realizar el promedio y desviación estándar de las columnas numéricas que existan entre las siguientes: `GDP`, `Life_exp`, `Pop`, `Status1`, `Status2`; agrupando por país para Colombia, México y Perú (recuerda que la base tiene estos nombres en inglés):


```r
WHO %>% 
  filter(Country %in% c("Colombia","Mexico","Peru")) %>% 
  group_by(Country) %>% 
  dplyr::select(GDP, Life_exp, Pop, Status1, Status2) %>% 
  summarise_if(is.numeric, 
               .funs = lst(mean, sd),  
               na.rm=TRUE)%>% 
  ungroup()
```
:::

## Reordenamiento

El concepto detrás de la función `arrange()` es el de brindarle un orden numérico (menor a mayor) o alfabético (A a la Z) a una columna. Si se desea el orden inverso, sea numérico o alfabético, utiliza `arrange(desc())`.

::: {.example}
Filtrar las filas con `GDP` mayor a 70000 y menores de 100000, agrupar por país (columna `Country`) y obtener el promedio y desviación estándar de `GDP`. Reordenar de mayor a menor en base al promedio.


```r
WHO %>% 
  filter(GDP >= 70000 & GDP <= 100000) %>% 
  group_by(Country) %>% 
  summarise_at(.vars = vars(GDP), .funs = lst(mean, sd), na.rm = TRUE) %>% 
  arrange(desc(mean))
# # A tibble: 4 × 3
#   Country       mean    sd
#   <chr>        <dbl> <dbl>
# 1 Qatar       86083. 2344.
# 2 Luxembourg  82728. 9916.
# 3 Norway      82297. 7197.
# 4 Switzerland 81339. 6536.
```
:::

## Creación y transformación de columnas

Las funciones de la familia `mutate()` simplifican enormemente el proceso de crear columnas en la base de datos. Algo muy interesante es que es posible aplicar una transformación a una columna que se está creando o modificando dentro de la misma función de `mutate()` y `transmute()` (revisa la `COL_NUEVA4` en el siguiente código). La estructura base es:


```r
# Usando mutate()
BASE_DE_DATOS %>% ... %>% 
  mutate(COL_NUEVA1 = FUNCION_DE_TRANSFORMACION(COL_ANTIGUA1),
         COL_NUEVA2 = FUNCION_DE_TRANSFORMACION(COL_ANTIGUA2),
         COL_NUEVA3 = FUNCION_DE_TRANSFORMACION(COL_ANTIGUA3),
         COL_NUEVA4 = FUNCION_DE_TRANSFORMACION(COL_NUEVA1))

# Usando transmute()
BASE_DE_DATOS %>% ... %>% 
  transmute(COL_NUEVA1 = FUNCION_DE_TRANSFORMACION(COL_ANTIGUA1),
         COL_NUEVA2 = FUNCION_DE_TRANSFORMACION(COL_ANTIGUA2),
         COL_NUEVA3 = FUNCION_DE_TRANSFORMACION(COL_ANTIGUA3),
         COL_NUEVA4 = FUNCION_DE_TRANSFORMACION(COL_NUEVA1))
```

\BeginKnitrBlock{rmdtip}<div class="rmdtip">El resultado de transformación con `transmute()` es el mismo, excepto que las nuevas columnas aparecerán solitarias en su propia tabla, separadas de la original. Con `mutate()`, las nuevas columnas aparecen adjuntas a la derecha de la última columna dentro de la tabla original.</div>\EndKnitrBlock{rmdtip}

::: {.example #summariseall}
Se pretende ejemplificar un nuevo índice de la relación Poliomielitis - Sarampión utilizando la fórmula:

$$MP = 0.00001*\frac{\sqrt{\text{#Casos de Sarampión}}}{0.39*\text{#Casos de Polio}^2} $$

Crear la nueva columna MP operando las columnas `Measles` para Sarampión y `Polio` para Poliomielitis. Por motivos del ejemplo, seleccionar previamente únicamente las columnas de trabajo, junto con `Country` y `Year` para identificar en qué países y qué años se tuvo un mayor valor del índice. Reordenar la columna `MP` de modo descendente y mostrar las primeras 10 filas.


```r
# con mutate()
WHO %>% 
  dplyr::select(Measles, Polio, Country, Year) %>% 
  mutate(MP = (0.00001*(sqrt(Measles) / 0.39 * Polio^2))) %>% 
  arrange(desc(MP)) %>% 
  head(10)
#    Measles Polio                          Country Year    MP
# 1   131441    99                            China 2008 91.11
# 2   109023    94                            China 2007 74.81
# 3    99602    94                            China 2006 71.50
# 4   124219    87                            China 2005 68.40
# 5   118712    86                           Malawi 2010 65.34
# 6    52628    99                            China 2014 57.65
# 7    52461    99                            China 2009 57.56
# 8    90387    86                            India 2015 57.01
# 9    88962    86                            China 2001 56.56
# 10  133802    77 Democratic Republic of the Congo 2011 55.61

# con transmute(), no es necesario seleccionar 
# debido a que solo se mostrará la columna creada
WHO %>% 
  transmute(MP = (0.00001*(sqrt(Measles) / 0.39 * Polio^2))) %>% 
  arrange(desc(MP)) %>% 
  head(10)
#       MP
# 1  91.11
# 2  74.81
# 3  71.50
# 4  68.40
# 5  65.34
# 6  57.65
# 7  57.56
# 8  57.01
# 9  56.56
# 10 55.61
```

:::


Table: (\#tab:unnamed-chunk-55)Funciones de la familia `mutate()` y `transmute()`

Función              Descripción                                                                                                                                  
-------------------  ---------------------------------------------------------------------------------------------------------------------------------------------
`mutate()`           Crea o modifica columnas especificadas una por una. El resultado muestra todas las columnas de la tabla original.                            
`transmute()`        Crea o modifica columnas especificadas una por una. El resultado solo muestra las columnas creadas o modificadas.                            
`mutate_all()`       Aplica una modificación a todas  las columnas de una tabla.                                                                                  
`mutate_at()`        Aplica la(s) modificación(es) solo a la(s) columna(s) especificada(s) en la tabla.                                                           
`mutate_if()`        Aplica una modificación a todas las columnas que cumplan con una condición lógica.                                                           
`mutate_each()`      Idéntica a `mutate_all()` es considerada obsoleta (deprecated). `mutate_each_()` también es obsoleta.                                        
`transmute_all()`    Aplica una modificación a todas  las columnas de una tabla. Las exporta en una nueva tabla, no dentro de la original.                        
`transmute_at()`     Aplica la(s) modificación(es) solo a la(s) columna(s) especificada(s) en la tabla. Las exporta en una nueva tabla, no dentro de la original. 
`transmute_if()`     Aplica una modificación a todas las columnas que cumplan con una condición lógica. Las exporta en una nueva tabla, no dentro de la original. 
`transmute_each()`   Idéntica a `transmute_all()` es considerada obsoleta (deprecated). `transmute_each_()` también es obsoleta.                                  

<br>

#### `mutate_all()` y `transmute_all()`

Estas funciones aplicarán las funciones especificadas a todas las columnas de la tabla. Si alguna columna no cumple con lo necesario para se analizada, se genera error. Asegúrate de que la tabla por completo sea modificable con las funciones de transformación definidas. Como alternativa, se utiliza la función de **dplyr** `select()` para seleccionar las columnas de trabajo antes de aplicar `mutate_all()` o `transmute_all()`. La estructura básica es:


```r
BASE_DE_DATOS %>% 
  mutate_all(.funs = lst(LISTA_DE_FUNCIONES))
```

\BeginKnitrBlock{rmdnote}<div class="rmdnote">Si la función a usar en el argumento `.funs =` require más de un argumento para funcionar, es mejor crear una función con todas los argumentos definidos tal y como se necesitan. Luego usa la función nueva dentro de alguna función de la familia `mutate()`.  </div>\EndKnitrBlock{rmdnote}

::: {.example #mutateall}
Seleccionando las columnas `Income`, `GDP` y `Life_exp`, aplicar la función `round()` para redondear a un dígito los decimales de estas columnas. Crea previamente la función `rr()` para redondear a dos decimales un valor dado.


```r
# Crear una función de rendondeo a dos decimales
rr <- function(x)round(x,2)

# Aplicar dentro de mutate_all
WHO %>% 
  dplyr::select(Income, GDP, Life_exp) %>% 
  mutate_all(.funs = lst(rr)) %>% 
  head(10)
#    Income    GDP Life_exp Income_rr GDP_rr Life_exp_rr
# 1   0.479 584.26     65.0      0.48 584.26        65.0
# 2   0.476 612.70     59.9      0.48 612.70        59.9
# 3   0.470 631.74     59.9      0.47 631.74        59.9
# 4   0.463 669.96     59.5      0.46 669.96        59.5
# 5   0.454  63.54     59.2      0.45  63.54        59.2
# 6   0.448 553.33     58.8      0.45 553.33        58.8
# 7   0.434 445.89     58.6      0.43 445.89        58.6
# 8   0.433 373.36     58.1      0.43 373.36        58.1
# 9   0.415 369.84     57.5      0.42 369.84        57.5
# 10  0.405 272.56     57.3      0.41 272.56        57.3
```
:::

#### `mutate_at()` y `transmute_at()`

Estas funciones permite seleccionar las columnas de trabajo a las cuales se les aplicará algo. La estructura básica es:


```r
BASE_DE_DATOS %>% 
  mutate_at(.vars = vars(COLUMNAS_DE_TRABAJO),
            .funs = lst(LISTA_DE_FUNCIONES))

BASE_DE_DATOS %>% 
  transmute_at(.vars = vars(COLUMNAS_DE_TRABAJO),
            .funs = lst(LISTA_DE_FUNCIONES))
```

::: {.example}
Siguiendo el ejemplo \@ref:(exm:mutateall), recrear el resultado utilizando `mutate_at()`. Si se utiliza `mutate_at()` con toda la tabla, el resultado será la misma base de datos más las nuevas columnas transformadas. Para no imprimir tanta información, utiliza `transmute_at()`


```r
# Crear una función de rendondeo a dos decimales
rr <- function(x)round(x,2)

# Aplicar dentro de mutate_all
WHO %>% 
  transmute_at(.vars = vars(Income, GDP, Life_exp),
            .funs = lst(rr)) %>% 
  head(10)
#    Income_rr GDP_rr Life_exp_rr
# 1       0.48 584.26        65.0
# 2       0.48 612.70        59.9
# 3       0.47 631.74        59.9
# 4       0.46 669.96        59.5
# 5       0.45  63.54        59.2
# 6       0.45 553.33        58.8
# 7       0.43 445.89        58.6
# 8       0.43 373.36        58.1
# 9       0.42 369.84        57.5
# 10      0.41 272.56        57.3
```
:::

#### `mutate_if()` y `transmute_if()`

Como otras funciones nombradas como `_if`, estas permiten indicar una condición lógica para seleccionar solo las columnas que cumplan con dicha condición. Para establecer la condición se utiliza funciones de la familia `is()`, como `is.numeric()`. La estructura básica es:


```r
BASE_DE_DATOS %>% 
  mutate_if(.predicate = FUNCIÓN_IS_SIN_PARÉNTESIS,
               .funs = lst(LISTA_DE_FUNCIONES))

BASE_DE_DATOS %>% 
  transmute_if(.predicate = FUNCIÓN_IS_SIN_PARÉNTESIS,
               .funs = lst(LISTA_DE_FUNCIONES))
```

::: {.example}
Aplicar la transformación a factor de las columnas del tipo carácter:


```r
# Revisar la estructura de WHO
# Notar las columnas chr
str(WHO)

# Utilizar mutate_if()
WHO2 <- WHO %>% 
  mutate_if(is.character, as.factor)

# Revisar la estructura de WHO2
# Notar que las columnas chr cambiaron a Factor 
str(WHO2)
```
:::

## Combinar bases de datos

Combinar bases de datos es una tarea recurrente en ciencia de datos. Las funciones de combinación de **dplyr** utilizan como materia prima data frames o tibbles. La mejor manera de explicar el uso de estas intrincadas funciones es a través de un gráfico. La Figura \@ref(fig:figura60) muestra el detalle de las filas esperadas como resultado del uso de las funciones de combinación:

(ref:combina1) Funciones de combinación de **dplyr** y resultado esperado. El color indica la base de datos de origen de las filas que aparecerán en la tabla de resultados. 

<div class="figure" style="text-align: center">
<img src="figs/elaboradas/Combinar datasets.png" alt="(ref:combina1)" width="100%" />
<p class="caption">(\#fig:figura60)(ref:combina1)</p>
</div>

Veamos la aplicación de estas funciones con un ejemplo muy simple.

::: {.example}
Considera las data frame `Base_A` y `Base_B`:


```r
# Crear las bases de datos
Base_A <- data.frame(ID = LETTERS[1:4],
                     COL1 = 1:4)
Base_B <- data.frame(ID = LETTERS[c(1,3,4,5)],
                     COL2 = c(T,T,F,F))

# Revisar las bases de datos
Base_A
#   ID COL1
# 1  A    1
# 2  B    2
# 3  C    3
# 4  D    4

Base_B
#   ID  COL2
# 1  A  TRUE
# 2  C  TRUE
# 3  D FALSE
# 4  E FALSE
```
:::

### `full_join()`

Une las dos bases de datos por completo. Las celdas en blanco que puedan aparecer se rellenan con `NA`.


```r
full_join(Base_A, Base_B, by="ID")
#   ID COL1  COL2
# 1  A    1  TRUE
# 2  B    2    NA
# 3  C    3  TRUE
# 4  D    4 FALSE
# 5  E   NA FALSE
```

### `left_join()`

Devuelve todas las filas de `Base_A` y cualquier fila coincidente de  `Base_B`. Las filas exclusivas de `Base_B` no aparecen. Las celdas en blanco que puedan aparecer se rellenan con `NA`.


```r
left_join(Base_A, Base_B, by="ID")
#   ID COL1  COL2
# 1  A    1  TRUE
# 2  B    2    NA
# 3  C    3  TRUE
# 4  D    4 FALSE
```

### `right_join()`

Devuelve todas las filas de `Base_B` y cualquier fila coincidente de  `Base_A`. Las filas exclusivas de `Base_A` no aparecen. Las celdas en blanco que puedan aparecer se rellenan con `NA`.


```r
right_join(Base_A, Base_B, by="ID")
#   ID COL1  COL2
# 1  A    1  TRUE
# 2  C    3  TRUE
# 3  D    4 FALSE
# 4  E   NA FALSE
```

### `inner_join()`

Devuelve todas las filas coincidentes de `Base_A` y `Base_B`, y muestra las columnas de ambas bases de datos.


```r
inner_join(Base_A, Base_B, by="ID")
#   ID COL1  COL2
# 1  A    1  TRUE
# 2  C    3  TRUE
# 3  D    4 FALSE
```

### `semi_join()`

Devuelve todas las filas coincidentes de `Base_A` y `Base_B`, y muestra únicamente las columnas de la `Base_A`.


```r
semi_join(Base_A, Base_B, by="ID")
#   ID COL1
# 1  A    1
# 2  C    3
# 3  D    4
```

### `anti_join()`

Devuelve solo las filas que son exclusivas de `Base_A`.


```r
anti_join(Base_A, Base_B, by="ID")
#   ID COL1
# 1  B    2
```

## Limpieza de datos

Esta sección abordará algunos tópicos de limpieza de datos o *Data cleaning*. Como ya se ha revisado, los valores perdidos o `NA` causan problemas en el cálculo de parámetros estadísticos de las bases de datos. Más aún, cuando se pretende modelar la relación de una variable Y con los valores de una variable X, es imposible hacer regresión alguna con valores perdidos. Para estos casos, limpiar la base de datos será crucial. 

\BeginKnitrBlock{rmdnote}<div class="rmdnote">Siempre que necesites identificar si un elemento dentro de un objeto es `NA` o no, podrás utilizar la función `is.na()`. Esta devolverá un objeto lógico con la misma extensión que el objeto original. En aquellas posiciones donde exista un `NA` en la base de datos original, `is.na()` mostrará `TRUE`.</div>\EndKnitrBlock{rmdnote}

### ¿Cuántos NA existen en la base de datos?

::: {.example}
Considerando la base de datos `WHO`, calcular la cantidad de NA de la base.


```r
# Convertir WHO a tabla lógica 
# para ubicar con TRUE a los NA
WHO_logical <- is.na(WHO)
```

Recuerda que para las funciones estadísticas y matemáticas, como `mean()` o `sum()`, `TRUE` equivale a 1 y  `FALSE` a 0. Se puede obtener la proporción de `TRUE` de un vector con `mean()`, o la suma de `TRUE` en el vector con `sum()`. 


```r
# Sumando todos los TRUE (equivalentes a 1)
sum(WHO_logical)
# [1] 2563
```
:::

### ¿Cuántos NA existen en cada columna?

Hay muchas maneras de llegar a este resultado. Pero el procedimiento es similar en concepto al anterior. Se deben sumar los `TRUE` (celdas con `NA`) pero esta vez columna a columna. Como dato adicional, este objetivo también puede conseguir utilizando la función `apply()` ([Sección 5.4 Familia apply()](#familia-apply)).

::: {.example}
Crear una función que sume los NA de un vector:

```r
fun_na <- function(x) sum(is.na(x))
```

Ahora, utilizar la función aplicada a todas las columnas de la base de datos `WHO`:


```r
WHO %>% 
  summarise_all(.funs = fun_na)
#   Country Year Status1 Category Level Status2 St2_categ Life_exp Ad_mort Inf_deaths
# 1       0    0       0        0     0       0         0       10      10          0
#   Alcohol Per_exp Hep_B Measles BMI U5Y Polio Tot_exp Diph AIDS GDP Pop Thin1_19
# 1     194       0   553       0  34   0    19     226   19    0 448 652       34
#   Thin5_9 Income Schooling
# 1      34    167       163
```

Si son demasiadas columnas para visualizar, considera seleccionar las columnas cuyos valores sean mayores de 0. Crea una función que evalúe un valor y otorgue `TRUE` si este es mayor que 0.


```r
# Crear la función 
fun0 <- function(x) x > 0
```

La selección ahora utiliza una función que no se utilizó antes: `select_if()`. Como todas las funciones `_if` de **dplyr**, esta necesita condicionales para función. Allí entra en juego la función antes creada:


```r
# Aplicarla en select_if()
WHO %>% 
  summarise_all(.funs = fun_na) %>% 
  select_if(fun0)
#   Life_exp Ad_mort Alcohol Hep_B BMI Polio Tot_exp Diph GDP Pop Thin1_19 Thin5_9
# 1       10      10     194   553  34    19     226   19 448 652       34      34
#   Income Schooling
# 1    167       163
```
:::

### ¿En qué fila o columna están los NA?

Ubicar la posición de fila y columna de los valores `NA` (celdas en blanco) se utiliza cuando se conoce que no deberían haber celdas vacías pero las hay. Encontrarlas permite rellenar dicho valor por el correspondiente que fue omitido en el proceso de rellenado de la base de datos.

::: {.example}
Ubicar los valores NA de la base de datos WHO. Mostrar únicamente las 10 primeras del resultado:


```r
which(WHO_logical, arr.ind=TRUE) %>% 
  head(10)
#       row col
# 625   625   8
# 770   770   8
# 1651 1651   8
# 1716 1716   8
# 1813 1813   8
# 1910 1910   8
# 1959 1959   8
# 2168 2168   8
# 2217 2217   8
# 2714 2714   8
```
:::

\BeginKnitrBlock{rmdtip}<div class="rmdtip">En inglés, *row* significa fila y *col* columna.</div>\EndKnitrBlock{rmdtip}

### ¿Cómo reemplazar los NA por otro valor?

En ocasiones se necesita reemplazar los NA por algún valor por defecto que en el análisis sea útil. Por ejemplo, en bases que representan datos SIG (Sistemas de Información Geográficas), algunas celdas necesitan ser 9999, o -256, o algún otro valor, para que el análisis los considere bajo la categoría "no hay dato". Otros estudios, por su parte, utilizan el rellenar los datos con el promedio o la mediana de la columna. En los siguientes ejemplos veremos su aplicación:

::: {.example #na11}
Rellenar los valores `NA` de la base de datos `WHO` con el valor 9999999. Es excesivamente largo solo con la finalidad de hacerlo notorio, no por otra razón. Selecciona previamente las columnas `Alcohol`, `Hep_B`, `Measles`, `Polio`, `Diph` para que el resultado no sea amplio en la consola. Reordenar el resultado por la columna Alcohol y mostrar las últimas 6 filas de la tabla.

Aquí el truco está en una forma especial de `mutate_all()` para transformar todas las columnas pero utilizando `~ifelse()` para reemplazar todas la `NA` (`is.na(.x)`) por 9999999, y las no `NA` con el mismo valor original (`.x`):


```r
WHO %>% 
  dplyr::select(Alcohol, Hep_B, Measles, Polio, Diph) %>% 
  arrange(Alcohol) %>% 
  mutate_all(~ifelse(is.na(.x), 9999999, .x)) %>% 
  tail() 
#      Alcohol Hep_B Measles Polio Diph
# 2933   1e+07    64      39    65   64
# 2934   1e+07    87       0    87   87
# 2935   1e+07    97     256    97   97
# 2936   1e+07    69     468    63   69
# 2937   1e+07     9       9     9    9
# 2938   1e+07    87       0    88   87
```
:::

::: {.example}
Considera el mismo ejemplo anterior \@ref(exm:na11). No obstante, en lugar de reemplazar `NA` por 9999999, utiliza la función con `mean(.x, na.rm = TRUE)` para que los NA se reemplacen por el promedio de la columna.


```r
WHO %>% 
  dplyr::select(Alcohol, Hep_B, Measles, Polio, Diph) %>% 
  arrange(Alcohol) %>% 
  mutate_all(~ifelse(is.na(.x), mean(.x, na.rm = TRUE), .x))%>% 
  tail() 
#      Alcohol Hep_B Measles Polio Diph
# 2933   4.603    64      39    65   64
# 2934   4.603    87       0    87   87
# 2935   4.603    97     256    97   97
# 2936   4.603    69     468    63   69
# 2937   4.603     9       9     9    9
# 2938   4.603    87       0    88   87
```
:::

## Ejercicios del capítulo

<div class="question">
  1. Carga la base de datos `aids` de la librería **boot**. Se pretenden obtener el promedio de las columnas `delay`, `dud`, `time` e` y`, por cuarto (`quarter`) y por año (`year`). Asegúrate de que la tabla esté reordenada de menor a mayor por año (`year`) y por cuarto (`quarter`). 
  1. Utilizando la base de dato `aids`, encuentra cuales son los años (o el año) en que se tuvieron valores mayores igual a 30 en `time` y valores de mayores a 25 en `delay`.
  1. La función `grepl()` provee una manera muy interesante de filtrar filas. Permite especificar un texto que será buscado dentro de cada palabra en cada celda de dicha columna, para filtrar las filas que contengan dicha cadena de texto. Pueden ser solo letras consecutivas, una palabras completa, etc. Usando `grepl()` dentro de la función `filter()`, se filtrarán las filas que coincidan con la búsqueda hecha por `grepl()`. 

Una vez entendido el uso de la función `grepl()`, instala y activa la librería `gapminder`, y carga la base de datos del mismo nombre. Filtra las filas que en la columna `country` tengan el patrón de texto "ru". Luego, realiza una segunda *pipeline* para realizar lo mismo pero ahora con el patrón "nia", indicando que se ignore mayúsculas o minúsculas.


```r
# Conjunto de datos
vector <- c("Andrea","Breta","Mark","Elon")

# Buscar la letra A mayúscula en los elementos del vector
grepl("A", vector)
# [1]  TRUE FALSE FALSE FALSE

# Buscar la letra A (mayúscula o minúscula) en los elementos del vector
grepl("A", vector, ignore.case = TRUE)
# [1]  TRUE  TRUE  TRUE FALSE

# Buscar re mayúscula en los elementos del vector
grepl("re", vector)
# [1]  TRUE  TRUE FALSE FALSE
```


```r
# Inicia el ejercicio con la instalación de gapminder
install.packages("gapminder")
library(gapminder)

# Carga la base de datos gapminder
data("gapminder")
```

  1. Carga la base de datos `breslow` de la librería **boot**. Esta base contiene información sobre el estatus de fumador/no fumador y  edad de varios pacientes. Filtra las filas de las personas fumadoras (`1`) en la columna `smoke` que tengan `age` (edad) mayor a 40. Si realizas el ejercicio y no te funciona, la respuesta no era tan sencilla como aparenta. Revisar la `str()` de una base de datos es crucial siempre, aquí ayuda a entender que originalmente `age` es un factor, y debería ser numérica para aplicarle el filtrado con mayor a 40. Algo similar pasa con `smoke`, es numérica y debe ser un factor. Utiliza la función respectiva de **dplyr** para transformar estas columnas. Aquí el truco para `age` es primero convertirla de factor a character, y luego a numeric. Pasar de factor directamente a numeric puede hacer que se pierda la información. Juega un poco con la base y notarás estos problemas.
  
  1. Carga la base de datos `population` de la librería **tidyr**. Identifica cuales son los seis países con mayor población (asegúrate de expresarlo en millones) en 1995, y luego en 2007. ¿Cambió algún país en la lista del top 6 ordenada de mayor a menor?

</div>
