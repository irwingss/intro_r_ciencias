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

Función            Descripción                                                             
-----------------  ------------------------------------------------------------------------
`pivot_longer()`   Pivotar una tabla de columnas a filas (hacia tabla larga)               
`pivot_wider()`    Pivotar una tabla de filas de columnas (hacia tabla ancha)              
`gather()`         Permite convertir una tabla ancha a una tabla larga                     
`spread()`         Permite convertir una tabla larga a una tabla ancha                     
`unite()`          Permite unir el contenido textual varias columnas en una sola.          
`separate()`       Permite separar el contenido textual de una columna en varias columnas. 
`drop_na()`        Elimina las filas que contengan NA en una tabla.                        


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
# # A tibble: 6 x 4
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
# # A tibble: 16 x 5
#    Year Promed   Pol GDP_prom GDP_sd
#   <dbl>  <dbl> <dbl>    <dbl>  <dbl>
# 1  2000   66.8    NA       NA     NA
# 2  2001   67.1    NA       NA     NA
# 3  2002   67.4    NA       NA     NA
# 4  2003   67.4    NA       NA     NA
# 5  2004   67.6    NA       NA     NA
# 6  2005   68.2    NA       NA     NA
# # ... with 10 more rows
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
# # A tibble: 16 x 5
#    Year Promed   Pol GDP_prom GDP_sd
#   <dbl>  <dbl> <dbl>    <dbl>  <dbl>
# 1  2000   66.8    88    4709.  9182.
# 2  2001   67.1    89    4855.  8892.
# 3  2002   67.4    91    4599.  8541.
# 4  2003   67.4    91    4775.  9144.
# 5  2004   67.6    91    7056. 13504.
# 6  2005   68.2    93    7250. 13107.
# # ... with 10 more rows
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
# # A tibble: 3 x 7
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
# # A tibble: 3 x 10
#   Country  GDP_mean Life_exp_mean  Pop_mean GDP_median Life_exp_median Pop_median
#   <chr>       <dbl>         <dbl>     <dbl>      <dbl>           <dbl>      <dbl>
# 1 Colombia    3322.          73.3 31767433.      2434.            73.5  43004898.
# 2 Mexico      5179.          75.7 27585265.      6976.            75.6  11460708.
# 3 Peru        2929.          73.7 16854322.      2601.            73.8  26088121 
# # ... with 3 more variables: GDP_sd <dbl>, Life_exp_sd <dbl>, Pop_sd <dbl>
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
# # A tibble: 4 x 3
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


## Ejercicios del capítulo


```r
borrarCol <- function(x) x <- NULL
WHO %>% 
  mutate_if(is.numeric,borrarCol)
#                                                   Country    Status1   Category
# 1                                             Afghanistan Developing Category B
# 2                                             Afghanistan Developing Category B
# 3                                             Afghanistan Developing Category C
# 4                                             Afghanistan Developing Category A
# 5                                             Afghanistan Developing Category C
# 6                                             Afghanistan Developing Category C
# 7                                             Afghanistan Developing Category B
# 8                                             Afghanistan Developing Category B
# 9                                             Afghanistan Developing Category B
# 10                                            Afghanistan Developing Category B
# 11                                            Afghanistan Developing Category A
# 12                                            Afghanistan Developing Category A
# 13                                            Afghanistan Developing Category A
# 14                                            Afghanistan Developing Category A
# 15                                            Afghanistan Developing Category C
# 16                                            Afghanistan Developing Category C
# 17                                                Albania Developing Category B
# 18                                                Albania Developing Category C
# 19                                                Albania Developing Category A
# 20                                                Albania Developing Category A
# 21                                                Albania Developing Category C
# 22                                                Albania Developing Category B
# 23                                                Albania Developing Category A
# 24                                                Albania Developing Category A
# 25                                                Albania Developing Category A
# 26                                                Albania Developing Category A
# 27                                                Albania Developing Category A
# 28                                                Albania Developing Category A
# 29                                                Albania Developing Category C
# 30                                                Albania Developing Category B
# 31                                                Albania Developing Category A
# 32                                                Albania Developing Category A
# 33                                                Algeria Developing Category C
# 34                                                Algeria Developing Category A
# 35                                                Algeria Developing Category B
# 36                                                Algeria Developing Category B
# 37                                                Algeria Developing Category B
# 38                                                Algeria Developing Category A
# 39                                                Algeria Developing Category B
# 40                                                Algeria Developing Category B
# 41                                                Algeria Developing Category A
# 42                                                Algeria Developing Category B
# 43                                                Algeria Developing Category B
# 44                                                Algeria Developing Category B
# 45                                                Algeria Developing Category B
# 46                                                Algeria Developing Category A
# 47                                                Algeria Developing Category B
# 48                                                Algeria Developing Category C
# 49                                                 Angola Developing Category B
# 50                                                 Angola Developing Category A
# 51                                                 Angola Developing Category A
# 52                                                 Angola Developing Category C
# 53                                                 Angola Developing Category A
# 54                                                 Angola Developing Category C
# 55                                                 Angola Developing Category A
# 56                                                 Angola Developing Category B
# 57                                                 Angola Developing Category A
# 58                                                 Angola Developing Category C
# 59                                                 Angola Developing Category C
# 60                                                 Angola Developing Category A
# 61                                                 Angola Developing Category A
# 62                                                 Angola Developing Category C
# 63                                                 Angola Developing Category C
# 64                                                 Angola Developing Category A
# 65                                    Antigua and Barbuda Developing Category A
# 66                                    Antigua and Barbuda Developing Category A
# 67                                    Antigua and Barbuda Developing Category C
# 68                                    Antigua and Barbuda Developing Category A
# 69                                    Antigua and Barbuda Developing Category B
# 70                                    Antigua and Barbuda Developing Category C
# 71                                    Antigua and Barbuda Developing Category B
# 72                                    Antigua and Barbuda Developing Category A
# 73                                    Antigua and Barbuda Developing Category C
# 74                                    Antigua and Barbuda Developing Category A
# 75                                    Antigua and Barbuda Developing Category C
# 76                                    Antigua and Barbuda Developing Category B
# 77                                    Antigua and Barbuda Developing Category B
# 78                                    Antigua and Barbuda Developing Category B
# 79                                    Antigua and Barbuda Developing Category B
# 80                                    Antigua and Barbuda Developing Category A
# 81                                              Argentina Developing Category C
# 82                                              Argentina Developing Category B
# 83                                              Argentina Developing Category B
# 84                                              Argentina Developing Category B
# 85                                              Argentina Developing Category B
# 86                                              Argentina Developing Category A
# 87                                              Argentina Developing Category A
# 88                                              Argentina Developing Category A
# 89                                              Argentina Developing Category B
# 90                                              Argentina Developing Category A
# 91                                              Argentina Developing Category C
# 92                                              Argentina Developing Category B
# 93                                              Argentina Developing Category C
# 94                                              Argentina Developing Category C
# 95                                              Argentina Developing Category A
# 96                                              Argentina Developing Category B
# 97                                                Armenia Developing Category C
# 98                                                Armenia Developing Category C
# 99                                                Armenia Developing Category C
# 100                                               Armenia Developing Category A
# 101                                               Armenia Developing Category B
# 102                                               Armenia Developing Category B
# 103                                               Armenia Developing Category B
# 104                                               Armenia Developing Category B
# 105                                               Armenia Developing Category B
# 106                                               Armenia Developing Category A
# 107                                               Armenia Developing Category B
# 108                                               Armenia Developing Category A
# 109                                               Armenia Developing Category A
# 110                                               Armenia Developing Category C
# 111                                               Armenia Developing Category C
# 112                                               Armenia Developing Category A
# 113                                             Australia Developing Category A
# 114                                             Australia Developing Category B
# 115                                             Australia Developing Category B
# 116                                             Australia Developing Category B
# 117                                             Australia Developing Category C
# 118                                             Australia Developing Category C
# 119                                             Australia Developing Category B
# 120                                             Australia Developing Category B
# 121                                             Australia Developing Category C
# 122                                             Australia Developing Category C
# 123                                             Australia Developing Category C
# 124                                             Australia Developing Category B
# 125                                             Australia Developing Category B
# 126                                             Australia Developing Category C
# 127                                             Australia Developing Category C
# 128                                             Australia Developing Category C
# 129                                               Austria Developing Category A
# 130                                               Austria Developing Category C
# 131                                               Austria Developing Category A
# 132                                               Austria Developing Category B
# 133                                               Austria Developing Category A
# 134                                               Austria Developing Category B
# 135                                               Austria Developing Category C
# 136                                               Austria Developing Category A
# 137                                               Austria Developing Category A
# 138                                               Austria Developing Category A
# 139                                               Austria Developing Category A
# 140                                               Austria Developing Category B
# 141                                               Austria Developing Category C
# 142                                               Austria Developing Category C
# 143                                               Austria Developing Category B
# 144                                               Austria Developing Category B
# 145                                            Azerbaijan Developing Category B
# 146                                            Azerbaijan Developing Category C
# 147                                            Azerbaijan Developing Category B
# 148                                            Azerbaijan Developing Category A
# 149                                            Azerbaijan Developing Category B
# 150                                            Azerbaijan Developing Category A
# 151                                            Azerbaijan Developing Category B
# 152                                            Azerbaijan Developing Category A
# 153                                            Azerbaijan Developing Category A
# 154                                            Azerbaijan Developing Category B
# 155                                            Azerbaijan Developing Category C
# 156                                            Azerbaijan Developing Category C
# 157                                            Azerbaijan Developing Category C
# 158                                            Azerbaijan Developing Category A
# 159                                            Azerbaijan Developing Category A
# 160                                            Azerbaijan Developing Category A
# 161                                               Bahamas Developing Category C
# 162                                               Bahamas Developing Category B
# 163                                               Bahamas Developing Category B
# 164                                               Bahamas Developing Category C
# 165                                               Bahamas Developing Category C
# 166                                               Bahamas Developing Category B
# 167                                               Bahamas Developing Category B
# 168                                               Bahamas Developing Category C
# 169                                               Bahamas Developing Category B
# 170                                               Bahamas Developing Category A
# 171                                               Bahamas Developing Category C
# 172                                               Bahamas Developing Category C
# 173                                               Bahamas Developing Category B
# 174                                               Bahamas Developing Category B
# 175                                               Bahamas Developing Category A
# 176                                               Bahamas Developing Category C
# 177                                               Bahrain Developing Category B
# 178                                               Bahrain Developing Category B
# 179                                               Bahrain Developing Category C
# 180                                               Bahrain Developing Category C
# 181                                               Bahrain Developing Category A
# 182                                               Bahrain Developing Category A
# 183                                               Bahrain Developing Category C
# 184                                               Bahrain Developing Category C
# 185                                               Bahrain Developing Category A
# 186                                               Bahrain Developing Category A
# 187                                               Bahrain Developing Category A
# 188                                               Bahrain Developing Category A
# 189                                               Bahrain Developing Category A
# 190                                               Bahrain Developing Category B
# 191                                               Bahrain Developing Category A
# 192                                               Bahrain Developing Category A
# 193                                            Bangladesh Developing Category A
# 194                                            Bangladesh Developing Category B
# 195                                            Bangladesh Developing Category A
# 196                                            Bangladesh Developing Category A
# 197                                            Bangladesh Developing Category B
# 198                                            Bangladesh Developing Category C
# 199                                            Bangladesh Developing Category B
# 200                                            Bangladesh Developing Category A
# 201                                            Bangladesh Developing Category B
# 202                                            Bangladesh Developing Category B
# 203                                            Bangladesh Developing Category A
# 204                                            Bangladesh Developing Category B
# 205                                            Bangladesh Developing Category A
# 206                                            Bangladesh Developing Category C
# 207                                            Bangladesh Developing Category B
# 208                                            Bangladesh Developing Category C
# 209                                              Barbados Developing Category B
# 210                                              Barbados Developing Category C
# 211                                              Barbados Developing Category B
# 212                                              Barbados Developing Category C
# 213                                              Barbados Developing Category A
# 214                                              Barbados Developing Category A
# 215                                              Barbados Developing Category A
# 216                                              Barbados Developing Category A
# 217                                              Barbados Developing Category B
# 218                                              Barbados Developing Category C
# 219                                              Barbados Developing Category B
# 220                                              Barbados Developing Category B
# 221                                              Barbados Developing Category B
# 222                                              Barbados Developing Category C
# 223                                              Barbados Developing Category C
# 224                                              Barbados Developing Category C
# 225                                               Belarus Developing Category A
# 226                                               Belarus Developing Category B
# 227                                               Belarus Developing Category A
# 228                                               Belarus Developing Category C
# 229                                               Belarus Developing Category A
# 230                                               Belarus Developing Category C
# 231                                               Belarus Developing Category B
# 232                                               Belarus Developing Category A
# 233                                               Belarus Developing Category C
# 234                                               Belarus Developing Category B
# 235                                               Belarus Developing Category A
# 236                                               Belarus Developing Category A
# 237                                               Belarus Developing Category B
# 238                                               Belarus Developing Category B
# 239                                               Belarus Developing Category C
# 240                                               Belarus Developing Category C
# 241                                               Belgium Developing Category B
# 242                                               Belgium Developing Category B
# 243                                               Belgium Developing Category B
# 244                                               Belgium Developing Category B
# 245                                               Belgium Developing Category C
# 246                                               Belgium Developing Category B
# 247                                               Belgium Developing Category B
# 248                                               Belgium Developing Category C
# 249                                               Belgium Developing Category A
# 250                                               Belgium Developing Category B
# 251                                               Belgium Developing Category C
# 252                                               Belgium Developing Category B
# 253                                               Belgium Developing Category C
# 254                                               Belgium Developing Category B
# 255                                               Belgium Developing Category C
# 256                                               Belgium Developing Category C
# 257                                                Belize Developing Category C
# 258                                                Belize Developing Category A
# 259                                                Belize Developing Category C
# 260                                                Belize Developing Category A
# 261                                                Belize Developing Category B
# 262                                                Belize Developing Category C
# 263                                                Belize Developing Category A
# 264                                                Belize Developing Category C
# 265                                                Belize Developing Category C
# 266                                                Belize Developing Category B
# 267                                                Belize Developing Category A
# 268                                                Belize Developing Category C
# 269                                                Belize Developing Category B
# 270                                                Belize Developing Category A
# 271                                                Belize Developing Category B
# 272                                                Belize Developing Category A
# 273                                                 Benin Developing Category A
# 274                                                 Benin Developing Category A
# 275                                                 Benin Developing Category B
# 276                                                 Benin Developing Category B
# 277                                                 Benin Developing Category C
# 278                                                 Benin Developing Category B
# 279                                                 Benin Developing Category B
# 280                                                 Benin Developing Category B
# 281                                                 Benin Developing Category C
# 282                                                 Benin Developing Category C
# 283                                                 Benin Developing Category A
# 284                                                 Benin Developing Category B
# 285                                                 Benin Developing Category C
# 286                                                 Benin Developing Category A
# 287                                                 Benin Developing Category C
# 288                                                 Benin Developing Category C
# 289                                                Bhutan Developing Category B
# 290                                                Bhutan Developing Category B
# 291                                                Bhutan Developing Category C
# 292                                                Bhutan Developing Category C
# 293                                                Bhutan Developing Category B
# 294                                                Bhutan Developing Category B
# 295                                                Bhutan Developing Category B
# 296                                                Bhutan Developing Category A
# 297                                                Bhutan Developing Category B
# 298                                                Bhutan Developing Category B
# 299                                                Bhutan Developing Category B
# 300                                                Bhutan Developing Category B
# 301                                                Bhutan Developing Category C
# 302                                                Bhutan Developing Category C
# 303                                                Bhutan Developing Category A
# 304                                                Bhutan Developing Category C
# 305                      Bolivia (Plurinational State of) Developing Category A
# 306                      Bolivia (Plurinational State of) Developing Category A
# 307                      Bolivia (Plurinational State of) Developing Category A
# 308                      Bolivia (Plurinational State of) Developing Category B
# 309                      Bolivia (Plurinational State of) Developing Category C
# 310                      Bolivia (Plurinational State of) Developing Category B
# 311                      Bolivia (Plurinational State of) Developing Category B
# 312                      Bolivia (Plurinational State of) Developing Category B
# 313                      Bolivia (Plurinational State of) Developing Category C
# 314                      Bolivia (Plurinational State of) Developing Category B
# 315                      Bolivia (Plurinational State of) Developing Category C
# 316                      Bolivia (Plurinational State of) Developing Category B
# 317                      Bolivia (Plurinational State of) Developing Category C
# 318                      Bolivia (Plurinational State of) Developing Category C
# 319                      Bolivia (Plurinational State of) Developing Category A
# 320                      Bolivia (Plurinational State of) Developing Category C
# 321                                Bosnia and Herzegovina Developing Category A
# 322                                Bosnia and Herzegovina Developing Category B
# 323                                Bosnia and Herzegovina Developing Category C
# 324                                Bosnia and Herzegovina Developing Category A
# 325                                Bosnia and Herzegovina Developing Category A
# 326                                Bosnia and Herzegovina Developing Category A
# 327                                Bosnia and Herzegovina Developing Category C
# 328                                Bosnia and Herzegovina Developing Category A
# 329                                Bosnia and Herzegovina Developing Category B
# 330                                Bosnia and Herzegovina Developing Category B
# 331                                Bosnia and Herzegovina Developing Category A
# 332                                Bosnia and Herzegovina Developing Category C
# 333                                Bosnia and Herzegovina Developing Category A
# 334                                Bosnia and Herzegovina Developing Category B
# 335                                Bosnia and Herzegovina Developing Category B
# 336                                Bosnia and Herzegovina Developing Category B
# 337                                              Botswana Developing Category B
# 338                                              Botswana Developing Category C
# 339                                              Botswana Developing Category C
# 340                                              Botswana Developing Category B
# 341                                              Botswana Developing Category A
# 342                                              Botswana Developing Category C
# 343                                              Botswana Developing Category A
# 344                                              Botswana Developing Category B
# 345                                              Botswana Developing Category C
# 346                                              Botswana Developing Category C
# 347                                              Botswana Developing Category C
# 348                                              Botswana Developing Category A
# 349                                              Botswana Developing Category B
# 350                                              Botswana Developing Category C
# 351                                              Botswana Developing Category A
# 352                                              Botswana Developing Category B
# 353                                                Brazil Developing Category A
# 354                                                Brazil Developing Category C
# 355                                                Brazil Developing Category C
# 356                                                Brazil Developing Category A
# 357                                                Brazil Developing Category C
# 358                                                Brazil Developing Category B
# 359                                                Brazil Developing Category B
# 360                                                Brazil Developing Category A
# 361                                                Brazil Developing Category A
# 362                                                Brazil Developing Category A
# 363                                                Brazil Developing Category A
# 364                                                Brazil Developing Category A
# 365                                                Brazil Developing Category A
# 366                                                Brazil Developing Category B
# 367                                                Brazil Developing Category B
# 368                                                Brazil Developing Category B
# 369                                     Brunei Darussalam Developing Category B
# 370                                     Brunei Darussalam Developing Category A
# 371                                     Brunei Darussalam Developing Category B
# 372                                     Brunei Darussalam Developing Category B
# 373                                     Brunei Darussalam Developing Category A
# 374                                     Brunei Darussalam Developing Category B
# 375                                     Brunei Darussalam Developing Category A
# 376                                     Brunei Darussalam Developing Category A
# 377                                     Brunei Darussalam Developing Category B
# 378                                     Brunei Darussalam Developing Category C
# 379                                     Brunei Darussalam Developing Category C
# 380                                     Brunei Darussalam Developing Category C
# 381                                     Brunei Darussalam Developing Category B
# 382                                     Brunei Darussalam Developing Category A
# 383                                     Brunei Darussalam Developing Category A
# 384                                     Brunei Darussalam Developing Category B
# 385                                              Bulgaria Developing Category B
# 386                                              Bulgaria Developing Category B
# 387                                              Bulgaria Developing Category C
# 388                                              Bulgaria Developing Category C
# 389                                              Bulgaria Developing Category B
# 390                                              Bulgaria Developing Category C
# 391                                              Bulgaria Developing Category C
# 392                                              Bulgaria Developing Category C
# 393                                              Bulgaria Developing Category A
# 394                                              Bulgaria Developing Category A
# 395                                              Bulgaria Developing Category C
# 396                                              Bulgaria Developing Category B
# 397                                              Bulgaria Developing Category B
# 398                                              Bulgaria Developing Category B
# 399                                              Bulgaria Developing Category A
# 400                                              Bulgaria Developing Category A
# 401                                          Burkina Faso Developing Category A
# 402                                          Burkina Faso Developing Category A
# 403                                          Burkina Faso Developing Category C
# 404                                          Burkina Faso Developing Category B
# 405                                          Burkina Faso Developing Category C
# 406                                          Burkina Faso Developing Category C
# 407                                          Burkina Faso Developing Category B
# 408                                          Burkina Faso Developing Category C
# 409                                          Burkina Faso Developing Category A
# 410                                          Burkina Faso Developing Category B
# 411                                          Burkina Faso Developing Category A
# 412                                          Burkina Faso Developing Category A
# 413                                          Burkina Faso Developing Category A
# 414                                          Burkina Faso Developing Category A
# 415                                          Burkina Faso Developing Category A
# 416                                          Burkina Faso Developing Category C
# 417                                               Burundi Developing Category A
# 418                                               Burundi Developing Category C
# 419                                               Burundi Developing Category C
# 420                                               Burundi Developing Category C
# 421                                               Burundi Developing Category A
# 422                                               Burundi Developing Category B
# 423                                               Burundi Developing Category B
# 424                                               Burundi Developing Category C
# 425                                               Burundi Developing Category B
# 426                                               Burundi Developing Category A
# 427                                               Burundi Developing Category B
# 428                                               Burundi Developing Category A
# 429                                               Burundi Developing Category B
# 430                                               Burundi Developing Category C
# 431                                               Burundi Developing Category B
# 432                                               Burundi Developing Category C
# 433                                        CÃ´te d'Ivoire Developing Category B
# 434                                        CÃ´te d'Ivoire Developing Category A
# 435                                        CÃ´te d'Ivoire Developing Category A
# 436                                        CÃ´te d'Ivoire Developing Category C
# 437                                        CÃ´te d'Ivoire Developing Category C
# 438                                        CÃ´te d'Ivoire Developing Category C
# 439                                        CÃ´te d'Ivoire Developing Category B
# 440                                        CÃ´te d'Ivoire Developing Category B
# 441                                        CÃ´te d'Ivoire Developing Category C
# 442                                        CÃ´te d'Ivoire Developing Category B
# 443                                        CÃ´te d'Ivoire Developing Category B
# 444                                        CÃ´te d'Ivoire Developing Category A
# 445                                        CÃ´te d'Ivoire Developing Category C
# 446                                        CÃ´te d'Ivoire Developing Category C
# 447                                        CÃ´te d'Ivoire Developing Category C
# 448                                        CÃ´te d'Ivoire Developing Category A
# 449                                            Cabo Verde Developing Category C
# 450                                            Cabo Verde Developing Category C
# 451                                            Cabo Verde Developing Category C
# 452                                            Cabo Verde Developing Category B
# 453                                            Cabo Verde Developing Category A
# 454                                            Cabo Verde Developing Category B
# 455                                            Cabo Verde Developing Category A
# 456                                            Cabo Verde Developing Category B
# 457                                            Cabo Verde Developing Category C
# 458                                            Cabo Verde Developing Category B
# 459                                            Cabo Verde Developing Category B
# 460                                            Cabo Verde Developing Category C
# 461                                            Cabo Verde Developing Category B
# 462                                            Cabo Verde Developing Category C
# 463                                            Cabo Verde Developing Category C
# 464                                            Cabo Verde Developing Category B
# 465                                              Cambodia Developing Category C
# 466                                              Cambodia Developing Category A
# 467                                              Cambodia Developing Category B
# 468                                              Cambodia Developing Category B
# 469                                              Cambodia Developing Category B
# 470                                              Cambodia Developing Category C
# 471                                              Cambodia Developing Category B
# 472                                              Cambodia Developing Category C
# 473                                              Cambodia Developing Category A
# 474                                              Cambodia Developing Category A
# 475                                              Cambodia Developing Category B
# 476                                              Cambodia Developing Category B
# 477                                              Cambodia Developing Category C
# 478                                              Cambodia Developing Category C
# 479                                              Cambodia Developing Category B
# 480                                              Cambodia Developing Category A
# 481                                              Cameroon Developing Category B
# 482                                              Cameroon Developing Category A
# 483                                              Cameroon Developing Category B
# 484                                              Cameroon Developing Category B
# 485                                              Cameroon Developing Category A
# 486                                              Cameroon Developing Category C
# 487                                              Cameroon Developing Category C
# 488                                              Cameroon Developing Category C
# 489                                              Cameroon Developing Category A
# 490                                              Cameroon Developing Category B
# 491                                              Cameroon Developing Category B
# 492                                              Cameroon Developing Category C
# 493                                              Cameroon Developing Category C
# 494                                              Cameroon Developing Category A
# 495                                              Cameroon Developing Category C
# 496                                              Cameroon Developing Category B
# 497                                                Canada Developing Category C
# 498                                                Canada Developing Category C
# 499                                                Canada Developing Category A
# 500                                                Canada Developing Category B
# 501                                                Canada Developing Category C
# 502                                                Canada Developing Category C
# 503                                                Canada Developing Category A
# 504                                                Canada Developing Category C
# 505                                                Canada Developing Category B
# 506                                                Canada Developing Category C
# 507                                                Canada Developing Category A
# 508                                                Canada Developing Category C
# 509                                                Canada Developing Category B
# 510                                                Canada Developing Category A
# 511                                                Canada Developing Category A
# 512                                                Canada Developing Category C
# 513                              Central African Republic Developing Category B
# 514                              Central African Republic Developing Category A
# 515                              Central African Republic Developing Category C
# 516                              Central African Republic Developing Category C
# 517                              Central African Republic Developing Category A
# 518                              Central African Republic Developing Category A
# 519                              Central African Republic Developing Category B
# 520                              Central African Republic Developing Category A
# 521                              Central African Republic Developing Category A
# 522                              Central African Republic Developing Category A
# 523                              Central African Republic Developing Category A
# 524                              Central African Republic Developing Category B
# 525                              Central African Republic Developing Category C
# 526                              Central African Republic Developing Category B
# 527                              Central African Republic Developing Category B
# 528                              Central African Republic Developing Category B
# 529                                                  Chad Developing Category A
# 530                                                  Chad Developing Category C
# 531                                                  Chad Developing Category C
# 532                                                  Chad Developing Category B
# 533                                                  Chad Developing Category A
# 534                                                  Chad Developing Category B
# 535                                                  Chad Developing Category C
# 536                                                  Chad Developing Category C
# 537                                                  Chad Developing Category C
# 538                                                  Chad Developing Category C
# 539                                                  Chad Developing Category B
# 540                                                  Chad Developing Category C
# 541                                                  Chad Developing Category B
# 542                                                  Chad Developing Category B
# 543                                                  Chad Developing Category C
# 544                                                  Chad Developing Category B
# 545                                                 Chile Developing Category C
# 546                                                 Chile Developing Category A
# 547                                                 Chile Developing Category A
# 548                                                 Chile Developing Category B
# 549                                                 Chile Developing Category B
# 550                                                 Chile Developing Category A
# 551                                                 Chile Developing Category A
# 552                                                 Chile Developing Category A
# 553                                                 Chile Developing Category A
# 554                                                 Chile Developing Category A
# 555                                                 Chile Developing Category B
# 556                                                 Chile Developing Category B
# 557                                                 Chile Developing Category A
# 558                                                 Chile Developing Category B
# 559                                                 Chile Developing Category B
# 560                                                 Chile Developing Category A
# 561                                                 China Developing Category B
# 562                                                 China Developing Category A
# 563                                                 China Developing Category B
# 564                                                 China Developing Category C
# 565                                                 China Developing Category C
# 566                                                 China Developing Category C
# 567                                                 China Developing Category C
# 568                                                 China Developing Category A
# 569                                                 China Developing Category B
# 570                                                 China Developing Category A
# 571                                                 China Developing Category B
# 572                                                 China Developing Category C
# 573                                                 China Developing Category B
# 574                                                 China Developing Category B
# 575                                                 China Developing Category A
# 576                                                 China Developing Category A
# 577                                              Colombia Developing Category B
# 578                                              Colombia Developing Category B
# 579                                              Colombia Developing Category B
# 580                                              Colombia Developing Category B
# 581                                              Colombia Developing Category B
# 582                                              Colombia Developing Category C
# 583                                              Colombia Developing Category A
# 584                                              Colombia Developing Category B
# 585                                              Colombia Developing Category B
# 586                                              Colombia Developing Category C
# 587                                              Colombia Developing Category B
# 588                                              Colombia Developing Category A
# 589                                              Colombia Developing Category A
# 590                                              Colombia Developing Category A
# 591                                              Colombia Developing Category B
# 592                                              Colombia Developing Category B
# 593                                               Comoros Developing Category B
# 594                                               Comoros Developing Category A
# 595                                               Comoros Developing Category B
# 596                                               Comoros Developing Category C
# 597                                               Comoros Developing Category B
# 598                                               Comoros Developing Category A
# 599                                               Comoros Developing Category B
# 600                                               Comoros Developing Category A
# 601                                               Comoros Developing Category C
# 602                                               Comoros Developing Category C
# 603                                               Comoros Developing Category B
# 604                                               Comoros Developing Category C
# 605                                               Comoros Developing Category A
# 606                                               Comoros Developing Category A
# 607                                               Comoros Developing Category B
# 608                                               Comoros Developing Category C
# 609                                                 Congo Developing Category A
# 610                                                 Congo Developing Category A
# 611                                                 Congo Developing Category B
# 612                                                 Congo Developing Category A
# 613                                                 Congo Developing Category A
# 614                                                 Congo Developing Category A
# 615                                                 Congo Developing Category A
# 616                                                 Congo Developing Category A
# 617                                                 Congo Developing Category A
# 618                                                 Congo Developing Category C
# 619                                                 Congo Developing Category A
# 620                                                 Congo Developing Category B
# 621                                                 Congo Developing Category A
# 622                                                 Congo Developing Category C
# 623                                                 Congo Developing Category B
# 624                                                 Congo Developing Category A
# 625                                          Cook Islands Developing Category C
# 626                                            Costa Rica Developing Category C
# 627                                            Costa Rica Developing Category B
# 628                                            Costa Rica Developing Category A
# 629                                            Costa Rica Developing Category A
# 630                                            Costa Rica Developing Category C
# 631                                            Costa Rica Developing Category C
# 632                                            Costa Rica Developing Category C
# 633                                            Costa Rica Developing Category B
# 634                                            Costa Rica Developing Category B
# 635                                            Costa Rica Developing Category B
# 636                                            Costa Rica Developing Category B
# 637                                            Costa Rica Developing Category A
# 638                                            Costa Rica Developing Category B
# 639                                            Costa Rica Developing Category B
# 640                                            Costa Rica Developing Category A
# 641                                            Costa Rica Developing Category A
# 642                                               Croatia Developing Category C
# 643                                               Croatia Developing Category C
# 644                                               Croatia Developing Category C
# 645                                               Croatia Developing Category C
# 646                                               Croatia Developing Category B
# 647                                               Croatia Developing Category C
# 648                                               Croatia Developing Category A
# 649                                               Croatia Developing Category B
# 650                                               Croatia Developing Category A
# 651                                               Croatia Developing Category C
# 652                                               Croatia Developing Category B
# 653                                               Croatia Developing Category B
# 654                                               Croatia Developing Category C
# 655                                               Croatia Developing Category A
# 656                                               Croatia Developing Category A
# 657                                               Croatia Developing Category A
# 658                                                  Cuba Developing Category C
# 659                                                  Cuba Developing Category C
# 660                                                  Cuba Developing Category B
# 661                                                  Cuba Developing Category A
# 662                                                  Cuba Developing Category C
# 663                                                  Cuba Developing Category C
# 664                                                  Cuba Developing Category C
# 665                                                  Cuba Developing Category C
# 666                                                  Cuba Developing Category A
# 667                                                  Cuba Developing Category C
# 668                                                  Cuba Developing Category A
# 669                                                  Cuba Developing Category B
# 670                                                  Cuba Developing Category A
# 671                                                  Cuba Developing Category C
# 672                                                  Cuba Developing Category C
# 673                                                  Cuba Developing Category A
# 674                                                Cyprus Developing Category B
# 675                                                Cyprus Developing Category A
# 676                                                Cyprus Developing Category B
# 677                                                Cyprus Developing Category B
# 678                                                Cyprus Developing Category A
# 679                                                Cyprus Developing Category B
# 680                                                Cyprus Developing Category C
# 681                                                Cyprus Developing Category B
# 682                                                Cyprus Developing Category C
# 683                                                Cyprus Developing Category A
# 684                                                Cyprus Developing Category A
# 685                                                Cyprus Developing Category B
# 686                                                Cyprus Developing Category B
# 687                                                Cyprus Developing Category B
# 688                                                Cyprus Developing Category C
# 689                                                Cyprus Developing Category C
# 690                                               Czechia Developing Category A
# 691                                               Czechia Developing Category A
# 692                                               Czechia Developing Category A
# 693                                               Czechia Developing Category A
# 694                                               Czechia Developing Category A
# 695                                               Czechia Developing Category A
# 696                                               Czechia Developing Category B
# 697                                               Czechia Developing Category A
# 698                                               Czechia Developing Category B
# 699                                               Czechia Developing Category B
# 700                                               Czechia Developing Category C
# 701                                               Czechia Developing Category A
# 702                                               Czechia Developing Category C
# 703                                               Czechia Developing Category A
# 704                                               Czechia Developing Category C
# 705                                               Czechia Developing Category A
# 706                 Democratic People's Republic of Korea Developing Category B
# 707                 Democratic People's Republic of Korea Developing Category C
# 708                 Democratic People's Republic of Korea Developing Category C
# 709                 Democratic People's Republic of Korea Developing Category B
# 710                 Democratic People's Republic of Korea Developing Category A
# 711                 Democratic People's Republic of Korea Developing Category C
# 712                 Democratic People's Republic of Korea Developing Category A
# 713                 Democratic People's Republic of Korea Developing Category B
# 714                 Democratic People's Republic of Korea Developing Category C
# 715                 Democratic People's Republic of Korea Developing Category B
# 716                 Democratic People's Republic of Korea Developing Category B
# 717                 Democratic People's Republic of Korea Developing Category A
# 718                 Democratic People's Republic of Korea Developing Category A
# 719                 Democratic People's Republic of Korea Developing Category C
# 720                 Democratic People's Republic of Korea Developing Category B
# 721                 Democratic People's Republic of Korea Developing Category B
# 722                      Democratic Republic of the Congo Developing Category C
# 723                      Democratic Republic of the Congo Developing Category A
# 724                      Democratic Republic of the Congo Developing Category A
# 725                      Democratic Republic of the Congo Developing Category B
# 726                      Democratic Republic of the Congo Developing Category A
# 727                      Democratic Republic of the Congo Developing Category A
# 728                      Democratic Republic of the Congo Developing Category A
# 729                      Democratic Republic of the Congo Developing Category A
# 730                      Democratic Republic of the Congo Developing Category A
# 731                      Democratic Republic of the Congo Developing Category A
# 732                      Democratic Republic of the Congo Developing Category A
# 733                      Democratic Republic of the Congo Developing Category C
# 734                      Democratic Republic of the Congo Developing Category B
# 735                      Democratic Republic of the Congo Developing Category B
# 736                      Democratic Republic of the Congo Developing Category B
# 737                      Democratic Republic of the Congo Developing Category A
# 738                                               Denmark Developing Category A
# 739                                               Denmark Developing Category C
# 740                                               Denmark Developing Category C
# 741                                               Denmark Developing Category C
# 742                                               Denmark Developing Category B
# 743                                               Denmark Developing Category C
# 744                                               Denmark Developing Category C
# 745                                               Denmark Developing Category A
# 746                                               Denmark Developing Category B
# 747                                               Denmark Developing Category B
# 748                                               Denmark Developing Category B
# 749                                               Denmark Developing Category C
# 750                                               Denmark Developing Category B
# 751                                               Denmark Developing Category B
# 752                                               Denmark Developing Category B
# 753                                               Denmark Developing Category A
# 754                                              Djibouti Developing Category C
# 755                                              Djibouti Developing Category B
# 756                                              Djibouti Developing Category C
# 757                                              Djibouti Developing Category A
# 758                                              Djibouti Developing Category C
# 759                                              Djibouti Developing Category A
# 760                                              Djibouti Developing Category A
# 761                                              Djibouti Developing Category A
# 762                                              Djibouti Developing Category A
# 763                                              Djibouti Developing Category B
# 764                                              Djibouti Developing Category A
# 765                                              Djibouti Developing Category B
# 766                                              Djibouti Developing Category A
# 767                                              Djibouti Developing Category A
# 768                                              Djibouti Developing Category C
# 769                                              Djibouti Developing Category C
# 770                                              Dominica Developing Category A
# 771                                    Dominican Republic Developing Category A
# 772                                    Dominican Republic Developing Category B
# 773                                    Dominican Republic Developing Category B
# 774                                    Dominican Republic Developing Category B
# 775                                    Dominican Republic Developing Category B
# 776                                    Dominican Republic Developing Category A
# 777                                    Dominican Republic Developing Category A
# 778                                    Dominican Republic Developing Category C
# 779                                    Dominican Republic Developing Category A
# 780                                    Dominican Republic Developing Category B
# 781                                    Dominican Republic Developing Category A
# 782                                    Dominican Republic Developing Category B
# 783                                    Dominican Republic Developing Category A
# 784                                    Dominican Republic Developing Category B
# 785                                    Dominican Republic Developing Category C
# 786                                    Dominican Republic Developing Category A
# 787                                               Ecuador Developing Category C
# 788                                               Ecuador Developing Category B
# 789                                               Ecuador Developing Category C
# 790                                               Ecuador Developing Category B
# 791                                               Ecuador Developing Category B
# 792                                               Ecuador Developing Category C
# 793                                               Ecuador Developing Category C
# 794                                               Ecuador Developing Category A
# 795                                               Ecuador Developing Category A
# 796                                               Ecuador Developing Category A
# 797                                               Ecuador Developing Category C
# 798                                               Ecuador Developing Category C
# 799                                               Ecuador Developing Category C
# 800                                               Ecuador Developing Category C
# 801                                               Ecuador Developing Category C
# 802                                               Ecuador Developing Category B
# 803                                                 Egypt Developing Category B
# 804                                                 Egypt Developing Category B
# 805                                                 Egypt Developing Category B
# 806                                                 Egypt Developing Category A
# 807                                                 Egypt Developing Category C
# 808                                                 Egypt Developing Category B
# 809                                                 Egypt Developing Category A
# 810                                                 Egypt Developing Category C
# 811                                                 Egypt Developing Category A
# 812                                                 Egypt Developing Category B
# 813                                                 Egypt Developing Category B
# 814                                                 Egypt Developing Category A
# 815                                                 Egypt Developing Category A
# 816                                                 Egypt Developing Category A
# 817                                                 Egypt Developing Category A
# 818                                                 Egypt Developing Category A
# 819                                           El Salvador Developing Category C
# 820                                           El Salvador Developing Category C
# 821                                           El Salvador Developing Category A
# 822                                           El Salvador Developing Category C
# 823                                           El Salvador Developing Category B
# 824                                           El Salvador Developing Category A
# 825                                           El Salvador Developing Category C
# 826                                           El Salvador Developing Category B
# 827                                           El Salvador Developing Category C
# 828                                           El Salvador Developing Category B
# 829                                           El Salvador Developing Category B
# 830                                           El Salvador Developing Category C
# 831                                           El Salvador Developing Category B
# 832                                           El Salvador Developing Category A
# 833                                           El Salvador Developing Category C
# 834                                           El Salvador Developing Category A
# 835                                     Equatorial Guinea Developing Category C
# 836                                     Equatorial Guinea Developing Category A
# 837                                     Equatorial Guinea Developing Category A
# 838                                     Equatorial Guinea Developing Category B
# 839                                     Equatorial Guinea Developing Category A
# 840                                     Equatorial Guinea Developing Category C
# 841                                     Equatorial Guinea Developing Category A
# 842                                     Equatorial Guinea Developing Category B
# 843                                     Equatorial Guinea Developing Category B
# 844                                     Equatorial Guinea Developing Category B
# 845                                     Equatorial Guinea Developing Category A
# 846                                     Equatorial Guinea Developing Category A
# 847                                     Equatorial Guinea Developing Category A
# 848                                     Equatorial Guinea Developing Category A
# 849                                     Equatorial Guinea Developing Category B
# 850                                     Equatorial Guinea Developing Category B
# 851                                               Eritrea Developing Category A
# 852                                               Eritrea Developing Category B
# 853                                               Eritrea Developing Category C
# 854                                               Eritrea Developing Category B
# 855                                               Eritrea Developing Category C
# 856                                               Eritrea Developing Category B
# 857                                               Eritrea Developing Category B
# 858                                               Eritrea Developing Category B
# 859                                               Eritrea Developing Category B
# 860                                               Eritrea Developing Category C
# 861                                               Eritrea Developing Category B
# 862                                               Eritrea Developing Category B
# 863                                               Eritrea Developing Category C
# 864                                               Eritrea Developing Category C
# 865                                               Eritrea Developing Category C
# 866                                               Eritrea Developing Category A
# 867                                               Estonia Developing Category A
# 868                                               Estonia Developing Category C
# 869                                               Estonia Developing Category B
# 870                                               Estonia Developing Category C
# 871                                               Estonia Developing Category A
# 872                                               Estonia Developing Category B
# 873                                               Estonia Developing Category B
# 874                                               Estonia Developing Category C
# 875                                               Estonia Developing Category C
# 876                                               Estonia Developing Category A
# 877                                               Estonia Developing Category A
# 878                                               Estonia Developing Category A
# 879                                               Estonia Developing Category A
# 880                                               Estonia Developing Category B
# 881                                               Estonia Developing Category C
# 882                                               Estonia Developing Category C
# 883                                              Ethiopia Developing Category B
# 884                                              Ethiopia Developing Category A
# 885                                              Ethiopia Developing Category B
# 886                                              Ethiopia Developing Category C
# 887                                              Ethiopia Developing Category A
# 888                                              Ethiopia Developing Category B
# 889                                              Ethiopia Developing Category B
# 890                                              Ethiopia Developing Category A
# 891                                              Ethiopia Developing Category B
# 892                                              Ethiopia Developing Category B
# 893                                              Ethiopia Developing Category C
# 894                                              Ethiopia Developing Category A
# 895                                              Ethiopia Developing Category C
# 896                                              Ethiopia Developing Category A
# 897                                              Ethiopia Developing Category B
# 898                                              Ethiopia Developing Category C
# 899                                                  Fiji Developing Category A
# 900                                                  Fiji Developing Category B
# 901                                                  Fiji Developing Category B
# 902                                                  Fiji Developing Category B
# 903                                                  Fiji Developing Category B
# 904                                                  Fiji Developing Category C
# 905                                                  Fiji Developing Category A
# 906                                                  Fiji Developing Category C
# 907                                                  Fiji Developing Category B
# 908                                                  Fiji Developing Category A
# 909                                                  Fiji Developing Category C
# 910                                                  Fiji Developing Category A
# 911                                                  Fiji Developing Category B
# 912                                                  Fiji Developing Category A
# 913                                                  Fiji Developing Category B
# 914                                                  Fiji Developing Category A
# 915                                               Finland Developing Category B
# 916                                               Finland Developing Category A
# 917                                               Finland Developing Category B
# 918                                               Finland Developing Category B
# 919                                               Finland Developing Category C
# 920                                               Finland Developing Category A
# 921                                               Finland Developing Category A
# 922                                               Finland Developing Category C
# 923                                               Finland Developing Category A
# 924                                               Finland Developing Category B
# 925                                               Finland Developing Category A
# 926                                               Finland Developing Category B
# 927                                               Finland Developing Category C
# 928                                               Finland Developing Category C
# 929                                               Finland Developing Category C
# 930                                               Finland Developing Category B
# 931                                                France Developing Category C
# 932                                                France Developing Category B
# 933                                                France Developing Category B
# 934                                                France Developing Category B
# 935                                                France Developing Category B
# 936                                                France Developing Category C
# 937                                                France Developing Category C
# 938                                                France Developing Category C
# 939                                                France Developing Category C
# 940                                                France Developing Category B
# 941                                                France Developing Category B
# 942                                                France Developing Category B
# 943                                                France Developing Category A
# 944                                                France Developing Category C
# 945                                                France Developing Category A
# 946                                                France Developing Category A
# 947                                                 Gabon Developing Category C
# 948                                                 Gabon Developing Category A
# 949                                                 Gabon Developing Category C
# 950                                                 Gabon Developing Category A
# 951                                                 Gabon Developing Category A
# 952                                                 Gabon Developing Category A
# 953                                                 Gabon Developing Category C
# 954                                                 Gabon Developing Category C
# 955                                                 Gabon Developing Category B
# 956                                                 Gabon Developing Category C
# 957                                                 Gabon Developing Category A
# 958                                                 Gabon Developing Category B
# 959                                                 Gabon Developing Category A
# 960                                                 Gabon Developing Category B
# 961                                                 Gabon Developing Category C
# 962                                                 Gabon Developing Category B
# 963                                                Gambia Developing Category C
# 964                                                Gambia Developing Category B
# 965                                                Gambia Developing Category A
# 966                                                Gambia Developing Category B
# 967                                                Gambia Developing Category B
# 968                                                Gambia Developing Category A
# 969                                                Gambia Developing Category B
# 970                                                Gambia Developing Category C
# 971                                                Gambia Developing Category B
# 972                                                Gambia Developing Category A
# 973                                                Gambia Developing Category B
# 974                                                Gambia Developing Category A
# 975                                                Gambia Developing Category B
# 976                                                Gambia Developing Category C
# 977                                                Gambia Developing Category A
# 978                                                Gambia Developing Category C
# 979                                               Georgia Developing Category B
# 980                                               Georgia Developing Category C
# 981                                               Georgia Developing Category B
# 982                                               Georgia Developing Category B
# 983                                               Georgia Developing Category B
# 984                                               Georgia Developing Category B
# 985                                               Georgia Developing Category A
# 986                                               Georgia Developing Category A
# 987                                               Georgia Developing Category B
# 988                                               Georgia Developing Category C
# 989                                               Georgia Developing Category B
# 990                                               Georgia Developing Category A
# 991                                               Georgia Developing Category A
# 992                                               Georgia Developing Category B
# 993                                               Georgia Developing Category B
# 994                                               Georgia Developing Category A
# 995                                               Germany Developing Category A
# 996                                               Germany Developing Category A
# 997                                               Germany Developing Category C
# 998                                               Germany Developing Category A
# 999                                               Germany Developing Category B
# 1000                                              Germany Developing Category B
# 1001                                              Germany Developing Category B
# 1002                                              Germany Developing Category B
# 1003                                              Germany Developing Category A
# 1004                                              Germany Developing Category B
# 1005                                              Germany Developing Category A
# 1006                                              Germany Developing Category B
# 1007                                              Germany Developing Category C
# 1008                                              Germany Developing Category A
# 1009                                              Germany Developing Category A
# 1010                                              Germany Developing Category B
# 1011                                                Ghana Developing Category C
# 1012                                                Ghana Developing Category A
# 1013                                                Ghana Developing Category A
# 1014                                                Ghana Developing Category B
# 1015                                                Ghana Developing Category C
# 1016                                                Ghana Developing Category A
# 1017                                                Ghana Developing Category C
# 1018                                                Ghana Developing Category A
# 1019                                                Ghana Developing Category A
# 1020                                                Ghana Developing Category C
# 1021                                                Ghana Developing Category B
# 1022                                                Ghana Developing Category B
# 1023                                                Ghana Developing Category C
# 1024                                                Ghana Developing Category C
# 1025                                                Ghana Developing Category C
# 1026                                                Ghana Developing Category B
# 1027                                               Greece Developing Category B
# 1028                                               Greece Developing Category C
# 1029                                               Greece Developing Category B
# 1030                                               Greece Developing Category C
# 1031                                               Greece Developing Category B
# 1032                                               Greece Developing Category C
# 1033                                               Greece Developing Category A
# 1034                                               Greece Developing Category C
# 1035                                               Greece Developing Category A
# 1036                                               Greece Developing Category A
# 1037                                               Greece Developing Category A
# 1038                                               Greece Developing Category C
# 1039                                               Greece Developing Category A
# 1040                                               Greece Developing Category C
# 1041                                               Greece Developing Category C
# 1042                                               Greece Developing Category B
# 1043                                              Grenada Developing Category B
# 1044                                              Grenada Developing Category A
# 1045                                              Grenada Developing Category C
# 1046                                              Grenada Developing Category C
# 1047                                              Grenada Developing Category A
# 1048                                              Grenada Developing Category A
# 1049                                              Grenada Developing Category A
# 1050                                              Grenada Developing Category C
# 1051                                              Grenada Developing Category A
# 1052                                              Grenada Developing Category A
# 1053                                              Grenada Developing Category C
# 1054                                              Grenada Developing Category C
# 1055                                              Grenada Developing Category B
# 1056                                              Grenada Developing Category A
# 1057                                              Grenada Developing Category B
# 1058                                              Grenada Developing Category A
# 1059                                            Guatemala Developing Category A
# 1060                                            Guatemala Developing Category C
# 1061                                            Guatemala Developing Category C
# 1062                                            Guatemala Developing Category C
# 1063                                            Guatemala Developing Category B
# 1064                                            Guatemala Developing Category B
# 1065                                            Guatemala Developing Category B
# 1066                                            Guatemala Developing Category C
# 1067                                            Guatemala Developing Category C
# 1068                                            Guatemala Developing Category A
# 1069                                            Guatemala Developing Category A
# 1070                                            Guatemala Developing Category C
# 1071                                            Guatemala Developing Category A
# 1072                                            Guatemala Developing Category C
# 1073                                            Guatemala Developing Category B
# 1074                                            Guatemala Developing Category B
# 1075                                               Guinea Developing Category C
# 1076                                               Guinea Developing Category C
# 1077                                               Guinea Developing Category A
# 1078                                               Guinea Developing Category C
# 1079                                               Guinea Developing Category B
# 1080                                               Guinea Developing Category A
# 1081                                               Guinea Developing Category A
# 1082                                               Guinea Developing Category C
# 1083                                               Guinea Developing Category A
# 1084                                               Guinea Developing Category C
# 1085                                               Guinea Developing Category B
# 1086                                               Guinea Developing Category B
# 1087                                               Guinea Developing Category A
# 1088                                               Guinea Developing Category A
# 1089                                               Guinea Developing Category C
# 1090                                               Guinea Developing Category B
# 1091                                        Guinea-Bissau Developing Category C
# 1092                                        Guinea-Bissau Developing Category C
# 1093                                        Guinea-Bissau Developing Category B
# 1094                                        Guinea-Bissau Developing Category C
# 1095                                        Guinea-Bissau Developing Category B
# 1096                                        Guinea-Bissau Developing Category B
# 1097                                        Guinea-Bissau Developing Category C
# 1098                                        Guinea-Bissau Developing Category A
# 1099                                        Guinea-Bissau Developing Category A
# 1100                                        Guinea-Bissau Developing Category A
# 1101                                        Guinea-Bissau Developing Category C
# 1102                                        Guinea-Bissau Developing Category C
# 1103                                        Guinea-Bissau Developing Category B
# 1104                                        Guinea-Bissau Developing Category B
# 1105                                        Guinea-Bissau Developing Category C
# 1106                                        Guinea-Bissau Developing Category A
# 1107                                               Guyana Developing Category C
# 1108                                               Guyana Developing Category A
# 1109                                               Guyana Developing Category B
# 1110                                               Guyana Developing Category B
# 1111                                               Guyana Developing Category A
# 1112                                               Guyana Developing Category A
# 1113                                               Guyana Developing Category C
# 1114                                               Guyana Developing Category B
# 1115                                               Guyana Developing Category C
# 1116                                               Guyana Developing Category C
# 1117                                               Guyana Developing Category B
# 1118                                               Guyana Developing Category A
# 1119                                               Guyana Developing Category A
# 1120                                               Guyana Developing Category C
# 1121                                               Guyana Developing Category C
# 1122                                               Guyana Developing Category C
# 1123                                                Haiti Developing Category B
# 1124                                                Haiti Developing Category B
# 1125                                                Haiti Developing Category A
# 1126                                                Haiti Developing Category B
# 1127                                                Haiti Developing Category C
# 1128                                                Haiti Developing Category A
# 1129                                                Haiti Developing Category B
# 1130                                                Haiti Developing Category B
# 1131                                                Haiti Developing Category A
# 1132                                                Haiti Developing Category C
# 1133                                                Haiti Developing Category A
# 1134                                                Haiti Developing Category B
# 1135                                                Haiti Developing Category A
# 1136                                                Haiti Developing Category A
# 1137                                                Haiti Developing Category B
# 1138                                                Haiti Developing Category B
# 1139                                             Honduras Developing Category A
# 1140                                             Honduras Developing Category C
# 1141                                             Honduras Developing Category B
# 1142                                             Honduras Developing Category B
# 1143                                             Honduras Developing Category B
# 1144                                             Honduras Developing Category C
# 1145                                             Honduras Developing Category A
# 1146                                             Honduras Developing Category A
# 1147                                             Honduras Developing Category C
# 1148                                             Honduras Developing Category B
# 1149                                             Honduras Developing Category C
# 1150                                             Honduras Developing Category C
# 1151                                             Honduras Developing Category A
# 1152                                             Honduras Developing Category B
# 1153                                             Honduras Developing Category B
# 1154                                             Honduras Developing Category C
# 1155                                              Hungary Developing Category C
# 1156                                              Hungary Developing Category B
# 1157                                              Hungary Developing Category C
# 1158                                              Hungary Developing Category B
# 1159                                              Hungary Developing Category C
# 1160                                              Hungary Developing Category A
# 1161                                              Hungary Developing Category B
# 1162                                              Hungary Developing Category A
# 1163                                              Hungary Developing Category B
# 1164                                              Hungary Developing Category A
# 1165                                              Hungary Developing Category A
# 1166                                              Hungary Developing Category B
# 1167                                              Hungary Developing Category A
# 1168                                              Hungary Developing Category A
# 1169                                              Hungary Developing Category C
# 1170                                              Hungary Developing Category C
# 1171                                              Iceland Developing Category A
# 1172                                              Iceland Developing Category C
# 1173                                              Iceland Developing Category B
# 1174                                              Iceland Developing Category B
# 1175                                              Iceland Developing Category A
# 1176                                              Iceland Developing Category A
# 1177                                              Iceland Developing Category C
# 1178                                              Iceland Developing Category A
# 1179                                              Iceland Developing Category A
# 1180                                              Iceland Developing Category C
# 1181                                              Iceland Developing Category C
# 1182                                              Iceland Developing Category C
# 1183                                              Iceland Developing Category C
# 1184                                              Iceland Developing Category C
# 1185                                              Iceland Developing Category C
# 1186                                              Iceland Developing Category C
# 1187                                                India Developing Category B
# 1188                                                India Developing Category A
# 1189                                                India Developing Category C
# 1190                                                India Developing Category A
# 1191                                                India Developing Category B
# 1192                                                India Developing Category B
# 1193                                                India Developing Category C
# 1194                                                India Developing Category C
# 1195                                                India Developing Category A
# 1196                                                India Developing Category B
# 1197                                                India Developing Category B
# 1198                                                India Developing Category C
# 1199                                                India Developing Category C
# 1200                                                India Developing Category A
# 1201                                                India Developing Category A
# 1202                                                India Developing Category C
# 1203                                            Indonesia Developing Category B
# 1204                                            Indonesia Developing Category A
# 1205                                            Indonesia Developing Category C
# 1206                                            Indonesia Developing Category A
# 1207                                            Indonesia Developing Category B
# 1208                                            Indonesia Developing Category B
# 1209                                            Indonesia Developing Category B
# 1210                                            Indonesia Developing Category C
# 1211                                            Indonesia Developing Category A
# 1212                                            Indonesia Developing Category C
# 1213                                            Indonesia Developing Category A
# 1214                                            Indonesia Developing Category A
# 1215                                            Indonesia Developing Category C
# 1216                                            Indonesia Developing Category A
# 1217                                            Indonesia Developing Category A
# 1218                                            Indonesia Developing Category C
# 1219                           Iran (Islamic Republic of) Developing Category C
# 1220                           Iran (Islamic Republic of) Developing Category B
# 1221                           Iran (Islamic Republic of) Developing Category A
# 1222                           Iran (Islamic Republic of) Developing Category B
# 1223                           Iran (Islamic Republic of) Developing Category A
# 1224                           Iran (Islamic Republic of) Developing Category B
# 1225                           Iran (Islamic Republic of) Developing Category C
# 1226                           Iran (Islamic Republic of) Developing Category B
# 1227                           Iran (Islamic Republic of) Developing Category C
# 1228                           Iran (Islamic Republic of) Developing Category A
# 1229                           Iran (Islamic Republic of) Developing Category B
# 1230                           Iran (Islamic Republic of) Developing Category B
# 1231                           Iran (Islamic Republic of) Developing Category B
# 1232                           Iran (Islamic Republic of) Developing Category A
# 1233                           Iran (Islamic Republic of) Developing Category C
# 1234                           Iran (Islamic Republic of) Developing Category C
# 1235                                                 Iraq Developing Category A
# 1236                                                 Iraq Developing Category C
# 1237                                                 Iraq Developing Category A
# 1238                                                 Iraq Developing Category C
# 1239                                                 Iraq Developing Category C
# 1240                                                 Iraq Developing Category B
# 1241                                                 Iraq Developing Category A
# 1242                                                 Iraq Developing Category C
# 1243                                                 Iraq Developing Category A
# 1244                                                 Iraq Developing Category C
# 1245                                                 Iraq Developing Category C
# 1246                                                 Iraq Developing Category A
# 1247                                                 Iraq Developing Category A
# 1248                                                 Iraq Developing Category A
# 1249                                                 Iraq Developing Category B
# 1250                                                 Iraq Developing Category B
# 1251                                              Ireland Developing Category B
# 1252                                              Ireland Developing Category C
# 1253                                              Ireland Developing Category B
# 1254                                              Ireland Developing Category A
# 1255                                              Ireland Developing Category C
# 1256                                              Ireland Developing Category C
# 1257                                              Ireland Developing Category C
# 1258                                              Ireland Developing Category B
# 1259                                              Ireland Developing Category B
# 1260                                              Ireland Developing Category C
# 1261                                              Ireland Developing Category A
# 1262                                              Ireland Developing Category B
# 1263                                              Ireland Developing Category A
# 1264                                              Ireland Developing Category A
# 1265                                              Ireland Developing Category A
# 1266                                              Ireland Developing Category B
# 1267                                               Israel Developing Category C
# 1268                                               Israel Developing Category B
# 1269                                               Israel Developing Category B
# 1270                                               Israel Developing Category A
# 1271                                               Israel Developing Category C
# 1272                                               Israel Developing Category A
# 1273                                               Israel Developing Category B
# 1274                                               Israel Developing Category A
# 1275                                               Israel Developing Category C
# 1276                                               Israel Developing Category A
# 1277                                               Israel Developing Category B
# 1278                                               Israel Developing Category C
# 1279                                               Israel Developing Category A
# 1280                                               Israel Developing Category C
# 1281                                               Israel Developing Category C
# 1282                                               Israel Developing Category C
# 1283                                                Italy Developing Category B
# 1284                                                Italy Developing Category A
# 1285                                                Italy Developing Category B
# 1286                                                Italy Developing Category A
# 1287                                                Italy Developing Category B
# 1288                                                Italy Developing Category C
# 1289                                                Italy Developing Category A
# 1290                                                Italy Developing Category A
# 1291                                                Italy Developing Category A
# 1292                                                Italy Developing Category A
# 1293                                                Italy Developing Category A
# 1294                                                Italy Developing Category A
# 1295                                                Italy Developing Category A
# 1296                                                Italy Developing Category C
# 1297                                                Italy Developing Category A
# 1298                                                Italy Developing Category A
# 1299                                              Jamaica Developing Category C
# 1300                                              Jamaica Developing Category B
# 1301                                              Jamaica Developing Category C
# 1302                                              Jamaica Developing Category B
# 1303                                              Jamaica Developing Category B
# 1304                                              Jamaica Developing Category A
# 1305                                              Jamaica Developing Category A
# 1306                                              Jamaica Developing Category A
# 1307                                              Jamaica Developing Category A
# 1308                                              Jamaica Developing Category B
# 1309                                              Jamaica Developing Category C
# 1310                                              Jamaica Developing Category A
# 1311                                              Jamaica Developing Category C
# 1312                                              Jamaica Developing Category A
# 1313                                              Jamaica Developing Category C
# 1314                                              Jamaica Developing Category B
# 1315                                                Japan Developing Category B
# 1316                                                Japan Developing Category C
# 1317                                                Japan Developing Category C
# 1318                                                Japan Developing Category C
# 1319                                                Japan Developing Category B
# 1320                                                Japan Developing Category C
# 1321                                                Japan Developing Category B
# 1322                                                Japan Developing Category A
# 1323                                                Japan Developing Category C
# 1324                                                Japan Developing Category A
# 1325                                                Japan Developing Category B
# 1326                                                Japan Developing Category C
# 1327                                                Japan Developing Category A
# 1328                                                Japan Developing Category B
# 1329                                                Japan Developing Category C
# 1330                                                Japan Developing Category A
# 1331                                               Jordan Developing Category A
# 1332                                               Jordan Developing Category B
# 1333                                               Jordan Developing Category C
# 1334                                               Jordan Developing Category B
# 1335                                               Jordan Developing Category A
# 1336                                               Jordan Developing Category C
# 1337                                               Jordan Developing Category B
# 1338                                               Jordan Developing Category B
# 1339                                               Jordan Developing Category A
# 1340                                               Jordan Developing Category A
# 1341                                               Jordan Developing Category A
# 1342                                               Jordan Developing Category B
# 1343                                               Jordan Developing Category C
# 1344                                               Jordan Developing Category A
# 1345                                               Jordan Developing Category A
# 1346                                               Jordan Developing Category B
# 1347                                           Kazakhstan Developing Category B
# 1348                                           Kazakhstan Developing Category C
# 1349                                           Kazakhstan Developing Category C
# 1350                                           Kazakhstan Developing Category C
# 1351                                           Kazakhstan Developing Category C
# 1352                                           Kazakhstan Developing Category A
# 1353                                           Kazakhstan Developing Category A
# 1354                                           Kazakhstan Developing Category B
# 1355                                           Kazakhstan Developing Category A
# 1356                                           Kazakhstan Developing Category A
# 1357                                           Kazakhstan Developing Category A
# 1358                                           Kazakhstan Developing Category B
# 1359                                           Kazakhstan Developing Category C
# 1360                                           Kazakhstan Developing Category C
# 1361                                           Kazakhstan Developing Category B
# 1362                                           Kazakhstan Developing Category B
# 1363                                                Kenya Developing Category A
# 1364                                                Kenya Developing Category A
# 1365                                                Kenya Developing Category A
# 1366                                                Kenya Developing Category A
# 1367                                                Kenya Developing Category B
# 1368                                                Kenya Developing Category C
# 1369                                                Kenya Developing Category B
# 1370                                                Kenya Developing Category C
# 1371                                                Kenya Developing Category B
# 1372                                                Kenya Developing Category C
# 1373                                                Kenya Developing Category C
# 1374                                                Kenya Developing Category C
# 1375                                                Kenya Developing Category A
# 1376                                                Kenya Developing Category C
# 1377                                                Kenya Developing Category A
# 1378                                                Kenya Developing Category B
# 1379                                             Kiribati Developing Category A
# 1380                                             Kiribati Developing Category C
# 1381                                             Kiribati Developing Category A
# 1382                                             Kiribati Developing Category C
# 1383                                             Kiribati Developing Category A
# 1384                                             Kiribati Developing Category A
# 1385                                             Kiribati Developing Category B
# 1386                                             Kiribati Developing Category B
# 1387                                             Kiribati Developing Category A
# 1388                                             Kiribati Developing Category B
# 1389                                             Kiribati Developing Category A
# 1390                                             Kiribati Developing Category A
# 1391                                             Kiribati Developing Category A
# 1392                                             Kiribati Developing Category B
# 1393                                             Kiribati Developing Category C
# 1394                                             Kiribati Developing Category A
# 1395                                               Kuwait Developing Category A
# 1396                                               Kuwait Developing Category C
# 1397                                               Kuwait Developing Category B
# 1398                                               Kuwait Developing Category B
# 1399                                               Kuwait Developing Category B
# 1400                                               Kuwait Developing Category C
# 1401                                               Kuwait Developing Category B
# 1402                                               Kuwait Developing Category C
# 1403                                               Kuwait Developing Category C
# 1404                                               Kuwait Developing Category B
# 1405                                               Kuwait Developing Category B
# 1406                                               Kuwait Developing Category A
# 1407                                               Kuwait Developing Category C
# 1408                                               Kuwait Developing Category B
# 1409                                               Kuwait Developing Category B
# 1410                                               Kuwait Developing Category C
# 1411                                           Kyrgyzstan Developing Category A
# 1412                                           Kyrgyzstan Developing Category C
# 1413                                           Kyrgyzstan Developing Category A
# 1414                                           Kyrgyzstan Developing Category B
# 1415                                           Kyrgyzstan Developing Category B
# 1416                                           Kyrgyzstan Developing Category B
# 1417                                           Kyrgyzstan Developing Category C
# 1418                                           Kyrgyzstan Developing Category A
# 1419                                           Kyrgyzstan Developing Category B
# 1420                                           Kyrgyzstan Developing Category C
# 1421                                           Kyrgyzstan Developing Category B
# 1422                                           Kyrgyzstan Developing Category B
# 1423                                           Kyrgyzstan Developing Category C
# 1424                                           Kyrgyzstan Developing Category A
# 1425                                           Kyrgyzstan Developing Category A
# 1426                                           Kyrgyzstan Developing Category A
# 1427                     Lao People's Democratic Republic Developing Category A
# 1428                     Lao People's Democratic Republic Developing Category A
# 1429                     Lao People's Democratic Republic Developing Category B
# 1430                     Lao People's Democratic Republic Developing Category A
# 1431                     Lao People's Democratic Republic Developing Category C
# 1432                     Lao People's Democratic Republic Developing Category C
# 1433                     Lao People's Democratic Republic Developing Category C
# 1434                     Lao People's Democratic Republic Developing Category A
# 1435                     Lao People's Democratic Republic Developing Category B
# 1436                     Lao People's Democratic Republic Developing Category A
# 1437                     Lao People's Democratic Republic Developing Category C
# 1438                     Lao People's Democratic Republic Developing Category C
# 1439                     Lao People's Democratic Republic Developing Category C
# 1440                     Lao People's Democratic Republic Developing Category A
# 1441                     Lao People's Democratic Republic Developing Category B
# 1442                     Lao People's Democratic Republic Developing Category A
# 1443                                               Latvia Developing Category B
# 1444                                               Latvia Developing Category B
# 1445                                               Latvia Developing Category A
# 1446                                               Latvia Developing Category C
# 1447                                               Latvia Developing Category A
# 1448                                               Latvia Developing Category B
# 1449                                               Latvia Developing Category A
# 1450                                               Latvia Developing Category C
# 1451                                               Latvia Developing Category A
# 1452                                               Latvia Developing Category A
# 1453                                               Latvia Developing Category B
# 1454                                               Latvia Developing Category C
# 1455                                               Latvia Developing Category B
# 1456                                               Latvia Developing Category B
# 1457                                               Latvia Developing Category A
# 1458                                               Latvia Developing Category A
# 1459                                              Lebanon Developing Category A
# 1460                                              Lebanon Developing Category C
# 1461                                              Lebanon Developing Category A
# 1462                                              Lebanon Developing Category C
# 1463                                              Lebanon Developing Category B
# 1464                                              Lebanon Developing Category A
# 1465                                              Lebanon Developing Category B
# 1466                                              Lebanon Developing Category A
# 1467                                              Lebanon Developing Category A
# 1468                                              Lebanon Developing Category A
# 1469                                              Lebanon Developing Category B
# 1470                                              Lebanon Developing Category B
# 1471                                              Lebanon Developing Category C
# 1472                                              Lebanon Developing Category C
# 1473                                              Lebanon Developing Category A
# 1474                                              Lebanon Developing Category B
# 1475                                              Lesotho Developing Category A
# 1476                                              Lesotho Developing Category A
# 1477                                              Lesotho Developing Category B
# 1478                                              Lesotho Developing Category C
# 1479                                              Lesotho Developing Category B
# 1480                                              Lesotho Developing Category A
# 1481                                              Lesotho Developing Category B
# 1482                                              Lesotho Developing Category C
# 1483                                              Lesotho Developing Category A
# 1484                                              Lesotho Developing Category C
# 1485                                              Lesotho Developing Category A
# 1486                                              Lesotho Developing Category B
# 1487                                              Lesotho Developing Category A
# 1488                                              Lesotho Developing Category A
# 1489                                              Lesotho Developing Category B
# 1490                                              Lesotho Developing Category B
# 1491                                              Liberia Developing Category B
# 1492                                              Liberia Developing Category B
# 1493                                              Liberia Developing Category A
# 1494                                              Liberia Developing Category B
# 1495                                              Liberia Developing Category B
# 1496                                              Liberia Developing Category A
# 1497                                              Liberia Developing Category C
# 1498                                              Liberia Developing Category A
# 1499                                              Liberia Developing Category A
# 1500                                              Liberia Developing Category C
# 1501                                              Liberia Developing Category A
# 1502                                              Liberia Developing Category B
# 1503                                              Liberia Developing Category A
# 1504                                              Liberia Developing Category A
# 1505                                              Liberia Developing Category B
# 1506                                              Liberia Developing Category A
# 1507                                                Libya Developing Category B
# 1508                                                Libya Developing Category C
# 1509                                                Libya Developing Category A
# 1510                                                Libya Developing Category C
# 1511                                                Libya Developing Category A
# 1512                                                Libya Developing Category A
# 1513                                                Libya Developing Category B
# 1514                                                Libya Developing Category B
# 1515                                                Libya Developing Category B
# 1516                                                Libya Developing Category C
# 1517                                                Libya Developing Category C
# 1518                                                Libya Developing Category A
# 1519                                                Libya Developing Category A
# 1520                                                Libya Developing Category B
# 1521                                                Libya Developing Category C
# 1522                                                Libya Developing Category A
# 1523                                            Lithuania Developing Category A
# 1524                                            Lithuania Developing Category A
# 1525                                            Lithuania Developing Category A
# 1526                                            Lithuania Developing Category C
# 1527                                            Lithuania Developing Category B
# 1528                                            Lithuania Developing Category A
# 1529                                            Lithuania Developing Category C
# 1530                                            Lithuania Developing Category A
# 1531                                            Lithuania Developing Category B
# 1532                                            Lithuania Developing Category B
# 1533                                            Lithuania Developing Category B
# 1534                                            Lithuania Developing Category C
# 1535                                            Lithuania Developing Category B
# 1536                                            Lithuania Developing Category C
# 1537                                            Lithuania Developing Category C
# 1538                                            Lithuania Developing Category B
# 1539                                           Luxembourg Developing Category C
# 1540                                           Luxembourg Developing Category C
# 1541                                           Luxembourg Developing Category C
# 1542                                           Luxembourg Developing Category A
# 1543                                           Luxembourg Developing Category B
# 1544                                           Luxembourg Developing Category B
# 1545                                           Luxembourg Developing Category C
# 1546                                           Luxembourg Developing Category B
# 1547                                           Luxembourg Developing Category C
# 1548                                           Luxembourg Developing Category B
# 1549                                           Luxembourg Developing Category A
# 1550                                           Luxembourg Developing Category B
# 1551                                           Luxembourg Developing Category C
# 1552                                           Luxembourg Developing Category B
# 1553                                           Luxembourg Developing Category B
# 1554                                           Luxembourg Developing Category B
# 1555                                           Madagascar Developing Category B
# 1556                                           Madagascar Developing Category A
# 1557                                           Madagascar Developing Category C
# 1558                                           Madagascar Developing Category B
# 1559                                           Madagascar Developing Category C
# 1560                                           Madagascar Developing Category A
# 1561                                           Madagascar Developing Category B
# 1562                                           Madagascar Developing Category B
# 1563                                           Madagascar Developing Category C
# 1564                                           Madagascar Developing Category B
# 1565                                           Madagascar Developing Category B
# 1566                                           Madagascar Developing Category A
# 1567                                           Madagascar Developing Category C
# 1568                                           Madagascar Developing Category B
# 1569                                           Madagascar Developing Category B
# 1570                                           Madagascar Developing Category A
# 1571                                               Malawi Developing Category A
# 1572                                               Malawi Developing Category B
# 1573                                               Malawi Developing Category A
# 1574                                               Malawi Developing Category B
# 1575                                               Malawi Developing Category C
# 1576                                               Malawi Developing Category A
# 1577                                               Malawi Developing Category C
# 1578                                               Malawi Developing Category B
# 1579                                               Malawi Developing Category A
# 1580                                               Malawi Developing Category B
# 1581                                               Malawi Developing Category B
# 1582                                               Malawi Developing Category C
# 1583                                               Malawi Developing Category B
# 1584                                               Malawi Developing Category A
# 1585                                               Malawi Developing Category A
# 1586                                               Malawi Developing Category B
# 1587                                             Malaysia Developing Category A
# 1588                                             Malaysia Developing Category A
# 1589                                             Malaysia Developing Category B
# 1590                                             Malaysia Developing Category C
# 1591                                             Malaysia Developing Category A
# 1592                                             Malaysia Developing Category C
# 1593                                             Malaysia Developing Category B
# 1594                                             Malaysia Developing Category A
# 1595                                             Malaysia Developing Category C
# 1596                                             Malaysia Developing Category B
# 1597                                             Malaysia Developing Category C
# 1598                                             Malaysia Developing Category C
# 1599                                             Malaysia Developing Category B
# 1600                                             Malaysia Developing Category A
# 1601                                             Malaysia Developing Category B
# 1602                                             Malaysia Developing Category A
# 1603                                             Maldives Developing Category B
# 1604                                             Maldives Developing Category C
# 1605                                             Maldives Developing Category B
# 1606                                             Maldives Developing Category A
# 1607                                             Maldives Developing Category C
# 1608                                             Maldives Developing Category B
# 1609                                             Maldives Developing Category A
# 1610                                             Maldives Developing Category B
# 1611                                             Maldives Developing Category A
# 1612                                             Maldives Developing Category B
# 1613                                             Maldives Developing Category B
# 1614                                             Maldives Developing Category A
# 1615                                             Maldives Developing Category C
# 1616                                             Maldives Developing Category B
# 1617                                             Maldives Developing Category B
# 1618                                             Maldives Developing Category C
# 1619                                                 Mali Developing Category B
# 1620                                                 Mali Developing Category A
# 1621                                                 Mali Developing Category C
# 1622                                                 Mali Developing Category B
# 1623                                                 Mali Developing Category A
# 1624                                                 Mali Developing Category A
# 1625                                                 Mali Developing Category A
# 1626                                                 Mali Developing Category A
# 1627                                                 Mali Developing Category B
# 1628                                                 Mali Developing Category C
# 1629                                                 Mali Developing Category B
# 1630                                                 Mali Developing Category B
# 1631                                                 Mali Developing Category B
# 1632                                                 Mali Developing Category A
# 1633                                                 Mali Developing Category B
# 1634                                                 Mali Developing Category B
# 1635                                                Malta Developing Category A
# 1636                                                Malta Developing Category C
# 1637                                                Malta Developing Category C
# 1638                                                Malta Developing Category B
# 1639                                                Malta Developing Category B
# 1640                                                Malta Developing Category C
# 1641                                                Malta Developing Category C
# 1642                                                Malta Developing Category B
# 1643                                                Malta Developing Category C
# 1644                                                Malta Developing Category C
# 1645                                                Malta Developing Category A
# 1646                                                Malta Developing Category C
# 1647                                                Malta Developing Category B
# 1648                                                Malta Developing Category A
# 1649                                                Malta Developing Category B
# 1650                                                Malta Developing Category B
# 1651                                     Marshall Islands Developing Category A
# 1652                                           Mauritania Developing Category C
# 1653                                           Mauritania Developing Category A
# 1654                                           Mauritania Developing Category C
# 1655                                           Mauritania Developing Category A
# 1656                                           Mauritania Developing Category C
# 1657                                           Mauritania Developing Category B
# 1658                                           Mauritania Developing Category A
# 1659                                           Mauritania Developing Category A
# 1660                                           Mauritania Developing Category C
# 1661                                           Mauritania Developing Category B
# 1662                                           Mauritania Developing Category A
# 1663                                           Mauritania Developing Category B
# 1664                                           Mauritania Developing Category B
# 1665                                           Mauritania Developing Category C
# 1666                                           Mauritania Developing Category C
# 1667                                           Mauritania Developing Category B
# 1668                                            Mauritius Developing Category B
# 1669                                            Mauritius Developing Category A
# 1670                                            Mauritius Developing Category B
# 1671                                            Mauritius Developing Category A
# 1672                                            Mauritius Developing Category B
# 1673                                            Mauritius Developing Category A
# 1674                                            Mauritius Developing Category C
# 1675                                            Mauritius Developing Category C
# 1676                                            Mauritius Developing Category C
# 1677                                            Mauritius Developing Category A
# 1678                                            Mauritius Developing Category B
# 1679                                            Mauritius Developing Category C
# 1680                                            Mauritius Developing Category C
# 1681                                            Mauritius Developing Category B
# 1682                                            Mauritius Developing Category A
# 1683                                            Mauritius Developing Category A
# 1684                                               Mexico Developing Category C
# 1685                                               Mexico Developing Category C
# 1686                                               Mexico Developing Category C
# 1687                                               Mexico Developing Category C
# 1688                                               Mexico Developing Category C
# 1689                                               Mexico Developing Category A
# 1690                                               Mexico Developing Category A
# 1691                                               Mexico Developing Category B
# 1692                                               Mexico Developing Category B
# 1693                                               Mexico Developing Category A
# 1694                                               Mexico Developing Category B
# 1695                                               Mexico Developing Category B
# 1696                                               Mexico Developing Category C
# 1697                                               Mexico Developing Category C
# 1698                                               Mexico Developing Category C
# 1699                                               Mexico Developing Category B
# 1700                     Micronesia (Federated States of) Developing Category A
# 1701                     Micronesia (Federated States of) Developing Category A
# 1702                     Micronesia (Federated States of) Developing Category B
# 1703                     Micronesia (Federated States of) Developing Category A
# 1704                     Micronesia (Federated States of) Developing Category A
# 1705                     Micronesia (Federated States of) Developing Category C
# 1706                     Micronesia (Federated States of) Developing Category A
# 1707                     Micronesia (Federated States of) Developing Category B
# 1708                     Micronesia (Federated States of) Developing Category C
# 1709                     Micronesia (Federated States of) Developing Category B
# 1710                     Micronesia (Federated States of) Developing Category B
# 1711                     Micronesia (Federated States of) Developing Category A
# 1712                     Micronesia (Federated States of) Developing Category B
# 1713                     Micronesia (Federated States of) Developing Category A
# 1714                     Micronesia (Federated States of) Developing Category A
# 1715                     Micronesia (Federated States of) Developing Category C
# 1716                                               Monaco Developing Category B
# 1717                                             Mongolia Developing Category A
# 1718                                             Mongolia Developing Category C
# 1719                                             Mongolia Developing Category C
# 1720                                             Mongolia Developing Category A
# 1721                                             Mongolia Developing Category A
# 1722                                             Mongolia Developing Category A
# 1723                                             Mongolia Developing Category A
# 1724                                             Mongolia Developing Category C
# 1725                                             Mongolia Developing Category B
# 1726                                             Mongolia Developing Category A
# 1727                                             Mongolia Developing Category B
# 1728                                             Mongolia Developing Category C
# 1729                                             Mongolia Developing Category A
# 1730                                             Mongolia Developing Category B
# 1731                                             Mongolia Developing Category C
# 1732                                             Mongolia Developing Category C
# 1733                                           Montenegro Developing Category B
# 1734                                           Montenegro Developing Category B
# 1735                                           Montenegro Developing Category A
# 1736                                           Montenegro Developing Category A
# 1737                                           Montenegro Developing Category B
# 1738                                           Montenegro Developing Category B
# 1739                                           Montenegro Developing Category A
# 1740                                           Montenegro Developing Category B
# 1741                                           Montenegro Developing Category C
# 1742                                           Montenegro Developing Category A
# 1743                                           Montenegro Developing Category A
# 1744                                           Montenegro Developing Category C
# 1745                                           Montenegro Developing Category A
# 1746                                           Montenegro Developing Category B
# 1747                                           Montenegro Developing Category C
# 1748                                           Montenegro Developing Category B
# 1749                                              Morocco Developing Category C
# 1750                                              Morocco Developing Category A
# 1751                                              Morocco Developing Category A
# 1752                                              Morocco Developing Category C
# 1753                                              Morocco Developing Category A
# 1754                                              Morocco Developing Category A
# 1755                                              Morocco Developing Category C
# 1756                                              Morocco Developing Category C
# 1757                                              Morocco Developing Category B
# 1758                                              Morocco Developing Category A
# 1759                                              Morocco Developing Category B
# 1760                                              Morocco Developing Category C
# 1761                                              Morocco Developing Category A
# 1762                                              Morocco Developing Category C
# 1763                                              Morocco Developing Category A
# 1764                                              Morocco Developing Category A
# 1765                                           Mozambique Developing Category B
# 1766                                           Mozambique Developing Category C
# 1767                                           Mozambique Developing Category B
# 1768                                           Mozambique Developing Category A
# 1769                                           Mozambique Developing Category C
# 1770                                           Mozambique Developing Category A
# 1771                                           Mozambique Developing Category C
# 1772                                           Mozambique Developing Category A
# 1773                                           Mozambique Developing Category C
# 1774                                           Mozambique Developing Category B
# 1775                                           Mozambique Developing Category C
# 1776                                           Mozambique Developing Category B
# 1777                                           Mozambique Developing Category A
# 1778                                           Mozambique Developing Category A
# 1779                                           Mozambique Developing Category A
# 1780                                           Mozambique Developing Category A
# 1781                                              Myanmar Developing Category C
# 1782                                              Myanmar Developing Category B
# 1783                                              Myanmar Developing Category C
# 1784                                              Myanmar Developing Category A
# 1785                                              Myanmar Developing Category C
# 1786                                              Myanmar Developing Category A
# 1787                                              Myanmar Developing Category C
# 1788                                              Myanmar Developing Category A
# 1789                                              Myanmar Developing Category C
# 1790                                              Myanmar Developing Category B
# 1791                                              Myanmar Developing Category A
# 1792                                              Myanmar Developing Category C
# 1793                                              Myanmar Developing Category C
# 1794                                              Myanmar Developing Category C
# 1795                                              Myanmar Developing Category A
# 1796                                              Myanmar Developing Category B
# 1797                                              Namibia Developing Category B
# 1798                                              Namibia Developing Category A
# 1799                                              Namibia Developing Category A
# 1800                                              Namibia Developing Category A
# 1801                                              Namibia Developing Category C
# 1802                                              Namibia Developing Category A
# 1803                                              Namibia Developing Category A
# 1804                                              Namibia Developing Category B
# 1805                                              Namibia Developing Category B
# 1806                                              Namibia Developing Category B
# 1807                                              Namibia Developing Category A
# 1808                                              Namibia Developing Category B
# 1809                                              Namibia Developing Category A
# 1810                                              Namibia Developing Category A
# 1811                                              Namibia Developing Category C
# 1812                                              Namibia Developing Category C
# 1813                                                Nauru Developing Category B
# 1814                                                Nepal Developing Category A
# 1815                                                Nepal Developing Category C
# 1816                                                Nepal Developing Category A
# 1817                                                Nepal Developing Category B
# 1818                                                Nepal Developing Category B
# 1819                                                Nepal Developing Category A
# 1820                                                Nepal Developing Category C
# 1821                                                Nepal Developing Category B
# 1822                                                Nepal Developing Category A
# 1823                                                Nepal Developing Category C
# 1824                                                Nepal Developing Category B
# 1825                                                Nepal Developing Category A
# 1826                                                Nepal Developing Category C
# 1827                                                Nepal Developing Category A
# 1828                                                Nepal Developing Category B
# 1829                                                Nepal Developing Category B
# 1830                                          Netherlands Developing Category A
# 1831                                          Netherlands Developing Category C
# 1832                                          Netherlands Developing Category C
# 1833                                          Netherlands Developing Category C
# 1834                                          Netherlands Developing Category B
# 1835                                          Netherlands Developing Category C
# 1836                                          Netherlands Developing Category B
# 1837                                          Netherlands Developing Category C
# 1838                                          Netherlands Developing Category C
# 1839                                          Netherlands Developing Category A
# 1840                                          Netherlands Developing Category A
# 1841                                          Netherlands Developing Category B
# 1842                                          Netherlands Developing Category A
# 1843                                          Netherlands Developing Category B
# 1844                                          Netherlands Developing Category B
# 1845                                          Netherlands Developing Category A
# 1846                                          New Zealand Developing Category C
# 1847                                          New Zealand Developing Category C
# 1848                                          New Zealand Developing Category C
# 1849                                          New Zealand Developing Category A
# 1850                                          New Zealand Developing Category C
# 1851                                          New Zealand Developing Category A
# 1852                                          New Zealand Developing Category B
# 1853                                          New Zealand Developing Category C
# 1854                                          New Zealand Developing Category A
# 1855                                          New Zealand Developing Category C
# 1856                                          New Zealand Developing Category A
# 1857                                          New Zealand Developing Category B
# 1858                                          New Zealand Developing Category B
# 1859                                          New Zealand Developing Category C
# 1860                                          New Zealand Developing Category B
# 1861                                          New Zealand Developing Category A
# 1862                                            Nicaragua Developing Category A
# 1863                                            Nicaragua Developing Category B
# 1864                                            Nicaragua Developing Category C
# 1865                                            Nicaragua Developing Category C
# 1866                                            Nicaragua Developing Category C
# 1867                                            Nicaragua Developing Category A
# 1868                                            Nicaragua Developing Category C
# 1869                                            Nicaragua Developing Category B
# 1870                                            Nicaragua Developing Category C
# 1871                                            Nicaragua Developing Category B
# 1872                                            Nicaragua Developing Category A
# 1873                                            Nicaragua Developing Category C
# 1874                                            Nicaragua Developing Category B
# 1875                                            Nicaragua Developing Category B
# 1876                                            Nicaragua Developing Category B
# 1877                                            Nicaragua Developing Category A
# 1878                                                Niger Developing Category C
# 1879                                                Niger Developing Category B
# 1880                                                Niger Developing Category B
# 1881                                                Niger Developing Category A
# 1882                                                Niger Developing Category B
# 1883                                                Niger Developing Category B
# 1884                                                Niger Developing Category A
# 1885                                                Niger Developing Category A
# 1886                                                Niger Developing Category B
# 1887                                                Niger Developing Category C
# 1888                                                Niger Developing Category C
# 1889                                                Niger Developing Category A
# 1890                                                Niger Developing Category C
# 1891                                                Niger Developing Category A
# 1892                                                Niger Developing Category B
# 1893                                                Niger Developing Category A
# 1894                                              Nigeria Developing Category B
# 1895                                              Nigeria Developing Category C
# 1896                                              Nigeria Developing Category C
# 1897                                              Nigeria Developing Category C
# 1898                                              Nigeria Developing Category A
# 1899                                              Nigeria Developing Category B
# 1900                                              Nigeria Developing Category B
# 1901                                              Nigeria Developing Category B
# 1902                                              Nigeria Developing Category C
# 1903                                              Nigeria Developing Category C
# 1904                                              Nigeria Developing Category A
# 1905                                              Nigeria Developing Category C
# 1906                                              Nigeria Developing Category B
# 1907                                              Nigeria Developing Category B
# 1908                                              Nigeria Developing Category A
# 1909                                              Nigeria Developing Category C
# 1910                                                 Niue Developing Category B
# 1911                                               Norway Developing Category A
# 1912                                               Norway Developing Category C
# 1913                                               Norway Developing Category C
# 1914                                               Norway Developing Category C
# 1915                                               Norway Developing Category A
# 1916                                               Norway Developing Category C
# 1917                                               Norway Developing Category A
# 1918                                               Norway Developing Category B
# 1919                                               Norway Developing Category C
# 1920                                               Norway Developing Category A
# 1921                                               Norway Developing Category C
# 1922                                               Norway Developing Category A
# 1923                                               Norway Developing Category B
# 1924                                               Norway Developing Category C
# 1925                                               Norway Developing Category A
# 1926                                               Norway Developing Category A
# 1927                                                 Oman Developing Category B
# 1928                                                 Oman Developing Category C
# 1929                                                 Oman Developing Category C
# 1930                                                 Oman Developing Category A
# 1931                                                 Oman Developing Category A
# 1932                                                 Oman Developing Category B
# 1933                                                 Oman Developing Category B
# 1934                                                 Oman Developing Category C
# 1935                                                 Oman Developing Category C
# 1936                                                 Oman Developing Category B
# 1937                                                 Oman Developing Category C
# 1938                                                 Oman Developing Category C
# 1939                                                 Oman Developing Category C
# 1940                                                 Oman Developing Category C
# 1941                                                 Oman Developing Category A
# 1942                                                 Oman Developing Category A
# 1943                                             Pakistan Developing Category A
# 1944                                             Pakistan Developing Category C
# 1945                                             Pakistan Developing Category A
# 1946                                             Pakistan Developing Category B
# 1947                                             Pakistan Developing Category A
# 1948                                             Pakistan Developing Category C
# 1949                                             Pakistan Developing Category C
# 1950                                             Pakistan Developing Category C
# 1951                                             Pakistan Developing Category B
# 1952                                             Pakistan Developing Category A
# 1953                                             Pakistan Developing Category C
# 1954                                             Pakistan Developing Category B
# 1955                                             Pakistan Developing Category A
# 1956                                             Pakistan Developing Category C
# 1957                                             Pakistan Developing Category B
# 1958                                             Pakistan Developing Category A
# 1959                                                Palau Developing Category A
# 1960                                               Panama Developing Category C
# 1961                                               Panama Developing Category A
# 1962                                               Panama Developing Category B
# 1963                                               Panama Developing Category B
# 1964                                               Panama Developing Category C
# 1965                                               Panama Developing Category C
# 1966                                               Panama Developing Category C
# 1967                                               Panama Developing Category C
# 1968                                               Panama Developing Category C
# 1969                                               Panama Developing Category B
# 1970                                               Panama Developing Category A
# 1971                                               Panama Developing Category C
# 1972                                               Panama Developing Category C
# 1973                                               Panama Developing Category A
# 1974                                               Panama Developing Category A
# 1975                                               Panama Developing Category A
# 1976                                     Papua New Guinea Developing Category B
# 1977                                     Papua New Guinea Developing Category C
# 1978                                     Papua New Guinea Developing Category B
# 1979                                     Papua New Guinea Developing Category A
# 1980                                     Papua New Guinea Developing Category C
# 1981                                     Papua New Guinea Developing Category B
# 1982                                     Papua New Guinea Developing Category A
# 1983                                     Papua New Guinea Developing Category B
# 1984                                     Papua New Guinea Developing Category A
# 1985                                     Papua New Guinea Developing Category A
# 1986                                     Papua New Guinea Developing Category A
# 1987                                     Papua New Guinea Developing Category B
# 1988                                     Papua New Guinea Developing Category B
# 1989                                     Papua New Guinea Developing Category C
# 1990                                     Papua New Guinea Developing Category B
# 1991                                     Papua New Guinea Developing Category A
# 1992                                             Paraguay Developing Category A
# 1993                                             Paraguay Developing Category A
# 1994                                             Paraguay Developing Category C
# 1995                                             Paraguay Developing Category A
# 1996                                             Paraguay Developing Category C
# 1997                                             Paraguay Developing Category A
# 1998                                             Paraguay Developing Category B
# 1999                                             Paraguay Developing Category B
# 2000                                             Paraguay Developing Category B
# 2001                                             Paraguay Developing Category B
# 2002                                             Paraguay Developing Category A
# 2003                                             Paraguay Developing Category A
# 2004                                             Paraguay Developing Category B
# 2005                                             Paraguay Developing Category C
# 2006                                             Paraguay Developing Category B
# 2007                                             Paraguay Developing Category A
# 2008                                                 Peru Developing Category B
# 2009                                                 Peru Developing Category A
# 2010                                                 Peru Developing Category A
# 2011                                                 Peru Developing Category A
# 2012                                                 Peru Developing Category B
# 2013                                                 Peru Developing Category B
# 2014                                                 Peru Developing Category C
# 2015                                                 Peru Developing Category B
# 2016                                                 Peru Developing Category A
# 2017                                                 Peru Developing Category B
# 2018                                                 Peru Developing Category C
# 2019                                                 Peru Developing Category B
# 2020                                                 Peru Developing Category C
# 2021                                                 Peru Developing Category C
# 2022                                                 Peru Developing Category C
# 2023                                                 Peru Developing Category B
# 2024                                          Philippines Developing Category C
# 2025                                          Philippines Developing Category A
# 2026                                          Philippines Developing Category C
# 2027                                          Philippines Developing Category B
# 2028                                          Philippines Developing Category A
# 2029                                          Philippines Developing Category B
# 2030                                          Philippines Developing Category B
# 2031                                          Philippines Developing Category C
# 2032                                          Philippines Developing Category B
# 2033                                          Philippines Developing Category A
# 2034                                          Philippines Developing Category B
# 2035                                          Philippines Developing Category A
# 2036                                          Philippines Developing Category C
# 2037                                          Philippines Developing Category A
# 2038                                          Philippines Developing Category C
# 2039                                          Philippines Developing Category B
# 2040                                               Poland Developing Category C
# 2041                                               Poland Developing Category B
# 2042                                               Poland Developing Category B
# 2043                                               Poland Developing Category C
# 2044                                               Poland Developing Category A
# 2045                                               Poland Developing Category C
# 2046                                               Poland Developing Category B
# 2047                                               Poland Developing Category A
# 2048                                               Poland Developing Category C
# 2049                                               Poland Developing Category B
# 2050                                               Poland Developing Category C
# 2051                                               Poland Developing Category B
# 2052                                               Poland Developing Category C
# 2053                                               Poland Developing Category C
# 2054                                               Poland Developing Category A
# 2055                                               Poland Developing Category B
# 2056                                             Portugal Developing Category B
# 2057                                             Portugal Developing Category A
# 2058                                             Portugal Developing Category C
# 2059                                             Portugal Developing Category A
# 2060                                             Portugal Developing Category A
# 2061                                             Portugal Developing Category B
# 2062                                             Portugal Developing Category C
# 2063                                             Portugal Developing Category C
# 2064                                             Portugal Developing Category B
# 2065                                             Portugal Developing Category A
# 2066                                             Portugal Developing Category A
# 2067                                             Portugal Developing Category C
# 2068                                             Portugal Developing Category B
# 2069                                             Portugal Developing Category C
# 2070                                             Portugal Developing Category C
# 2071                                             Portugal Developing Category B
# 2072                                                Qatar Developing Category C
# 2073                                                Qatar Developing Category C
# 2074                                                Qatar Developing Category B
# 2075                                                Qatar Developing Category C
# 2076                                                Qatar Developing Category B
# 2077                                                Qatar Developing Category A
# 2078                                                Qatar Developing Category B
# 2079                                                Qatar Developing Category B
# 2080                                                Qatar Developing Category B
# 2081                                                Qatar Developing Category A
# 2082                                                Qatar Developing Category C
# 2083                                                Qatar Developing Category A
# 2084                                                Qatar Developing Category B
# 2085                                                Qatar Developing Category A
# 2086                                                Qatar Developing Category A
# 2087                                                Qatar Developing Category C
# 2088                                    Republic of Korea Developing Category C
# 2089                                    Republic of Korea Developing Category A
# 2090                                    Republic of Korea Developing Category C
# 2091                                    Republic of Korea Developing Category C
# 2092                                    Republic of Korea Developing Category B
# 2093                                    Republic of Korea Developing Category C
# 2094                                    Republic of Korea Developing Category A
# 2095                                    Republic of Korea Developing Category A
# 2096                                    Republic of Korea Developing Category B
# 2097                                    Republic of Korea Developing Category B
# 2098                                    Republic of Korea Developing Category B
# 2099                                    Republic of Korea Developing Category A
# 2100                                    Republic of Korea Developing Category A
# 2101                                    Republic of Korea Developing Category A
# 2102                                    Republic of Korea Developing Category C
# 2103                                    Republic of Korea Developing Category B
# 2104                                  Republic of Moldova Developing Category A
# 2105                                  Republic of Moldova Developing Category A
# 2106                                  Republic of Moldova Developing Category C
# 2107                                  Republic of Moldova Developing Category A
# 2108                                  Republic of Moldova Developing Category A
# 2109                                  Republic of Moldova Developing Category C
# 2110                                  Republic of Moldova Developing Category B
# 2111                                  Republic of Moldova Developing Category B
# 2112                                  Republic of Moldova Developing Category C
# 2113                                  Republic of Moldova Developing Category C
# 2114                                  Republic of Moldova Developing Category C
# 2115                                  Republic of Moldova Developing Category A
# 2116                                  Republic of Moldova Developing Category A
# 2117                                  Republic of Moldova Developing Category B
# 2118                                  Republic of Moldova Developing Category C
# 2119                                  Republic of Moldova Developing Category A
# 2120                                              Romania Developing Category C
# 2121                                              Romania Developing Category B
# 2122                                              Romania Developing Category A
# 2123                                              Romania Developing Category A
# 2124                                              Romania Developing Category B
# 2125                                              Romania Developing Category B
# 2126                                              Romania Developing Category C
# 2127                                              Romania Developing Category A
# 2128                                              Romania Developing Category A
# 2129                                              Romania Developing Category A
# 2130                                              Romania Developing Category A
# 2131                                              Romania Developing Category B
# 2132                                              Romania Developing Category A
# 2133                                              Romania Developing Category C
# 2134                                              Romania Developing Category C
# 2135                                              Romania Developing Category B
# 2136                                   Russian Federation Developing Category C
# 2137                                   Russian Federation Developing Category C
# 2138                                   Russian Federation Developing Category A
# 2139                                   Russian Federation Developing Category A
# 2140                                   Russian Federation Developing Category B
# 2141                                   Russian Federation Developing Category A
# 2142                                   Russian Federation Developing Category C
# 2143                                   Russian Federation Developing Category C
# 2144                                   Russian Federation Developing Category C
# 2145                                   Russian Federation Developing Category A
# 2146                                   Russian Federation Developing Category C
# 2147                                   Russian Federation Developing Category B
# 2148                                   Russian Federation Developing Category C
# 2149                                   Russian Federation Developing Category C
# 2150                                   Russian Federation Developing Category B
# 2151                                   Russian Federation Developing Category B
# 2152                                               Rwanda Developing Category B
# 2153                                               Rwanda Developing Category C
# 2154                                               Rwanda Developing Category C
# 2155                                               Rwanda Developing Category C
# 2156                                               Rwanda Developing Category A
# 2157                                               Rwanda Developing Category B
# 2158                                               Rwanda Developing Category A
# 2159                                               Rwanda Developing Category C
# 2160                                               Rwanda Developing Category A
# 2161                                               Rwanda Developing Category A
# 2162                                               Rwanda Developing Category C
# 2163                                               Rwanda Developing Category A
# 2164                                               Rwanda Developing Category B
# 2165                                               Rwanda Developing Category B
# 2166                                               Rwanda Developing Category C
# 2167                                               Rwanda Developing Category B
# 2168                                Saint Kitts and Nevis Developing Category B
# 2169                                          Saint Lucia Developing Category B
# 2170                                          Saint Lucia Developing Category C
# 2171                                          Saint Lucia Developing Category C
# 2172                                          Saint Lucia Developing Category A
# 2173                                          Saint Lucia Developing Category C
# 2174                                          Saint Lucia Developing Category C
# 2175                                          Saint Lucia Developing Category C
# 2176                                          Saint Lucia Developing Category B
# 2177                                          Saint Lucia Developing Category C
# 2178                                          Saint Lucia Developing Category A
# 2179                                          Saint Lucia Developing Category C
# 2180                                          Saint Lucia Developing Category B
# 2181                                          Saint Lucia Developing Category C
# 2182                                          Saint Lucia Developing Category C
# 2183                                          Saint Lucia Developing Category C
# 2184                                          Saint Lucia Developing Category A
# 2185                     Saint Vincent and the Grenadines Developing Category C
# 2186                     Saint Vincent and the Grenadines Developing Category B
# 2187                     Saint Vincent and the Grenadines Developing Category C
# 2188                     Saint Vincent and the Grenadines Developing Category C
# 2189                     Saint Vincent and the Grenadines Developing Category A
# 2190                     Saint Vincent and the Grenadines Developing Category C
# 2191                     Saint Vincent and the Grenadines Developing Category B
# 2192                     Saint Vincent and the Grenadines Developing Category C
# 2193                     Saint Vincent and the Grenadines Developing Category B
# 2194                     Saint Vincent and the Grenadines Developing Category B
# 2195                     Saint Vincent and the Grenadines Developing Category A
# 2196                     Saint Vincent and the Grenadines Developing Category C
# 2197                     Saint Vincent and the Grenadines Developing Category B
# 2198                     Saint Vincent and the Grenadines Developing Category A
# 2199                     Saint Vincent and the Grenadines Developing Category A
# 2200                     Saint Vincent and the Grenadines Developing Category B
# 2201                                                Samoa Developing Category C
# 2202                                                Samoa Developing Category A
# 2203                                                Samoa Developing Category A
# 2204                                                Samoa Developing Category C
# 2205                                                Samoa Developing Category C
# 2206                                                Samoa Developing Category B
# 2207                                                Samoa Developing Category C
# 2208                                                Samoa Developing Category C
# 2209                                                Samoa Developing Category C
# 2210                                                Samoa Developing Category C
# 2211                                                Samoa Developing Category C
# 2212                                                Samoa Developing Category B
# 2213                                                Samoa Developing Category B
# 2214                                                Samoa Developing Category A
# 2215                                                Samoa Developing Category A
# 2216                                                Samoa Developing Category B
# 2217                                           San Marino Developing Category B
# 2218                                Sao Tome and Principe Developing Category A
# 2219                                Sao Tome and Principe Developing Category C
# 2220                                Sao Tome and Principe Developing Category A
# 2221                                Sao Tome and Principe Developing Category A
# 2222                                Sao Tome and Principe Developing Category A
# 2223                                Sao Tome and Principe Developing Category C
# 2224                                Sao Tome and Principe Developing Category C
# 2225                                Sao Tome and Principe Developing Category C
# 2226                                Sao Tome and Principe Developing Category C
# 2227                                Sao Tome and Principe Developing Category A
# 2228                                Sao Tome and Principe Developing Category C
# 2229                                Sao Tome and Principe Developing Category C
# 2230                                Sao Tome and Principe Developing Category A
# 2231                                Sao Tome and Principe Developing Category C
# 2232                                Sao Tome and Principe Developing Category C
# 2233                                Sao Tome and Principe Developing Category B
# 2234                                         Saudi Arabia Developing Category C
# 2235                                         Saudi Arabia Developing Category B
# 2236                                         Saudi Arabia Developing Category C
# 2237                                         Saudi Arabia Developing Category B
# 2238                                         Saudi Arabia Developing Category C
# 2239                                         Saudi Arabia Developing Category B
# 2240                                         Saudi Arabia Developing Category B
# 2241                                         Saudi Arabia Developing Category A
# 2242                                         Saudi Arabia Developing Category C
# 2243                                         Saudi Arabia Developing Category B
# 2244                                         Saudi Arabia Developing Category B
# 2245                                         Saudi Arabia Developing Category C
# 2246                                         Saudi Arabia Developing Category A
# 2247                                         Saudi Arabia Developing Category A
# 2248                                         Saudi Arabia Developing Category B
# 2249                                         Saudi Arabia Developing Category A
# 2250                                              Senegal Developing Category A
# 2251                                              Senegal Developing Category B
# 2252                                              Senegal Developing Category C
# 2253                                              Senegal Developing Category C
# 2254                                              Senegal Developing Category B
# 2255                                              Senegal Developing Category B
# 2256                                              Senegal Developing Category B
# 2257                                              Senegal Developing Category A
# 2258                                              Senegal Developing Category B
# 2259                                              Senegal Developing Category C
# 2260                                              Senegal Developing Category A
# 2261                                              Senegal Developing Category A
# 2262                                              Senegal Developing Category A
# 2263                                              Senegal Developing Category A
# 2264                                              Senegal Developing Category B
# 2265                                              Senegal Developing Category B
# 2266                                               Serbia Developing Category C
# 2267                                               Serbia Developing Category A
# 2268                                               Serbia Developing Category B
# 2269                                               Serbia Developing Category C
# 2270                                               Serbia Developing Category A
# 2271                                               Serbia Developing Category C
# 2272                                               Serbia Developing Category C
# 2273                                               Serbia Developing Category C
# 2274                                               Serbia Developing Category C
# 2275                                               Serbia Developing Category A
# 2276                                               Serbia Developing Category C
# 2277                                               Serbia Developing Category C
# 2278                                               Serbia Developing Category C
# 2279                                               Serbia Developing Category A
# 2280                                               Serbia Developing Category B
# 2281                                               Serbia Developing Category B
# 2282                                           Seychelles Developing Category A
# 2283                                           Seychelles Developing Category B
# 2284                                           Seychelles Developing Category A
# 2285                                           Seychelles Developing Category A
# 2286                                           Seychelles Developing Category B
# 2287                                           Seychelles Developing Category A
# 2288                                           Seychelles Developing Category B
# 2289                                           Seychelles Developing Category C
# 2290                                           Seychelles Developing Category C
# 2291                                           Seychelles Developing Category B
# 2292                                           Seychelles Developing Category A
# 2293                                           Seychelles Developing Category C
# 2294                                           Seychelles Developing Category C
# 2295                                           Seychelles Developing Category B
# 2296                                           Seychelles Developing Category C
# 2297                                           Seychelles Developing Category C
# 2298                                         Sierra Leone Developing Category B
# 2299                                         Sierra Leone Developing Category C
# 2300                                         Sierra Leone Developing Category C
# 2301                                         Sierra Leone Developing Category B
# 2302                                         Sierra Leone Developing Category C
# 2303                                         Sierra Leone Developing Category B
# 2304                                         Sierra Leone Developing Category C
# 2305                                         Sierra Leone Developing Category A
# 2306                                         Sierra Leone Developing Category B
# 2307                                         Sierra Leone Developing Category B
# 2308                                         Sierra Leone Developing Category B
# 2309                                         Sierra Leone Developing Category C
# 2310                                         Sierra Leone Developing Category C
# 2311                                         Sierra Leone Developing Category C
# 2312                                         Sierra Leone Developing Category C
# 2313                                         Sierra Leone Developing Category C
# 2314                                            Singapore Developing Category B
# 2315                                            Singapore Developing Category C
# 2316                                            Singapore Developing Category A
# 2317                                            Singapore Developing Category C
# 2318                                            Singapore Developing Category C
# 2319                                            Singapore Developing Category C
# 2320                                            Singapore Developing Category C
# 2321                                            Singapore Developing Category B
# 2322                                            Singapore Developing Category C
# 2323                                            Singapore Developing Category B
# 2324                                            Singapore Developing Category C
# 2325                                            Singapore Developing Category B
# 2326                                            Singapore Developing Category A
# 2327                                            Singapore Developing Category C
# 2328                                            Singapore Developing Category B
# 2329                                            Singapore Developing Category B
# 2330                                             Slovakia Developing Category C
# 2331                                             Slovakia Developing Category B
# 2332                                             Slovakia Developing Category C
# 2333                                             Slovakia Developing Category B
# 2334                                             Slovakia Developing Category A
# 2335                                             Slovakia Developing Category C
# 2336                                             Slovakia Developing Category A
# 2337                                             Slovakia Developing Category A
# 2338                                             Slovakia Developing Category A
# 2339                                             Slovakia Developing Category B
# 2340                                             Slovakia Developing Category C
# 2341                                             Slovakia Developing Category C
# 2342                                             Slovakia Developing Category C
# 2343                                             Slovakia Developing Category C
# 2344                                             Slovakia Developing Category B
# 2345                                             Slovakia Developing Category A
# 2346                                             Slovenia Developing Category A
# 2347                                             Slovenia Developing Category C
# 2348                                             Slovenia Developing Category C
# 2349                                             Slovenia Developing Category C
# 2350                                             Slovenia Developing Category C
# 2351                                             Slovenia Developing Category C
# 2352                                             Slovenia Developing Category C
# 2353                                             Slovenia Developing Category A
# 2354                                             Slovenia Developing Category A
# 2355                                             Slovenia Developing Category A
# 2356                                             Slovenia Developing Category B
# 2357                                             Slovenia Developing Category C
# 2358                                             Slovenia Developing Category A
# 2359                                             Slovenia Developing Category B
# 2360                                             Slovenia Developing Category C
# 2361                                             Slovenia Developing Category C
# 2362                                      Solomon Islands Developing Category C
# 2363                                      Solomon Islands Developing Category C
# 2364                                      Solomon Islands Developing Category A
# 2365                                      Solomon Islands Developing Category A
# 2366                                      Solomon Islands Developing Category A
# 2367                                      Solomon Islands Developing Category A
# 2368                                      Solomon Islands Developing Category C
# 2369                                      Solomon Islands Developing Category A
# 2370                                      Solomon Islands Developing Category A
# 2371                                      Solomon Islands Developing Category C
# 2372                                      Solomon Islands Developing Category B
# 2373                                      Solomon Islands Developing Category C
# 2374                                      Solomon Islands Developing Category B
# 2375                                      Solomon Islands Developing Category B
# 2376                                      Solomon Islands Developing Category B
# 2377                                      Solomon Islands Developing Category A
# 2378                                              Somalia Developing Category B
# 2379                                              Somalia Developing Category C
# 2380                                              Somalia Developing Category C
# 2381                                              Somalia Developing Category A
# 2382                                              Somalia Developing Category B
# 2383                                              Somalia Developing Category C
# 2384                                              Somalia Developing Category B
# 2385                                              Somalia Developing Category C
# 2386                                              Somalia Developing Category B
# 2387                                              Somalia Developing Category A
# 2388                                              Somalia Developing Category C
# 2389                                              Somalia Developing Category A
# 2390                                              Somalia Developing Category C
# 2391                                              Somalia Developing Category B
# 2392                                              Somalia Developing Category A
# 2393                                              Somalia Developing Category B
# 2394                                         South Africa Developing Category A
# 2395                                         South Africa Developing Category B
# 2396                                         South Africa Developing Category C
# 2397                                         South Africa Developing Category A
# 2398                                         South Africa Developing Category A
# 2399                                         South Africa Developing Category A
# 2400                                         South Africa Developing Category A
# 2401                                         South Africa Developing Category C
# 2402                                         South Africa Developing Category A
# 2403                                         South Africa Developing Category B
# 2404                                         South Africa Developing Category A
# 2405                                         South Africa Developing Category A
# 2406                                         South Africa Developing Category A
# 2407                                         South Africa Developing Category A
# 2408                                         South Africa Developing Category A
# 2409                                         South Africa Developing Category B
# 2410                                          South Sudan Developing Category B
# 2411                                          South Sudan Developing Category C
# 2412                                          South Sudan Developing Category A
# 2413                                          South Sudan Developing Category A
# 2414                                          South Sudan Developing Category B
# 2415                                          South Sudan Developing Category A
# 2416                                          South Sudan Developing Category C
# 2417                                          South Sudan Developing Category B
# 2418                                          South Sudan Developing Category C
# 2419                                          South Sudan Developing Category C
# 2420                                          South Sudan Developing Category A
# 2421                                          South Sudan Developing Category B
# 2422                                          South Sudan Developing Category B
# 2423                                          South Sudan Developing Category A
# 2424                                          South Sudan Developing Category B
# 2425                                          South Sudan Developing Category A
# 2426                                                Spain Developing Category A
# 2427                                                Spain Developing Category B
# 2428                                                Spain Developing Category C
# 2429                                                Spain Developing Category A
# 2430                                                Spain Developing Category C
# 2431                                                Spain Developing Category A
# 2432                                                Spain Developing Category C
# 2433                                                Spain Developing Category B
# 2434                                                Spain Developing Category C
# 2435                                                Spain Developing Category B
# 2436                                                Spain Developing Category A
# 2437                                                Spain Developing Category C
# 2438                                                Spain Developing Category C
# 2439                                                Spain Developing Category C
# 2440                                                Spain Developing Category A
# 2441                                                Spain Developing Category B
# 2442                                            Sri Lanka Developing Category C
# 2443                                            Sri Lanka Developing Category B
# 2444                                            Sri Lanka Developing Category A
# 2445                                            Sri Lanka Developing Category C
# 2446                                            Sri Lanka Developing Category A
# 2447                                            Sri Lanka Developing Category B
# 2448                                            Sri Lanka Developing Category C
# 2449                                            Sri Lanka Developing Category A
# 2450                                            Sri Lanka Developing Category A
# 2451                                            Sri Lanka Developing Category C
# 2452                                            Sri Lanka Developing Category B
# 2453                                            Sri Lanka Developing Category C
# 2454                                            Sri Lanka Developing Category A
# 2455                                            Sri Lanka Developing Category C
# 2456                                            Sri Lanka Developing Category B
# 2457                                            Sri Lanka Developing Category C
# 2458                                                Sudan Developing Category B
# 2459                                                Sudan Developing Category B
# 2460                                                Sudan Developing Category B
# 2461                                                Sudan Developing Category C
# 2462                                                Sudan Developing Category A
# 2463                                                Sudan Developing Category A
# 2464                                                Sudan Developing Category C
# 2465                                                Sudan Developing Category C
# 2466                                                Sudan Developing Category A
# 2467                                                Sudan Developing Category A
# 2468                                                Sudan Developing Category C
# 2469                                                Sudan Developing Category A
# 2470                                                Sudan Developing Category B
# 2471                                                Sudan Developing Category C
# 2472                                                Sudan Developing Category C
# 2473                                                Sudan Developing Category C
# 2474                                             Suriname Developing Category C
# 2475                                             Suriname Developing Category C
# 2476                                             Suriname Developing Category A
# 2477                                             Suriname Developing Category A
# 2478                                             Suriname Developing Category A
# 2479                                             Suriname Developing Category B
# 2480                                             Suriname Developing Category A
# 2481                                             Suriname Developing Category A
# 2482                                             Suriname Developing Category A
# 2483                                             Suriname Developing Category C
# 2484                                             Suriname Developing Category C
# 2485                                             Suriname Developing Category A
# 2486                                             Suriname Developing Category A
# 2487                                             Suriname Developing Category A
# 2488                                             Suriname Developing Category C
# 2489                                             Suriname Developing Category C
# 2490                                            Swaziland Developing Category A
# 2491                                            Swaziland Developing Category A
# 2492                                            Swaziland Developing Category C
# 2493                                            Swaziland Developing Category A
# 2494                                            Swaziland Developing Category A
# 2495                                            Swaziland Developing Category A
# 2496                                            Swaziland Developing Category B
# 2497                                            Swaziland Developing Category B
# 2498                                            Swaziland Developing Category B
# 2499                                            Swaziland Developing Category C
# 2500                                            Swaziland Developing Category A
# 2501                                            Swaziland Developing Category B
# 2502                                            Swaziland Developing Category C
# 2503                                            Swaziland Developing Category A
# 2504                                            Swaziland Developing Category A
# 2505                                            Swaziland Developing Category C
# 2506                                               Sweden Developing Category C
# 2507                                               Sweden Developing Category B
# 2508                                               Sweden Developing Category B
# 2509                                               Sweden Developing Category C
# 2510                                               Sweden Developing Category A
# 2511                                               Sweden Developing Category B
# 2512                                               Sweden Developing Category A
# 2513                                               Sweden Developing Category A
# 2514                                               Sweden Developing Category C
# 2515                                               Sweden Developing Category A
# 2516                                               Sweden Developing Category A
# 2517                                               Sweden Developing Category C
# 2518                                               Sweden Developing Category A
# 2519                                               Sweden Developing Category C
# 2520                                               Sweden Developing Category B
# 2521                                               Sweden Developing Category C
# 2522                                          Switzerland Developing Category C
# 2523                                          Switzerland Developing Category C
# 2524                                          Switzerland Developing Category C
# 2525                                          Switzerland Developing Category A
# 2526                                          Switzerland Developing Category B
# 2527                                          Switzerland Developing Category C
# 2528                                          Switzerland Developing Category B
# 2529                                          Switzerland Developing Category C
# 2530                                          Switzerland Developing Category C
# 2531                                          Switzerland Developing Category A
# 2532                                          Switzerland Developing Category A
# 2533                                          Switzerland Developing Category B
# 2534                                          Switzerland Developing Category B
# 2535                                          Switzerland Developing Category B
# 2536                                          Switzerland Developing Category B
# 2537                                          Switzerland Developing Category C
# 2538                                 Syrian Arab Republic Developing Category A
# 2539                                 Syrian Arab Republic Developing Category B
# 2540                                 Syrian Arab Republic Developing Category A
# 2541                                 Syrian Arab Republic Developing Category A
# 2542                                 Syrian Arab Republic Developing Category C
# 2543                                 Syrian Arab Republic Developing Category C
# 2544                                 Syrian Arab Republic Developing Category C
# 2545                                 Syrian Arab Republic Developing Category C
# 2546                                 Syrian Arab Republic Developing Category A
# 2547                                 Syrian Arab Republic Developing Category B
# 2548                                 Syrian Arab Republic Developing Category C
# 2549                                 Syrian Arab Republic Developing Category C
# 2550                                 Syrian Arab Republic Developing Category A
# 2551                                 Syrian Arab Republic Developing Category B
# 2552                                 Syrian Arab Republic Developing Category A
# 2553                                 Syrian Arab Republic Developing Category A
# 2554                                           Tajikistan Developing Category C
# 2555                                           Tajikistan Developing Category A
# 2556                                           Tajikistan Developing Category C
# 2557                                           Tajikistan Developing Category C
# 2558                                           Tajikistan Developing Category B
# 2559                                           Tajikistan Developing Category C
# 2560                                           Tajikistan Developing Category A
# 2561                                           Tajikistan Developing Category A
# 2562                                           Tajikistan Developing Category B
# 2563                                           Tajikistan Developing Category C
# 2564                                           Tajikistan Developing Category C
# 2565                                           Tajikistan Developing Category B
# 2566                                           Tajikistan Developing Category C
# 2567                                           Tajikistan Developing Category C
# 2568                                           Tajikistan Developing Category B
# 2569                                           Tajikistan Developing Category A
# 2570                                             Thailand Developing Category C
# 2571                                             Thailand Developing Category B
# 2572                                             Thailand Developing Category B
# 2573                                             Thailand Developing Category B
# 2574                                             Thailand Developing Category C
# 2575                                             Thailand Developing Category A
# 2576                                             Thailand Developing Category A
# 2577                                             Thailand Developing Category C
# 2578                                             Thailand Developing Category B
# 2579                                             Thailand Developing Category B
# 2580                                             Thailand Developing Category B
# 2581                                             Thailand Developing Category B
# 2582                                             Thailand Developing Category A
# 2583                                             Thailand Developing Category B
# 2584                                             Thailand Developing Category A
# 2585                                             Thailand Developing Category B
# 2586            The former Yugoslav republic of Macedonia Developing Category B
# 2587            The former Yugoslav republic of Macedonia Developing Category C
# 2588            The former Yugoslav republic of Macedonia Developing Category A
# 2589            The former Yugoslav republic of Macedonia Developing Category C
# 2590            The former Yugoslav republic of Macedonia Developing Category C
# 2591            The former Yugoslav republic of Macedonia Developing Category C
# 2592            The former Yugoslav republic of Macedonia Developing Category B
# 2593            The former Yugoslav republic of Macedonia Developing Category C
# 2594            The former Yugoslav republic of Macedonia Developing Category A
# 2595            The former Yugoslav republic of Macedonia Developing Category A
# 2596            The former Yugoslav republic of Macedonia Developing Category A
# 2597            The former Yugoslav republic of Macedonia Developing Category C
# 2598            The former Yugoslav republic of Macedonia Developing Category B
# 2599            The former Yugoslav republic of Macedonia Developing Category C
# 2600            The former Yugoslav republic of Macedonia Developing Category A
# 2601            The former Yugoslav republic of Macedonia Developing Category C
# 2602                                          Timor-Leste Developing Category B
# 2603                                          Timor-Leste Developing Category B
# 2604                                          Timor-Leste Developing Category A
# 2605                                          Timor-Leste Developing Category A
# 2606                                          Timor-Leste Developing Category C
# 2607                                          Timor-Leste Developing Category C
# 2608                                          Timor-Leste Developing Category C
# 2609                                          Timor-Leste Developing Category B
# 2610                                          Timor-Leste Developing Category A
# 2611                                          Timor-Leste Developing Category B
# 2612                                          Timor-Leste Developing Category B
# 2613                                          Timor-Leste Developing Category B
# 2614                                          Timor-Leste Developing Category B
# 2615                                          Timor-Leste Developing Category A
# 2616                                          Timor-Leste Developing Category A
# 2617                                          Timor-Leste Developing Category B
# 2618                                                 Togo Developing Category B
# 2619                                                 Togo Developing Category C
# 2620                                                 Togo Developing Category B
# 2621                                                 Togo Developing Category A
# 2622                                                 Togo Developing Category A
# 2623                                                 Togo Developing Category B
# 2624                                                 Togo Developing Category C
# 2625                                                 Togo Developing Category A
# 2626                                                 Togo Developing Category C
# 2627                                                 Togo Developing Category A
# 2628                                                 Togo Developing Category A
# 2629                                                 Togo Developing Category A
# 2630                                                 Togo Developing Category A
# 2631                                                 Togo Developing Category A
# 2632                                                 Togo Developing Category A
# 2633                                                 Togo Developing Category B
# 2634                                                Tonga Developing Category B
# 2635                                                Tonga Developing Category B
# 2636                                                Tonga Developing Category C
# 2637                                                Tonga Developing Category A
# 2638                                                Tonga Developing Category C
# 2639                                                Tonga Developing Category B
# 2640                                                Tonga Developing Category C
# 2641                                                Tonga Developing Category B
# 2642                                                Tonga Developing Category B
# 2643                                                Tonga Developing Category B
# 2644                                                Tonga Developing Category C
# 2645                                                Tonga Developing Category B
# 2646                                                Tonga Developing Category C
# 2647                                                Tonga Developing Category C
# 2648                                                Tonga Developing Category A
# 2649                                                Tonga Developing Category B
# 2650                                  Trinidad and Tobago Developing Category A
# 2651                                  Trinidad and Tobago Developing Category B
# 2652                                  Trinidad and Tobago Developing Category C
# 2653                                  Trinidad and Tobago Developing Category C
# 2654                                  Trinidad and Tobago Developing Category B
# 2655                                  Trinidad and Tobago Developing Category C
# 2656                                  Trinidad and Tobago Developing Category C
# 2657                                  Trinidad and Tobago Developing Category C
# 2658                                  Trinidad and Tobago Developing Category A
# 2659                                  Trinidad and Tobago Developing Category C
# 2660                                  Trinidad and Tobago Developing Category A
# 2661                                  Trinidad and Tobago Developing Category B
# 2662                                  Trinidad and Tobago Developing Category B
# 2663                                  Trinidad and Tobago Developing Category A
# 2664                                  Trinidad and Tobago Developing Category A
# 2665                                  Trinidad and Tobago Developing Category C
# 2666                                              Tunisia Developing Category B
# 2667                                              Tunisia Developing Category A
# 2668                                              Tunisia Developing Category A
# 2669                                              Tunisia Developing Category C
# 2670                                              Tunisia Developing Category A
# 2671                                              Tunisia Developing Category B
# 2672                                              Tunisia Developing Category C
# 2673                                              Tunisia Developing Category B
# 2674                                              Tunisia Developing Category A
# 2675                                              Tunisia Developing Category B
# 2676                                              Tunisia Developing Category B
# 2677                                              Tunisia Developing Category C
# 2678                                              Tunisia Developing Category A
# 2679                                              Tunisia Developing Category B
# 2680                                              Tunisia Developing Category B
# 2681                                              Tunisia Developing Category C
# 2682                                               Turkey Developing Category C
# 2683                                               Turkey Developing Category C
# 2684                                               Turkey Developing Category C
# 2685                                               Turkey Developing Category C
# 2686                                               Turkey Developing Category B
# 2687                                               Turkey Developing Category B
# 2688                                               Turkey Developing Category B
# 2689                                               Turkey Developing Category A
# 2690                                               Turkey Developing Category A
# 2691                                               Turkey Developing Category C
# 2692                                               Turkey Developing Category A
# 2693                                               Turkey Developing Category A
# 2694                                               Turkey Developing Category B
# 2695                                               Turkey Developing Category A
# 2696                                               Turkey Developing Category B
# 2697                                               Turkey Developing Category B
# 2698                                         Turkmenistan Developing Category B
# 2699                                         Turkmenistan Developing Category C
# 2700                                         Turkmenistan Developing Category A
# 2701                                         Turkmenistan Developing Category B
# 2702                                         Turkmenistan Developing Category C
# 2703                                         Turkmenistan Developing Category A
# 2704                                         Turkmenistan Developing Category B
# 2705                                         Turkmenistan Developing Category A
# 2706                                         Turkmenistan Developing Category C
# 2707                                         Turkmenistan Developing Category C
# 2708                                         Turkmenistan Developing Category C
# 2709                                         Turkmenistan Developing Category C
# 2710                                         Turkmenistan Developing Category C
# 2711                                         Turkmenistan Developing Category B
# 2712                                         Turkmenistan Developing Category B
# 2713                                         Turkmenistan Developing Category B
# 2714                                               Tuvalu Developing Category C
# 2715                                               Uganda Developing Category A
# 2716                                               Uganda Developing Category A
# 2717                                               Uganda Developing Category B
# 2718                                               Uganda Developing Category C
# 2719                                               Uganda Developing Category B
# 2720                                               Uganda Developing Category C
# 2721                                               Uganda Developing Category A
# 2722                                               Uganda Developing Category B
# 2723                                               Uganda Developing Category B
# 2724                                               Uganda Developing Category B
# 2725                                               Uganda Developing Category A
# 2726                                               Uganda Developing Category C
# 2727                                               Uganda Developing Category B
# 2728                                               Uganda Developing Category B
# 2729                                               Uganda Developing Category A
# 2730                                               Uganda Developing Category A
# 2731                                              Ukraine Developing Category A
# 2732                                              Ukraine Developing Category A
# 2733                                              Ukraine Developing Category A
# 2734                                              Ukraine Developing Category C
# 2735                                              Ukraine Developing Category A
# 2736                                              Ukraine Developing Category A
# 2737                                              Ukraine Developing Category B
# 2738                                              Ukraine Developing Category C
# 2739                                              Ukraine Developing Category A
# 2740                                              Ukraine Developing Category C
# 2741                                              Ukraine Developing Category A
# 2742                                              Ukraine Developing Category C
# 2743                                              Ukraine Developing Category C
# 2744                                              Ukraine Developing Category C
# 2745                                              Ukraine Developing Category B
# 2746                                              Ukraine Developing Category A
# 2747                                 United Arab Emirates Developing Category A
# 2748                                 United Arab Emirates Developing Category C
# 2749                                 United Arab Emirates Developing Category C
# 2750                                 United Arab Emirates Developing Category B
# 2751                                 United Arab Emirates Developing Category B
# 2752                                 United Arab Emirates Developing Category C
# 2753                                 United Arab Emirates Developing Category B
# 2754                                 United Arab Emirates Developing Category B
# 2755                                 United Arab Emirates Developing Category C
# 2756                                 United Arab Emirates Developing Category C
# 2757                                 United Arab Emirates Developing Category A
# 2758                                 United Arab Emirates Developing Category A
# 2759                                 United Arab Emirates Developing Category B
# 2760                                 United Arab Emirates Developing Category A
# 2761                                 United Arab Emirates Developing Category C
# 2762                                 United Arab Emirates Developing Category C
# 2763 United Kingdom of Great Britain and Northern Ireland Developing Category C
# 2764 United Kingdom of Great Britain and Northern Ireland Developing Category C
# 2765 United Kingdom of Great Britain and Northern Ireland Developing Category C
# 2766 United Kingdom of Great Britain and Northern Ireland Developing Category C
# 2767 United Kingdom of Great Britain and Northern Ireland Developing Category A
# 2768 United Kingdom of Great Britain and Northern Ireland Developing Category B
# 2769 United Kingdom of Great Britain and Northern Ireland Developing Category A
# 2770 United Kingdom of Great Britain and Northern Ireland Developing Category C
# 2771 United Kingdom of Great Britain and Northern Ireland Developing Category C
# 2772 United Kingdom of Great Britain and Northern Ireland Developing Category A
# 2773 United Kingdom of Great Britain and Northern Ireland Developing Category C
# 2774 United Kingdom of Great Britain and Northern Ireland Developing Category B
# 2775 United Kingdom of Great Britain and Northern Ireland Developing Category A
# 2776 United Kingdom of Great Britain and Northern Ireland Developing Category C
# 2777 United Kingdom of Great Britain and Northern Ireland Developing Category C
# 2778 United Kingdom of Great Britain and Northern Ireland Developing Category A
# 2779                          United Republic of Tanzania Developing Category B
# 2780                          United Republic of Tanzania Developing Category B
# 2781                          United Republic of Tanzania Developing Category B
# 2782                          United Republic of Tanzania Developing Category A
# 2783                          United Republic of Tanzania Developing Category B
# 2784                          United Republic of Tanzania Developing Category A
# 2785                          United Republic of Tanzania Developing Category B
# 2786                          United Republic of Tanzania Developing Category C
# 2787                          United Republic of Tanzania Developing Category C
# 2788                          United Republic of Tanzania Developing Category A
# 2789                          United Republic of Tanzania Developing Category C
# 2790                          United Republic of Tanzania Developing Category A
# 2791                          United Republic of Tanzania Developing Category A
# 2792                          United Republic of Tanzania Developing Category A
# 2793                          United Republic of Tanzania Developing Category A
# 2794                          United Republic of Tanzania Developing Category A
# 2795                             United States of America Developing Category B
# 2796                             United States of America Developing Category B
# 2797                             United States of America Developing Category C
# 2798                             United States of America Developing Category C
# 2799                             United States of America Developing Category C
# 2800                             United States of America Developing Category A
# 2801                             United States of America Developing Category C
# 2802                             United States of America Developing Category B
# 2803                             United States of America Developing Category C
# 2804                             United States of America Developing Category C
# 2805                             United States of America Developing Category B
# 2806                             United States of America Developing Category C
# 2807                             United States of America Developing Category A
# 2808                             United States of America Developing Category B
# 2809                             United States of America Developing Category C
# 2810                             United States of America Developing Category A
# 2811                                              Uruguay Developing Category B
# 2812                                              Uruguay Developing Category C
# 2813                                              Uruguay Developing Category A
# 2814                                              Uruguay Developing Category C
# 2815                                              Uruguay Developing Category A
# 2816                                              Uruguay Developing Category C
# 2817                                              Uruguay Developing Category A
# 2818                                              Uruguay Developing Category A
# 2819                                              Uruguay Developing Category C
# 2820                                              Uruguay Developing Category B
# 2821                                              Uruguay Developing Category B
# 2822                                              Uruguay Developing Category B
# 2823                                              Uruguay Developing Category A
# 2824                                              Uruguay Developing Category A
# 2825                                              Uruguay Developing Category A
# 2826                                              Uruguay Developing Category C
# 2827                                           Uzbekistan Developing Category C
# 2828                                           Uzbekistan Developing Category C
# 2829                                           Uzbekistan Developing Category B
# 2830                                           Uzbekistan Developing Category C
# 2831                                           Uzbekistan Developing Category A
# 2832                                           Uzbekistan Developing Category B
# 2833                                           Uzbekistan Developing Category C
# 2834                                           Uzbekistan Developing Category A
# 2835                                           Uzbekistan Developing Category A
# 2836                                           Uzbekistan Developing Category C
# 2837                                           Uzbekistan Developing Category A
# 2838                                           Uzbekistan Developing Category A
# 2839                                           Uzbekistan Developing Category A
# 2840                                           Uzbekistan Developing Category C
# 2841                                           Uzbekistan Developing Category B
# 2842                                           Uzbekistan Developing Category B
# 2843                                              Vanuatu Developing Category B
# 2844                                              Vanuatu Developing Category A
# 2845                                              Vanuatu Developing Category B
# 2846                                              Vanuatu Developing Category B
# 2847                                              Vanuatu Developing Category B
# 2848                                              Vanuatu Developing Category B
# 2849                                              Vanuatu Developing Category B
# 2850                                              Vanuatu Developing Category C
# 2851                                              Vanuatu Developing Category B
# 2852                                              Vanuatu Developing Category C
# 2853                                              Vanuatu Developing Category B
# 2854                                              Vanuatu Developing Category C
# 2855                                              Vanuatu Developing Category A
# 2856                                              Vanuatu Developing Category C
# 2857                                              Vanuatu Developing Category B
# 2858                                              Vanuatu Developing Category B
# 2859                   Venezuela (Bolivarian Republic of) Developing Category B
# 2860                   Venezuela (Bolivarian Republic of) Developing Category A
# 2861                   Venezuela (Bolivarian Republic of) Developing Category A
# 2862                   Venezuela (Bolivarian Republic of) Developing Category C
# 2863                   Venezuela (Bolivarian Republic of) Developing Category B
# 2864                   Venezuela (Bolivarian Republic of) Developing Category A
# 2865                   Venezuela (Bolivarian Republic of) Developing Category A
# 2866                   Venezuela (Bolivarian Republic of) Developing Category C
# 2867                   Venezuela (Bolivarian Republic of) Developing Category B
# 2868                   Venezuela (Bolivarian Republic of) Developing Category B
# 2869                   Venezuela (Bolivarian Republic of) Developing Category A
# 2870                   Venezuela (Bolivarian Republic of) Developing Category B
# 2871                   Venezuela (Bolivarian Republic of) Developing Category C
# 2872                   Venezuela (Bolivarian Republic of) Developing Category A
# 2873                   Venezuela (Bolivarian Republic of) Developing Category A
# 2874                   Venezuela (Bolivarian Republic of) Developing Category C
# 2875                                             Viet Nam Developing Category A
# 2876                                             Viet Nam Developing Category A
# 2877                                             Viet Nam Developing Category B
# 2878                                             Viet Nam Developing Category C
# 2879                                             Viet Nam Developing Category C
# 2880                                             Viet Nam Developing Category C
# 2881                                             Viet Nam Developing Category B
# 2882                                             Viet Nam Developing Category A
# 2883                                             Viet Nam Developing Category C
# 2884                                             Viet Nam Developing Category A
# 2885                                             Viet Nam Developing Category C
# 2886                                             Viet Nam Developing Category C
# 2887                                             Viet Nam Developing Category A
# 2888                                             Viet Nam Developing Category A
# 2889                                             Viet Nam Developing Category B
# 2890                                             Viet Nam Developing Category A
# 2891                                                Yemen Developing Category B
# 2892                                                Yemen Developing Category B
# 2893                                                Yemen Developing Category A
# 2894                                                Yemen Developing Category A
# 2895                                                Yemen Developing Category C
# 2896                                                Yemen Developing Category A
# 2897                                                Yemen Developing Category C
# 2898                                                Yemen Developing Category C
# 2899                                                Yemen Developing Category A
# 2900                                                Yemen Developing Category A
# 2901                                                Yemen Developing Category C
# 2902                                                Yemen Developing Category C
# 2903                                                Yemen Developing Category B
# 2904                                                Yemen Developing Category A
# 2905                                                Yemen Developing Category A
# 2906                                                Yemen Developing Category A
# 2907                                               Zambia Developing Category A
# 2908                                               Zambia Developing Category B
# 2909                                               Zambia Developing Category C
# 2910                                               Zambia Developing Category B
# 2911                                               Zambia Developing Category B
# 2912                                               Zambia Developing Category A
# 2913                                               Zambia Developing Category C
# 2914                                               Zambia Developing Category B
# 2915                                               Zambia Developing Category C
# 2916                                               Zambia Developing Category B
# 2917                                               Zambia Developing Category A
# 2918                                               Zambia Developing Category A
# 2919                                               Zambia Developing Category C
# 2920                                               Zambia Developing Category A
# 2921                                               Zambia Developing Category C
# 2922                                               Zambia Developing Category A
# 2923                                             Zimbabwe Developing Category C
# 2924                                             Zimbabwe Developing Category A
# 2925                                             Zimbabwe Developing Category C
# 2926                                             Zimbabwe Developing Category A
# 2927                                             Zimbabwe Developing Category C
# 2928                                             Zimbabwe Developing Category A
# 2929                                             Zimbabwe Developing Category C
# 2930                                             Zimbabwe Developing Category A
# 2931                                             Zimbabwe Developing Category C
# 2932                                             Zimbabwe Developing Category C
# 2933                                             Zimbabwe Developing Category A
# 2934                                             Zimbabwe Developing Category B
# 2935                                             Zimbabwe Developing Category A
# 2936                                             Zimbabwe Developing Category B
# 2937                                             Zimbabwe Developing Category C
# 2938                                             Zimbabwe Developing Category A
#        Level                                       Status2
# 1    Level 2 Developing in an inconsisten rate of increase
# 2    Level 2          No deteminated by the OMS, but is OK
# 3    Level 1          No deteminated by the OMS, but is OK
# 4    Level 2 Developing in an inconsisten rate of increase
# 5    Level 2          No deteminated by the OMS, but is OK
# 6    Level 2 Developing in an inconsisten rate of increase
# 7    Level 1 Developing in an inconsisten rate of increase
# 8    Level 3          No deteminated by the OMS, but is OK
# 9    Level 2 Developing in an inconsisten rate of increase
# 10   Level 2          No deteminated by the OMS, but is OK
# 11   Level 2 Developing in an inconsisten rate of increase
# 12   Level 1 Developing in an inconsisten rate of increase
# 13   Level 1 Developing in an inconsisten rate of increase
# 14   Level 3          No deteminated by the OMS, but is OK
# 15   Level 3          No deteminated by the OMS, but is OK
# 16   Level 2 Developing in an inconsisten rate of increase
# 17   Level 2 Developing in an inconsisten rate of increase
# 18   Level 1          No deteminated by the OMS, but is OK
# 19   Level 3          No deteminated by the OMS, but is OK
# 20   Level 1          No deteminated by the OMS, but is OK
# 21   Level 2          No deteminated by the OMS, but is OK
# 22   Level 1          No deteminated by the OMS, but is OK
# 23   Level 3 Developing in an inconsisten rate of increase
# 24   Level 1 Developing in an inconsisten rate of increase
# 25   Level 3 Developing in an inconsisten rate of increase
# 26   Level 3 Developing in an inconsisten rate of increase
# 27   Level 1 Developing in an inconsisten rate of increase
# 28   Level 3 Developing in an inconsisten rate of increase
# 29   Level 1 Developing in an inconsisten rate of increase
# 30   Level 1          No deteminated by the OMS, but is OK
# 31   Level 1          No deteminated by the OMS, but is OK
# 32   Level 2 Developing in an inconsisten rate of increase
# 33   Level 2 Developing in an inconsisten rate of increase
# 34   Level 1          No deteminated by the OMS, but is OK
# 35   Level 3          No deteminated by the OMS, but is OK
# 36   Level 3          No deteminated by the OMS, but is OK
# 37   Level 1          No deteminated by the OMS, but is OK
# 38   Level 2          No deteminated by the OMS, but is OK
# 39   Level 1 Developing in an inconsisten rate of increase
# 40   Level 2 Developing in an inconsisten rate of increase
# 41   Level 3 Developing in an inconsisten rate of increase
# 42   Level 3 Developing in an inconsisten rate of increase
# 43   Level 2 Developing in an inconsisten rate of increase
# 44   Level 3          No deteminated by the OMS, but is OK
# 45   Level 2          No deteminated by the OMS, but is OK
# 46   Level 2 Developing in an inconsisten rate of increase
# 47   Level 1 Developing in an inconsisten rate of increase
# 48   Level 2          No deteminated by the OMS, but is OK
# 49   Level 2          No deteminated by the OMS, but is OK
# 50   Level 2          No deteminated by the OMS, but is OK
# 51   Level 1          No deteminated by the OMS, but is OK
# 52   Level 2          No deteminated by the OMS, but is OK
# 53   Level 3 Developing in an inconsisten rate of increase
# 54   Level 1 Developing in an inconsisten rate of increase
# 55   Level 1 Developing in an inconsisten rate of increase
# 56   Level 3 Developing in an inconsisten rate of increase
# 57   Level 1 Developing in an inconsisten rate of increase
# 58   Level 3          No deteminated by the OMS, but is OK
# 59   Level 1          No deteminated by the OMS, but is OK
# 60   Level 1 Developing in an inconsisten rate of increase
# 61   Level 3 Developing in an inconsisten rate of increase
# 62   Level 2          No deteminated by the OMS, but is OK
# 63   Level 3          No deteminated by the OMS, but is OK
# 64   Level 1          No deteminated by the OMS, but is OK
# 65   Level 1          No deteminated by the OMS, but is OK
# 66   Level 1          No deteminated by the OMS, but is OK
# 67   Level 3 Developing in an inconsisten rate of increase
# 68   Level 3 Developing in an inconsisten rate of increase
# 69   Level 2 Developing in an inconsisten rate of increase
# 70   Level 2 Developing in an inconsisten rate of increase
# 71   Level 3 Developing in an inconsisten rate of increase
# 72   Level 1          No deteminated by the OMS, but is OK
# 73   Level 3          No deteminated by the OMS, but is OK
# 74   Level 1 Developing in an inconsisten rate of increase
# 75   Level 1 Developing in an inconsisten rate of increase
# 76   Level 1          No deteminated by the OMS, but is OK
# 77   Level 1          No deteminated by the OMS, but is OK
# 78   Level 3          No deteminated by the OMS, but is OK
# 79   Level 1          No deteminated by the OMS, but is OK
# 80   Level 3          No deteminated by the OMS, but is OK
# 81   Level 2 Developing in an inconsisten rate of increase
# 82   Level 2 Developing in an inconsisten rate of increase
# 83   Level 3 Developing in an inconsisten rate of increase
# 84   Level 1 Developing in an inconsisten rate of increase
# 85   Level 3 Developing in an inconsisten rate of increase
# 86   Level 3          No deteminated by the OMS, but is OK
# 87   Level 2          No deteminated by the OMS, but is OK
# 88   Level 3 Developing in an inconsisten rate of increase
# 89   Level 3          No deteminated by the OMS, but is OK
# 90   Level 2 Developing in an inconsisten rate of increase
# 91   Level 2 Developing in an inconsisten rate of increase
# 92   Level 1          No deteminated by the OMS, but is OK
# 93   Level 2 Developing in an inconsisten rate of increase
# 94   Level 1          No deteminated by the OMS, but is OK
# 95   Level 1 Developing in an inconsisten rate of increase
# 96   Level 2 Developing in an inconsisten rate of increase
# 97   Level 2 Developing in an inconsisten rate of increase
# 98   Level 3          No deteminated by the OMS, but is OK
# 99   Level 2          No deteminated by the OMS, but is OK
# 100  Level 3 Developing in an inconsisten rate of increase
# 101  Level 2 Developing in an inconsisten rate of increase
# 102  Level 2          No deteminated by the OMS, but is OK
# 103  Level 3          No deteminated by the OMS, but is OK
# 104  Level 3          No deteminated by the OMS, but is OK
# 105  Level 3          No deteminated by the OMS, but is OK
# 106  Level 2          No deteminated by the OMS, but is OK
# 107  Level 2 Developing in an inconsisten rate of increase
# 108  Level 1 Developing in an inconsisten rate of increase
# 109  Level 2 Developing in an inconsisten rate of increase
# 110  Level 1 Developing in an inconsisten rate of increase
# 111  Level 2 Developing in an inconsisten rate of increase
# 112  Level 2 Developing in an inconsisten rate of increase
# 113  Level 3 Developing in an inconsisten rate of increase
# 114  Level 3          No deteminated by the OMS, but is OK
# 115  Level 2          No deteminated by the OMS, but is OK
# 116  Level 1 Developing in an inconsisten rate of increase
# 117  Level 3 Developing in an inconsisten rate of increase
# 118  Level 3          No deteminated by the OMS, but is OK
# 119  Level 2          No deteminated by the OMS, but is OK
# 120  Level 3          No deteminated by the OMS, but is OK
# 121  Level 3          No deteminated by the OMS, but is OK
# 122  Level 2          No deteminated by the OMS, but is OK
# 123  Level 1 Developing in an inconsisten rate of increase
# 124  Level 2 Developing in an inconsisten rate of increase
# 125  Level 2 Developing in an inconsisten rate of increase
# 126  Level 1 Developing in an inconsisten rate of increase
# 127  Level 1 Developing in an inconsisten rate of increase
# 128  Level 3          No deteminated by the OMS, but is OK
# 129  Level 2          No deteminated by the OMS, but is OK
# 130  Level 1 Developing in an inconsisten rate of increase
# 131  Level 1 Developing in an inconsisten rate of increase
# 132  Level 2          No deteminated by the OMS, but is OK
# 133  Level 1          No deteminated by the OMS, but is OK
# 134  Level 2          No deteminated by the OMS, but is OK
# 135  Level 2          No deteminated by the OMS, but is OK
# 136  Level 1          No deteminated by the OMS, but is OK
# 137  Level 3 Developing in an inconsisten rate of increase
# 138  Level 1 Developing in an inconsisten rate of increase
# 139  Level 2 Developing in an inconsisten rate of increase
# 140  Level 2 Developing in an inconsisten rate of increase
# 141  Level 2 Developing in an inconsisten rate of increase
# 142  Level 1          No deteminated by the OMS, but is OK
# 143  Level 2          No deteminated by the OMS, but is OK
# 144  Level 2 Developing in an inconsisten rate of increase
# 145  Level 2 Developing in an inconsisten rate of increase
# 146  Level 2          No deteminated by the OMS, but is OK
# 147  Level 3          No deteminated by the OMS, but is OK
# 148  Level 2          No deteminated by the OMS, but is OK
# 149  Level 3          No deteminated by the OMS, but is OK
# 150  Level 2          No deteminated by the OMS, but is OK
# 151  Level 3 Developing in an inconsisten rate of increase
# 152  Level 2 Developing in an inconsisten rate of increase
# 153  Level 3 Developing in an inconsisten rate of increase
# 154  Level 2 Developing in an inconsisten rate of increase
# 155  Level 1 Developing in an inconsisten rate of increase
# 156  Level 2          No deteminated by the OMS, but is OK
# 157  Level 3          No deteminated by the OMS, but is OK
# 158  Level 2 Developing in an inconsisten rate of increase
# 159  Level 3 Developing in an inconsisten rate of increase
# 160  Level 1          No deteminated by the OMS, but is OK
# 161  Level 1          No deteminated by the OMS, but is OK
# 162  Level 1          No deteminated by the OMS, but is OK
# 163  Level 2          No deteminated by the OMS, but is OK
# 164  Level 3          No deteminated by the OMS, but is OK
# 165  Level 2 Developing in an inconsisten rate of increase
# 166  Level 2 Developing in an inconsisten rate of increase
# 167  Level 1 Developing in an inconsisten rate of increase
# 168  Level 2 Developing in an inconsisten rate of increase
# 169  Level 2 Developing in an inconsisten rate of increase
# 170  Level 3          No deteminated by the OMS, but is OK
# 171  Level 1          No deteminated by the OMS, but is OK
# 172  Level 2 Developing in an inconsisten rate of increase
# 173  Level 1          No deteminated by the OMS, but is OK
# 174  Level 2 Developing in an inconsisten rate of increase
# 175  Level 2 Developing in an inconsisten rate of increase
# 176  Level 1          No deteminated by the OMS, but is OK
# 177  Level 3 Developing in an inconsisten rate of increase
# 178  Level 3          No deteminated by the OMS, but is OK
# 179  Level 2 Developing in an inconsisten rate of increase
# 180  Level 2 Developing in an inconsisten rate of increase
# 181  Level 1 Developing in an inconsisten rate of increase
# 182  Level 1          No deteminated by the OMS, but is OK
# 183  Level 1          No deteminated by the OMS, but is OK
# 184  Level 1 Developing in an inconsisten rate of increase
# 185  Level 3 Developing in an inconsisten rate of increase
# 186  Level 2          No deteminated by the OMS, but is OK
# 187  Level 2          No deteminated by the OMS, but is OK
# 188  Level 3          No deteminated by the OMS, but is OK
# 189  Level 1          No deteminated by the OMS, but is OK
# 190  Level 2          No deteminated by the OMS, but is OK
# 191  Level 2 Developing in an inconsisten rate of increase
# 192  Level 2 Developing in an inconsisten rate of increase
# 193  Level 2 Developing in an inconsisten rate of increase
# 194  Level 3 Developing in an inconsisten rate of increase
# 195  Level 2 Developing in an inconsisten rate of increase
# 196  Level 3 Developing in an inconsisten rate of increase
# 197  Level 1 Developing in an inconsisten rate of increase
# 198  Level 3          No deteminated by the OMS, but is OK
# 199  Level 2          No deteminated by the OMS, but is OK
# 200  Level 1 Developing in an inconsisten rate of increase
# 201  Level 3 Developing in an inconsisten rate of increase
# 202  Level 1          No deteminated by the OMS, but is OK
# 203  Level 3          No deteminated by the OMS, but is OK
# 204  Level 1          No deteminated by the OMS, but is OK
# 205  Level 3          No deteminated by the OMS, but is OK
# 206  Level 3          No deteminated by the OMS, but is OK
# 207  Level 2 Developing in an inconsisten rate of increase
# 208  Level 1 Developing in an inconsisten rate of increase
# 209  Level 1 Developing in an inconsisten rate of increase
# 210  Level 3 Developing in an inconsisten rate of increase
# 211  Level 3 Developing in an inconsisten rate of increase
# 212  Level 2          No deteminated by the OMS, but is OK
# 213  Level 2          No deteminated by the OMS, but is OK
# 214  Level 1 Developing in an inconsisten rate of increase
# 215  Level 3 Developing in an inconsisten rate of increase
# 216  Level 2          No deteminated by the OMS, but is OK
# 217  Level 2          No deteminated by the OMS, but is OK
# 218  Level 2          No deteminated by the OMS, but is OK
# 219  Level 1          No deteminated by the OMS, but is OK
# 220  Level 1          No deteminated by the OMS, but is OK
# 221  Level 1 Developing in an inconsisten rate of increase
# 222  Level 3 Developing in an inconsisten rate of increase
# 223  Level 3 Developing in an inconsisten rate of increase
# 224  Level 3 Developing in an inconsisten rate of increase
# 225  Level 2 Developing in an inconsisten rate of increase
# 226  Level 3          No deteminated by the OMS, but is OK
# 227  Level 2          No deteminated by the OMS, but is OK
# 228  Level 1 Developing in an inconsisten rate of increase
# 229  Level 3 Developing in an inconsisten rate of increase
# 230  Level 3          No deteminated by the OMS, but is OK
# 231  Level 2          No deteminated by the OMS, but is OK
# 232  Level 2          No deteminated by the OMS, but is OK
# 233  Level 1          No deteminated by the OMS, but is OK
# 234  Level 3          No deteminated by the OMS, but is OK
# 235  Level 2 Developing in an inconsisten rate of increase
# 236  Level 1 Developing in an inconsisten rate of increase
# 237  Level 2 Developing in an inconsisten rate of increase
# 238  Level 3 Developing in an inconsisten rate of increase
# 239  Level 3 Developing in an inconsisten rate of increase
# 240  Level 3          No deteminated by the OMS, but is OK
# 241  Level 2          No deteminated by the OMS, but is OK
# 242  Level 3 Developing in an inconsisten rate of increase
# 243  Level 1 Developing in an inconsisten rate of increase
# 244  Level 1          No deteminated by the OMS, but is OK
# 245  Level 3          No deteminated by the OMS, but is OK
# 246  Level 3          No deteminated by the OMS, but is OK
# 247  Level 2          No deteminated by the OMS, but is OK
# 248  Level 3          No deteminated by the OMS, but is OK
# 249  Level 3 Developing in an inconsisten rate of increase
# 250  Level 3 Developing in an inconsisten rate of increase
# 251  Level 2 Developing in an inconsisten rate of increase
# 252  Level 3 Developing in an inconsisten rate of increase
# 253  Level 1 Developing in an inconsisten rate of increase
# 254  Level 2          No deteminated by the OMS, but is OK
# 255  Level 1          No deteminated by the OMS, but is OK
# 256  Level 2 Developing in an inconsisten rate of increase
# 257  Level 3          No deteminated by the OMS, but is OK
# 258  Level 2 Developing in an inconsisten rate of increase
# 259  Level 1 Developing in an inconsisten rate of increase
# 260  Level 3          No deteminated by the OMS, but is OK
# 261  Level 2 Developing in an inconsisten rate of increase
# 262  Level 3          No deteminated by the OMS, but is OK
# 263  Level 2 Developing in an inconsisten rate of increase
# 264  Level 3 Developing in an inconsisten rate of increase
# 265  Level 1 Developing in an inconsisten rate of increase
# 266  Level 3          No deteminated by the OMS, but is OK
# 267  Level 2          No deteminated by the OMS, but is OK
# 268  Level 1 Developing in an inconsisten rate of increase
# 269  Level 1 Developing in an inconsisten rate of increase
# 270  Level 2          No deteminated by the OMS, but is OK
# 271  Level 2          No deteminated by the OMS, but is OK
# 272  Level 2          No deteminated by the OMS, but is OK
# 273  Level 1          No deteminated by the OMS, but is OK
# 274  Level 1          No deteminated by the OMS, but is OK
# 275  Level 1 Developing in an inconsisten rate of increase
# 276  Level 1 Developing in an inconsisten rate of increase
# 277  Level 1 Developing in an inconsisten rate of increase
# 278  Level 1 Developing in an inconsisten rate of increase
# 279  Level 2 Developing in an inconsisten rate of increase
# 280  Level 1 Developing in an inconsisten rate of increase
# 281  Level 2 Developing in an inconsisten rate of increase
# 282  Level 1          No deteminated by the OMS, but is OK
# 283  Level 1          No deteminated by the OMS, but is OK
# 284  Level 3 Developing in an inconsisten rate of increase
# 285  Level 3 Developing in an inconsisten rate of increase
# 286  Level 1          No deteminated by the OMS, but is OK
# 287  Level 3          No deteminated by the OMS, but is OK
# 288  Level 1          No deteminated by the OMS, but is OK
# 289  Level 3          No deteminated by the OMS, but is OK
# 290  Level 2          No deteminated by the OMS, but is OK
# 291  Level 2 Developing in an inconsisten rate of increase
# 292  Level 3 Developing in an inconsisten rate of increase
# 293  Level 3 Developing in an inconsisten rate of increase
# 294  Level 1 Developing in an inconsisten rate of increase
# 295  Level 2 Developing in an inconsisten rate of increase
# 296  Level 2          No deteminated by the OMS, but is OK
# 297  Level 1          No deteminated by the OMS, but is OK
# 298  Level 2 Developing in an inconsisten rate of increase
# 299  Level 1 Developing in an inconsisten rate of increase
# 300  Level 1          No deteminated by the OMS, but is OK
# 301  Level 2          No deteminated by the OMS, but is OK
# 302  Level 2          No deteminated by the OMS, but is OK
# 303  Level 2          No deteminated by the OMS, but is OK
# 304  Level 2          No deteminated by the OMS, but is OK
# 305  Level 2 Developing in an inconsisten rate of increase
# 306  Level 1 Developing in an inconsisten rate of increase
# 307  Level 3 Developing in an inconsisten rate of increase
# 308  Level 1 Developing in an inconsisten rate of increase
# 309  Level 1 Developing in an inconsisten rate of increase
# 310  Level 2          No deteminated by the OMS, but is OK
# 311  Level 1          No deteminated by the OMS, but is OK
# 312  Level 2 Developing in an inconsisten rate of increase
# 313  Level 1 Developing in an inconsisten rate of increase
# 314  Level 1          No deteminated by the OMS, but is OK
# 315  Level 3          No deteminated by the OMS, but is OK
# 316  Level 1          No deteminated by the OMS, but is OK
# 317  Level 3          No deteminated by the OMS, but is OK
# 318  Level 2          No deteminated by the OMS, but is OK
# 319  Level 2 Developing in an inconsisten rate of increase
# 320  Level 2 Developing in an inconsisten rate of increase
# 321  Level 3 Developing in an inconsisten rate of increase
# 322  Level 2 Developing in an inconsisten rate of increase
# 323  Level 1 Developing in an inconsisten rate of increase
# 324  Level 2          No deteminated by the OMS, but is OK
# 325  Level 1          No deteminated by the OMS, but is OK
# 326  Level 1 Developing in an inconsisten rate of increase
# 327  Level 1 Developing in an inconsisten rate of increase
# 328  Level 2          No deteminated by the OMS, but is OK
# 329  Level 3          No deteminated by the OMS, but is OK
# 330  Level 1          No deteminated by the OMS, but is OK
# 331  Level 3          No deteminated by the OMS, but is OK
# 332  Level 1          No deteminated by the OMS, but is OK
# 333  Level 2 Developing in an inconsisten rate of increase
# 334  Level 2 Developing in an inconsisten rate of increase
# 335  Level 3 Developing in an inconsisten rate of increase
# 336  Level 1 Developing in an inconsisten rate of increase
# 337  Level 3 Developing in an inconsisten rate of increase
# 338  Level 2          No deteminated by the OMS, but is OK
# 339  Level 1          No deteminated by the OMS, but is OK
# 340  Level 2 Developing in an inconsisten rate of increase
# 341  Level 3          No deteminated by the OMS, but is OK
# 342  Level 3 Developing in an inconsisten rate of increase
# 343  Level 3 Developing in an inconsisten rate of increase
# 344  Level 2          No deteminated by the OMS, but is OK
# 345  Level 2 Developing in an inconsisten rate of increase
# 346  Level 3          No deteminated by the OMS, but is OK
# 347  Level 1 Developing in an inconsisten rate of increase
# 348  Level 1 Developing in an inconsisten rate of increase
# 349  Level 1 Developing in an inconsisten rate of increase
# 350  Level 1          No deteminated by the OMS, but is OK
# 351  Level 1          No deteminated by the OMS, but is OK
# 352  Level 2 Developing in an inconsisten rate of increase
# 353  Level 1 Developing in an inconsisten rate of increase
# 354  Level 2          No deteminated by the OMS, but is OK
# 355  Level 3          No deteminated by the OMS, but is OK
# 356  Level 3          No deteminated by the OMS, but is OK
# 357  Level 1          No deteminated by the OMS, but is OK
# 358  Level 1          No deteminated by the OMS, but is OK
# 359  Level 3 Developing in an inconsisten rate of increase
# 360  Level 2 Developing in an inconsisten rate of increase
# 361  Level 2 Developing in an inconsisten rate of increase
# 362  Level 3 Developing in an inconsisten rate of increase
# 363  Level 2 Developing in an inconsisten rate of increase
# 364  Level 3 Developing in an inconsisten rate of increase
# 365  Level 2 Developing in an inconsisten rate of increase
# 366  Level 2          No deteminated by the OMS, but is OK
# 367  Level 1          No deteminated by the OMS, but is OK
# 368  Level 3 Developing in an inconsisten rate of increase
# 369  Level 3 Developing in an inconsisten rate of increase
# 370  Level 1          No deteminated by the OMS, but is OK
# 371  Level 3          No deteminated by the OMS, but is OK
# 372  Level 2          No deteminated by the OMS, but is OK
# 373  Level 2          No deteminated by the OMS, but is OK
# 374  Level 2          No deteminated by the OMS, but is OK
# 375  Level 2 Developing in an inconsisten rate of increase
# 376  Level 2 Developing in an inconsisten rate of increase
# 377  Level 2 Developing in an inconsisten rate of increase
# 378  Level 2 Developing in an inconsisten rate of increase
# 379  Level 2 Developing in an inconsisten rate of increase
# 380  Level 2          No deteminated by the OMS, but is OK
# 381  Level 2          No deteminated by the OMS, but is OK
# 382  Level 2 Developing in an inconsisten rate of increase
# 383  Level 2 Developing in an inconsisten rate of increase
# 384  Level 1          No deteminated by the OMS, but is OK
# 385  Level 2          No deteminated by the OMS, but is OK
# 386  Level 1          No deteminated by the OMS, but is OK
# 387  Level 2          No deteminated by the OMS, but is OK
# 388  Level 1          No deteminated by the OMS, but is OK
# 389  Level 2 Developing in an inconsisten rate of increase
# 390  Level 2 Developing in an inconsisten rate of increase
# 391  Level 1 Developing in an inconsisten rate of increase
# 392  Level 3 Developing in an inconsisten rate of increase
# 393  Level 3 Developing in an inconsisten rate of increase
# 394  Level 1          No deteminated by the OMS, but is OK
# 395  Level 2          No deteminated by the OMS, but is OK
# 396  Level 3 Developing in an inconsisten rate of increase
# 397  Level 3 Developing in an inconsisten rate of increase
# 398  Level 2          No deteminated by the OMS, but is OK
# 399  Level 2          No deteminated by the OMS, but is OK
# 400  Level 1          No deteminated by the OMS, but is OK
# 401  Level 3          No deteminated by the OMS, but is OK
# 402  Level 3          No deteminated by the OMS, but is OK
# 403  Level 1 Developing in an inconsisten rate of increase
# 404  Level 2 Developing in an inconsisten rate of increase
# 405  Level 3 Developing in an inconsisten rate of increase
# 406  Level 1 Developing in an inconsisten rate of increase
# 407  Level 2 Developing in an inconsisten rate of increase
# 408  Level 1          No deteminated by the OMS, but is OK
# 409  Level 3          No deteminated by the OMS, but is OK
# 410  Level 3 Developing in an inconsisten rate of increase
# 411  Level 2 Developing in an inconsisten rate of increase
# 412  Level 2          No deteminated by the OMS, but is OK
# 413  Level 1          No deteminated by the OMS, but is OK
# 414  Level 2          No deteminated by the OMS, but is OK
# 415  Level 2          No deteminated by the OMS, but is OK
# 416  Level 1          No deteminated by the OMS, but is OK
# 417  Level 3 Developing in an inconsisten rate of increase
# 418  Level 2 Developing in an inconsisten rate of increase
# 419  Level 3 Developing in an inconsisten rate of increase
# 420  Level 2 Developing in an inconsisten rate of increase
# 421  Level 1 Developing in an inconsisten rate of increase
# 422  Level 1          No deteminated by the OMS, but is OK
# 423  Level 3          No deteminated by the OMS, but is OK
# 424  Level 1 Developing in an inconsisten rate of increase
# 425  Level 3          No deteminated by the OMS, but is OK
# 426  Level 2 Developing in an inconsisten rate of increase
# 427  Level 1 Developing in an inconsisten rate of increase
# 428  Level 2          No deteminated by the OMS, but is OK
# 429  Level 1 Developing in an inconsisten rate of increase
# 430  Level 2          No deteminated by the OMS, but is OK
# 431  Level 1 Developing in an inconsisten rate of increase
# 432  Level 3 Developing in an inconsisten rate of increase
# 433  Level 1 Developing in an inconsisten rate of increase
# 434  Level 3          No deteminated by the OMS, but is OK
# 435  Level 1          No deteminated by the OMS, but is OK
# 436  Level 1 Developing in an inconsisten rate of increase
# 437  Level 3 Developing in an inconsisten rate of increase
# 438  Level 1          No deteminated by the OMS, but is OK
# 439  Level 1          No deteminated by the OMS, but is OK
# 440  Level 3          No deteminated by the OMS, but is OK
# 441  Level 2          No deteminated by the OMS, but is OK
# 442  Level 1          No deteminated by the OMS, but is OK
# 443  Level 3 Developing in an inconsisten rate of increase
# 444  Level 1 Developing in an inconsisten rate of increase
# 445  Level 1 Developing in an inconsisten rate of increase
# 446  Level 3 Developing in an inconsisten rate of increase
# 447  Level 1 Developing in an inconsisten rate of increase
# 448  Level 3 Developing in an inconsisten rate of increase
# 449  Level 2 Developing in an inconsisten rate of increase
# 450  Level 3          No deteminated by the OMS, but is OK
# 451  Level 3          No deteminated by the OMS, but is OK
# 452  Level 2 Developing in an inconsisten rate of increase
# 453  Level 2 Developing in an inconsisten rate of increase
# 454  Level 1          No deteminated by the OMS, but is OK
# 455  Level 3          No deteminated by the OMS, but is OK
# 456  Level 2          No deteminated by the OMS, but is OK
# 457  Level 3          No deteminated by the OMS, but is OK
# 458  Level 2          No deteminated by the OMS, but is OK
# 459  Level 2 Developing in an inconsisten rate of increase
# 460  Level 3 Developing in an inconsisten rate of increase
# 461  Level 2 Developing in an inconsisten rate of increase
# 462  Level 1 Developing in an inconsisten rate of increase
# 463  Level 2 Developing in an inconsisten rate of increase
# 464  Level 2          No deteminated by the OMS, but is OK
# 465  Level 1          No deteminated by the OMS, but is OK
# 466  Level 3 Developing in an inconsisten rate of increase
# 467  Level 3 Developing in an inconsisten rate of increase
# 468  Level 1          No deteminated by the OMS, but is OK
# 469  Level 3          No deteminated by the OMS, but is OK
# 470  Level 2          No deteminated by the OMS, but is OK
# 471  Level 1          No deteminated by the OMS, but is OK
# 472  Level 2          No deteminated by the OMS, but is OK
# 473  Level 1 Developing in an inconsisten rate of increase
# 474  Level 3 Developing in an inconsisten rate of increase
# 475  Level 3 Developing in an inconsisten rate of increase
# 476  Level 2 Developing in an inconsisten rate of increase
# 477  Level 1 Developing in an inconsisten rate of increase
# 478  Level 3          No deteminated by the OMS, but is OK
# 479  Level 2          No deteminated by the OMS, but is OK
# 480  Level 1 Developing in an inconsisten rate of increase
# 481  Level 1 Developing in an inconsisten rate of increase
# 482  Level 2          No deteminated by the OMS, but is OK
# 483  Level 1          No deteminated by the OMS, but is OK
# 484  Level 3          No deteminated by the OMS, but is OK
# 485  Level 1          No deteminated by the OMS, but is OK
# 486  Level 2          No deteminated by the OMS, but is OK
# 487  Level 3 Developing in an inconsisten rate of increase
# 488  Level 2 Developing in an inconsisten rate of increase
# 489  Level 1 Developing in an inconsisten rate of increase
# 490  Level 3 Developing in an inconsisten rate of increase
# 491  Level 2 Developing in an inconsisten rate of increase
# 492  Level 3          No deteminated by the OMS, but is OK
# 493  Level 1          No deteminated by the OMS, but is OK
# 494  Level 2 Developing in an inconsisten rate of increase
# 495  Level 2 Developing in an inconsisten rate of increase
# 496  Level 3          No deteminated by the OMS, but is OK
# 497  Level 3          No deteminated by the OMS, but is OK
# 498  Level 2          No deteminated by the OMS, but is OK
# 499  Level 3          No deteminated by the OMS, but is OK
# 500  Level 3          No deteminated by the OMS, but is OK
# 501  Level 2 Developing in an inconsisten rate of increase
# 502  Level 3 Developing in an inconsisten rate of increase
# 503  Level 2 Developing in an inconsisten rate of increase
# 504  Level 1 Developing in an inconsisten rate of increase
# 505  Level 1 Developing in an inconsisten rate of increase
# 506  Level 3          No deteminated by the OMS, but is OK
# 507  Level 2          No deteminated by the OMS, but is OK
# 508  Level 1 Developing in an inconsisten rate of increase
# 509  Level 3          No deteminated by the OMS, but is OK
# 510  Level 1 Developing in an inconsisten rate of increase
# 511  Level 1 Developing in an inconsisten rate of increase
# 512  Level 2          No deteminated by the OMS, but is OK
# 513  Level 3 Developing in an inconsisten rate of increase
# 514  Level 2          No deteminated by the OMS, but is OK
# 515  Level 2 Developing in an inconsisten rate of increase
# 516  Level 2 Developing in an inconsisten rate of increase
# 517  Level 2 Developing in an inconsisten rate of increase
# 518  Level 3          No deteminated by the OMS, but is OK
# 519  Level 2          No deteminated by the OMS, but is OK
# 520  Level 3 Developing in an inconsisten rate of increase
# 521  Level 1 Developing in an inconsisten rate of increase
# 522  Level 2          No deteminated by the OMS, but is OK
# 523  Level 1          No deteminated by the OMS, but is OK
# 524  Level 2          No deteminated by the OMS, but is OK
# 525  Level 3          No deteminated by the OMS, but is OK
# 526  Level 1          No deteminated by the OMS, but is OK
# 527  Level 3 Developing in an inconsisten rate of increase
# 528  Level 3 Developing in an inconsisten rate of increase
# 529  Level 1 Developing in an inconsisten rate of increase
# 530  Level 1 Developing in an inconsisten rate of increase
# 531  Level 1 Developing in an inconsisten rate of increase
# 532  Level 1 Developing in an inconsisten rate of increase
# 533  Level 1 Developing in an inconsisten rate of increase
# 534  Level 1          No deteminated by the OMS, but is OK
# 535  Level 3          No deteminated by the OMS, but is OK
# 536  Level 3 Developing in an inconsisten rate of increase
# 537  Level 1 Developing in an inconsisten rate of increase
# 538  Level 2          No deteminated by the OMS, but is OK
# 539  Level 1          No deteminated by the OMS, but is OK
# 540  Level 3          No deteminated by the OMS, but is OK
# 541  Level 3          No deteminated by the OMS, but is OK
# 542  Level 3          No deteminated by the OMS, but is OK
# 543  Level 2 Developing in an inconsisten rate of increase
# 544  Level 2 Developing in an inconsisten rate of increase
# 545  Level 3 Developing in an inconsisten rate of increase
# 546  Level 3 Developing in an inconsisten rate of increase
# 547  Level 1 Developing in an inconsisten rate of increase
# 548  Level 1          No deteminated by the OMS, but is OK
# 549  Level 1          No deteminated by the OMS, but is OK
# 550  Level 1 Developing in an inconsisten rate of increase
# 551  Level 1 Developing in an inconsisten rate of increase
# 552  Level 2          No deteminated by the OMS, but is OK
# 553  Level 2          No deteminated by the OMS, but is OK
# 554  Level 3          No deteminated by the OMS, but is OK
# 555  Level 2          No deteminated by the OMS, but is OK
# 556  Level 3          No deteminated by the OMS, but is OK
# 557  Level 3 Developing in an inconsisten rate of increase
# 558  Level 2 Developing in an inconsisten rate of increase
# 559  Level 1 Developing in an inconsisten rate of increase
# 560  Level 1 Developing in an inconsisten rate of increase
# 561  Level 2 Developing in an inconsisten rate of increase
# 562  Level 2          No deteminated by the OMS, but is OK
# 563  Level 1          No deteminated by the OMS, but is OK
# 564  Level 1 Developing in an inconsisten rate of increase
# 565  Level 1 Developing in an inconsisten rate of increase
# 566  Level 2          No deteminated by the OMS, but is OK
# 567  Level 1          No deteminated by the OMS, but is OK
# 568  Level 3          No deteminated by the OMS, but is OK
# 569  Level 2          No deteminated by the OMS, but is OK
# 570  Level 3          No deteminated by the OMS, but is OK
# 571  Level 3 Developing in an inconsisten rate of increase
# 572  Level 1 Developing in an inconsisten rate of increase
# 573  Level 1 Developing in an inconsisten rate of increase
# 574  Level 3 Developing in an inconsisten rate of increase
# 575  Level 1 Developing in an inconsisten rate of increase
# 576  Level 3          No deteminated by the OMS, but is OK
# 577  Level 3          No deteminated by the OMS, but is OK
# 578  Level 1 Developing in an inconsisten rate of increase
# 579  Level 1 Developing in an inconsisten rate of increase
# 580  Level 1          No deteminated by the OMS, but is OK
# 581  Level 2          No deteminated by the OMS, but is OK
# 582  Level 1          No deteminated by the OMS, but is OK
# 583  Level 2          No deteminated by the OMS, but is OK
# 584  Level 2          No deteminated by the OMS, but is OK
# 585  Level 2 Developing in an inconsisten rate of increase
# 586  Level 3 Developing in an inconsisten rate of increase
# 587  Level 1 Developing in an inconsisten rate of increase
# 588  Level 3 Developing in an inconsisten rate of increase
# 589  Level 1 Developing in an inconsisten rate of increase
# 590  Level 2          No deteminated by the OMS, but is OK
# 591  Level 3          No deteminated by the OMS, but is OK
# 592  Level 2 Developing in an inconsisten rate of increase
# 593  Level 3          No deteminated by the OMS, but is OK
# 594  Level 2 Developing in an inconsisten rate of increase
# 595  Level 1 Developing in an inconsisten rate of increase
# 596  Level 1          No deteminated by the OMS, but is OK
# 597  Level 1 Developing in an inconsisten rate of increase
# 598  Level 1          No deteminated by the OMS, but is OK
# 599  Level 2 Developing in an inconsisten rate of increase
# 600  Level 3 Developing in an inconsisten rate of increase
# 601  Level 2 Developing in an inconsisten rate of increase
# 602  Level 2          No deteminated by the OMS, but is OK
# 603  Level 1          No deteminated by the OMS, but is OK
# 604  Level 2 Developing in an inconsisten rate of increase
# 605  Level 3 Developing in an inconsisten rate of increase
# 606  Level 2          No deteminated by the OMS, but is OK
# 607  Level 1          No deteminated by the OMS, but is OK
# 608  Level 3          No deteminated by the OMS, but is OK
# 609  Level 1          No deteminated by the OMS, but is OK
# 610  Level 1          No deteminated by the OMS, but is OK
# 611  Level 3 Developing in an inconsisten rate of increase
# 612  Level 3 Developing in an inconsisten rate of increase
# 613  Level 1 Developing in an inconsisten rate of increase
# 614  Level 1 Developing in an inconsisten rate of increase
# 615  Level 1 Developing in an inconsisten rate of increase
# 616  Level 3 Developing in an inconsisten rate of increase
# 617  Level 2 Developing in an inconsisten rate of increase
# 618  Level 3          No deteminated by the OMS, but is OK
# 619  Level 2          No deteminated by the OMS, but is OK
# 620  Level 1 Developing in an inconsisten rate of increase
# 621  Level 2 Developing in an inconsisten rate of increase
# 622  Level 3          No deteminated by the OMS, but is OK
# 623  Level 1          No deteminated by the OMS, but is OK
# 624  Level 3          No deteminated by the OMS, but is OK
# 625  Level 1          No deteminated by the OMS, but is OK
# 626  Level 2          No deteminated by the OMS, but is OK
# 627  Level 2 Developing in an inconsisten rate of increase
# 628  Level 1 Developing in an inconsisten rate of increase
# 629  Level 2 Developing in an inconsisten rate of increase
# 630  Level 1 Developing in an inconsisten rate of increase
# 631  Level 1 Developing in an inconsisten rate of increase
# 632  Level 2          No deteminated by the OMS, but is OK
# 633  Level 3          No deteminated by the OMS, but is OK
# 634  Level 1 Developing in an inconsisten rate of increase
# 635  Level 2 Developing in an inconsisten rate of increase
# 636  Level 3          No deteminated by the OMS, but is OK
# 637  Level 1          No deteminated by the OMS, but is OK
# 638  Level 3          No deteminated by the OMS, but is OK
# 639  Level 3          No deteminated by the OMS, but is OK
# 640  Level 2          No deteminated by the OMS, but is OK
# 641  Level 2 Developing in an inconsisten rate of increase
# 642  Level 2 Developing in an inconsisten rate of increase
# 643  Level 3 Developing in an inconsisten rate of increase
# 644  Level 3 Developing in an inconsisten rate of increase
# 645  Level 1 Developing in an inconsisten rate of increase
# 646  Level 1          No deteminated by the OMS, but is OK
# 647  Level 1          No deteminated by the OMS, but is OK
# 648  Level 1 Developing in an inconsisten rate of increase
# 649  Level 1 Developing in an inconsisten rate of increase
# 650  Level 1          No deteminated by the OMS, but is OK
# 651  Level 2          No deteminated by the OMS, but is OK
# 652  Level 2          No deteminated by the OMS, but is OK
# 653  Level 2          No deteminated by the OMS, but is OK
# 654  Level 1          No deteminated by the OMS, but is OK
# 655  Level 1 Developing in an inconsisten rate of increase
# 656  Level 3 Developing in an inconsisten rate of increase
# 657  Level 2 Developing in an inconsisten rate of increase
# 658  Level 2 Developing in an inconsisten rate of increase
# 659  Level 3 Developing in an inconsisten rate of increase
# 660  Level 3          No deteminated by the OMS, but is OK
# 661  Level 3          No deteminated by the OMS, but is OK
# 662  Level 1 Developing in an inconsisten rate of increase
# 663  Level 3 Developing in an inconsisten rate of increase
# 664  Level 1          No deteminated by the OMS, but is OK
# 665  Level 2          No deteminated by the OMS, but is OK
# 666  Level 3          No deteminated by the OMS, but is OK
# 667  Level 3          No deteminated by the OMS, but is OK
# 668  Level 3          No deteminated by the OMS, but is OK
# 669  Level 3 Developing in an inconsisten rate of increase
# 670  Level 3 Developing in an inconsisten rate of increase
# 671  Level 3 Developing in an inconsisten rate of increase
# 672  Level 2 Developing in an inconsisten rate of increase
# 673  Level 1 Developing in an inconsisten rate of increase
# 674  Level 2          No deteminated by the OMS, but is OK
# 675  Level 3          No deteminated by the OMS, but is OK
# 676  Level 1 Developing in an inconsisten rate of increase
# 677  Level 3          No deteminated by the OMS, but is OK
# 678  Level 1 Developing in an inconsisten rate of increase
# 679  Level 1 Developing in an inconsisten rate of increase
# 680  Level 3          No deteminated by the OMS, but is OK
# 681  Level 3 Developing in an inconsisten rate of increase
# 682  Level 2          No deteminated by the OMS, but is OK
# 683  Level 2 Developing in an inconsisten rate of increase
# 684  Level 3 Developing in an inconsisten rate of increase
# 685  Level 2 Developing in an inconsisten rate of increase
# 686  Level 2          No deteminated by the OMS, but is OK
# 687  Level 2          No deteminated by the OMS, but is OK
# 688  Level 3 Developing in an inconsisten rate of increase
# 689  Level 2 Developing in an inconsisten rate of increase
# 690  Level 3          No deteminated by the OMS, but is OK
# 691  Level 1          No deteminated by the OMS, but is OK
# 692  Level 3          No deteminated by the OMS, but is OK
# 693  Level 3          No deteminated by the OMS, but is OK
# 694  Level 3          No deteminated by the OMS, but is OK
# 695  Level 3 Developing in an inconsisten rate of increase
# 696  Level 2 Developing in an inconsisten rate of increase
# 697  Level 2 Developing in an inconsisten rate of increase
# 698  Level 1 Developing in an inconsisten rate of increase
# 699  Level 3 Developing in an inconsisten rate of increase
# 700  Level 2 Developing in an inconsisten rate of increase
# 701  Level 1 Developing in an inconsisten rate of increase
# 702  Level 2          No deteminated by the OMS, but is OK
# 703  Level 1          No deteminated by the OMS, but is OK
# 704  Level 3 Developing in an inconsisten rate of increase
# 705  Level 1 Developing in an inconsisten rate of increase
# 706  Level 2          No deteminated by the OMS, but is OK
# 707  Level 3          No deteminated by the OMS, but is OK
# 708  Level 3          No deteminated by the OMS, but is OK
# 709  Level 3          No deteminated by the OMS, but is OK
# 710  Level 3          No deteminated by the OMS, but is OK
# 711  Level 3 Developing in an inconsisten rate of increase
# 712  Level 3 Developing in an inconsisten rate of increase
# 713  Level 2 Developing in an inconsisten rate of increase
# 714  Level 3 Developing in an inconsisten rate of increase
# 715  Level 1 Developing in an inconsisten rate of increase
# 716  Level 3          No deteminated by the OMS, but is OK
# 717  Level 2          No deteminated by the OMS, but is OK
# 718  Level 3 Developing in an inconsisten rate of increase
# 719  Level 3 Developing in an inconsisten rate of increase
# 720  Level 3          No deteminated by the OMS, but is OK
# 721  Level 3          No deteminated by the OMS, but is OK
# 722  Level 3          No deteminated by the OMS, but is OK
# 723  Level 2          No deteminated by the OMS, but is OK
# 724  Level 2          No deteminated by the OMS, but is OK
# 725  Level 1 Developing in an inconsisten rate of increase
# 726  Level 1 Developing in an inconsisten rate of increase
# 727  Level 3 Developing in an inconsisten rate of increase
# 728  Level 1 Developing in an inconsisten rate of increase
# 729  Level 1 Developing in an inconsisten rate of increase
# 730  Level 3          No deteminated by the OMS, but is OK
# 731  Level 3          No deteminated by the OMS, but is OK
# 732  Level 3 Developing in an inconsisten rate of increase
# 733  Level 2 Developing in an inconsisten rate of increase
# 734  Level 1          No deteminated by the OMS, but is OK
# 735  Level 3          No deteminated by the OMS, but is OK
# 736  Level 2          No deteminated by the OMS, but is OK
# 737  Level 2          No deteminated by the OMS, but is OK
# 738  Level 1          No deteminated by the OMS, but is OK
# 739  Level 3 Developing in an inconsisten rate of increase
# 740  Level 3 Developing in an inconsisten rate of increase
# 741  Level 2 Developing in an inconsisten rate of increase
# 742  Level 2 Developing in an inconsisten rate of increase
# 743  Level 2 Developing in an inconsisten rate of increase
# 744  Level 3          No deteminated by the OMS, but is OK
# 745  Level 2          No deteminated by the OMS, but is OK
# 746  Level 2 Developing in an inconsisten rate of increase
# 747  Level 1 Developing in an inconsisten rate of increase
# 748  Level 3          No deteminated by the OMS, but is OK
# 749  Level 3          No deteminated by the OMS, but is OK
# 750  Level 3          No deteminated by the OMS, but is OK
# 751  Level 1          No deteminated by the OMS, but is OK
# 752  Level 3          No deteminated by the OMS, but is OK
# 753  Level 3 Developing in an inconsisten rate of increase
# 754  Level 1 Developing in an inconsisten rate of increase
# 755  Level 1 Developing in an inconsisten rate of increase
# 756  Level 3 Developing in an inconsisten rate of increase
# 757  Level 2 Developing in an inconsisten rate of increase
# 758  Level 1          No deteminated by the OMS, but is OK
# 759  Level 2          No deteminated by the OMS, but is OK
# 760  Level 1 Developing in an inconsisten rate of increase
# 761  Level 3          No deteminated by the OMS, but is OK
# 762  Level 2 Developing in an inconsisten rate of increase
# 763  Level 2 Developing in an inconsisten rate of increase
# 764  Level 2          No deteminated by the OMS, but is OK
# 765  Level 3 Developing in an inconsisten rate of increase
# 766  Level 2          No deteminated by the OMS, but is OK
# 767  Level 3 Developing in an inconsisten rate of increase
# 768  Level 3 Developing in an inconsisten rate of increase
# 769  Level 2 Developing in an inconsisten rate of increase
# 770  Level 1          No deteminated by the OMS, but is OK
# 771  Level 1          No deteminated by the OMS, but is OK
# 772  Level 3 Developing in an inconsisten rate of increase
# 773  Level 3 Developing in an inconsisten rate of increase
# 774  Level 1          No deteminated by the OMS, but is OK
# 775  Level 1          No deteminated by the OMS, but is OK
# 776  Level 2          No deteminated by the OMS, but is OK
# 777  Level 3          No deteminated by the OMS, but is OK
# 778  Level 1          No deteminated by the OMS, but is OK
# 779  Level 1 Developing in an inconsisten rate of increase
# 780  Level 2 Developing in an inconsisten rate of increase
# 781  Level 2 Developing in an inconsisten rate of increase
# 782  Level 2 Developing in an inconsisten rate of increase
# 783  Level 1 Developing in an inconsisten rate of increase
# 784  Level 2 Developing in an inconsisten rate of increase
# 785  Level 1 Developing in an inconsisten rate of increase
# 786  Level 2          No deteminated by the OMS, but is OK
# 787  Level 2          No deteminated by the OMS, but is OK
# 788  Level 2 Developing in an inconsisten rate of increase
# 789  Level 2 Developing in an inconsisten rate of increase
# 790  Level 2          No deteminated by the OMS, but is OK
# 791  Level 2          No deteminated by the OMS, but is OK
# 792  Level 1          No deteminated by the OMS, but is OK
# 793  Level 3          No deteminated by the OMS, but is OK
# 794  Level 1          No deteminated by the OMS, but is OK
# 795  Level 2 Developing in an inconsisten rate of increase
# 796  Level 3 Developing in an inconsisten rate of increase
# 797  Level 3 Developing in an inconsisten rate of increase
# 798  Level 2 Developing in an inconsisten rate of increase
# 799  Level 2 Developing in an inconsisten rate of increase
# 800  Level 3          No deteminated by the OMS, but is OK
# 801  Level 2          No deteminated by the OMS, but is OK
# 802  Level 1 Developing in an inconsisten rate of increase
# 803  Level 1 Developing in an inconsisten rate of increase
# 804  Level 1          No deteminated by the OMS, but is OK
# 805  Level 3          No deteminated by the OMS, but is OK
# 806  Level 1          No deteminated by the OMS, but is OK
# 807  Level 1          No deteminated by the OMS, but is OK
# 808  Level 2          No deteminated by the OMS, but is OK
# 809  Level 2 Developing in an inconsisten rate of increase
# 810  Level 1 Developing in an inconsisten rate of increase
# 811  Level 3 Developing in an inconsisten rate of increase
# 812  Level 1 Developing in an inconsisten rate of increase
# 813  Level 2 Developing in an inconsisten rate of increase
# 814  Level 2          No deteminated by the OMS, but is OK
# 815  Level 2          No deteminated by the OMS, but is OK
# 816  Level 1 Developing in an inconsisten rate of increase
# 817  Level 1 Developing in an inconsisten rate of increase
# 818  Level 2          No deteminated by the OMS, but is OK
# 819  Level 1          No deteminated by the OMS, but is OK
# 820  Level 2          No deteminated by the OMS, but is OK
# 821  Level 3          No deteminated by the OMS, but is OK
# 822  Level 2          No deteminated by the OMS, but is OK
# 823  Level 2 Developing in an inconsisten rate of increase
# 824  Level 2 Developing in an inconsisten rate of increase
# 825  Level 1 Developing in an inconsisten rate of increase
# 826  Level 3 Developing in an inconsisten rate of increase
# 827  Level 3 Developing in an inconsisten rate of increase
# 828  Level 2          No deteminated by the OMS, but is OK
# 829  Level 2          No deteminated by the OMS, but is OK
# 830  Level 2 Developing in an inconsisten rate of increase
# 831  Level 1 Developing in an inconsisten rate of increase
# 832  Level 2          No deteminated by the OMS, but is OK
# 833  Level 1          No deteminated by the OMS, but is OK
# 834  Level 2          No deteminated by the OMS, but is OK
# 835  Level 1          No deteminated by the OMS, but is OK
# 836  Level 2          No deteminated by the OMS, but is OK
# 837  Level 2 Developing in an inconsisten rate of increase
# 838  Level 1 Developing in an inconsisten rate of increase
# 839  Level 1 Developing in an inconsisten rate of increase
# 840  Level 2 Developing in an inconsisten rate of increase
# 841  Level 1 Developing in an inconsisten rate of increase
# 842  Level 3          No deteminated by the OMS, but is OK
# 843  Level 3          No deteminated by the OMS, but is OK
# 844  Level 3 Developing in an inconsisten rate of increase
# 845  Level 3          No deteminated by the OMS, but is OK
# 846  Level 3 Developing in an inconsisten rate of increase
# 847  Level 3 Developing in an inconsisten rate of increase
# 848  Level 1          No deteminated by the OMS, but is OK
# 849  Level 1 Developing in an inconsisten rate of increase
# 850  Level 1          No deteminated by the OMS, but is OK
# 851  Level 1 Developing in an inconsisten rate of increase
# 852  Level 3 Developing in an inconsisten rate of increase
# 853  Level 1 Developing in an inconsisten rate of increase
# 854  Level 3          No deteminated by the OMS, but is OK
# 855  Level 2          No deteminated by the OMS, but is OK
# 856  Level 3 Developing in an inconsisten rate of increase
# 857  Level 3 Developing in an inconsisten rate of increase
# 858  Level 1          No deteminated by the OMS, but is OK
# 859  Level 3          No deteminated by the OMS, but is OK
# 860  Level 1          No deteminated by the OMS, but is OK
# 861  Level 3          No deteminated by the OMS, but is OK
# 862  Level 2          No deteminated by the OMS, but is OK
# 863  Level 2 Developing in an inconsisten rate of increase
# 864  Level 2 Developing in an inconsisten rate of increase
# 865  Level 1 Developing in an inconsisten rate of increase
# 866  Level 2 Developing in an inconsisten rate of increase
# 867  Level 1 Developing in an inconsisten rate of increase
# 868  Level 3 Developing in an inconsisten rate of increase
# 869  Level 2 Developing in an inconsisten rate of increase
# 870  Level 2          No deteminated by the OMS, but is OK
# 871  Level 1          No deteminated by the OMS, but is OK
# 872  Level 3 Developing in an inconsisten rate of increase
# 873  Level 3 Developing in an inconsisten rate of increase
# 874  Level 1          No deteminated by the OMS, but is OK
# 875  Level 2          No deteminated by the OMS, but is OK
# 876  Level 2          No deteminated by the OMS, but is OK
# 877  Level 3          No deteminated by the OMS, but is OK
# 878  Level 2          No deteminated by the OMS, but is OK
# 879  Level 3 Developing in an inconsisten rate of increase
# 880  Level 3 Developing in an inconsisten rate of increase
# 881  Level 3 Developing in an inconsisten rate of increase
# 882  Level 3 Developing in an inconsisten rate of increase
# 883  Level 2 Developing in an inconsisten rate of increase
# 884  Level 2          No deteminated by the OMS, but is OK
# 885  Level 2          No deteminated by the OMS, but is OK
# 886  Level 3 Developing in an inconsisten rate of increase
# 887  Level 3 Developing in an inconsisten rate of increase
# 888  Level 3          No deteminated by the OMS, but is OK
# 889  Level 3          No deteminated by the OMS, but is OK
# 890  Level 3          No deteminated by the OMS, but is OK
# 891  Level 3          No deteminated by the OMS, but is OK
# 892  Level 2          No deteminated by the OMS, but is OK
# 893  Level 2 Developing in an inconsisten rate of increase
# 894  Level 3 Developing in an inconsisten rate of increase
# 895  Level 3 Developing in an inconsisten rate of increase
# 896  Level 2 Developing in an inconsisten rate of increase
# 897  Level 2 Developing in an inconsisten rate of increase
# 898  Level 1          No deteminated by the OMS, but is OK
# 899  Level 1          No deteminated by the OMS, but is OK
# 900  Level 3 Developing in an inconsisten rate of increase
# 901  Level 3 Developing in an inconsisten rate of increase
# 902  Level 1          No deteminated by the OMS, but is OK
# 903  Level 1          No deteminated by the OMS, but is OK
# 904  Level 1          No deteminated by the OMS, but is OK
# 905  Level 3          No deteminated by the OMS, but is OK
# 906  Level 3          No deteminated by the OMS, but is OK
# 907  Level 2 Developing in an inconsisten rate of increase
# 908  Level 3 Developing in an inconsisten rate of increase
# 909  Level 1 Developing in an inconsisten rate of increase
# 910  Level 2 Developing in an inconsisten rate of increase
# 911  Level 1 Developing in an inconsisten rate of increase
# 912  Level 2          No deteminated by the OMS, but is OK
# 913  Level 1          No deteminated by the OMS, but is OK
# 914  Level 3 Developing in an inconsisten rate of increase
# 915  Level 3 Developing in an inconsisten rate of increase
# 916  Level 3          No deteminated by the OMS, but is OK
# 917  Level 1          No deteminated by the OMS, but is OK
# 918  Level 3          No deteminated by the OMS, but is OK
# 919  Level 2          No deteminated by the OMS, but is OK
# 920  Level 1          No deteminated by the OMS, but is OK
# 921  Level 1 Developing in an inconsisten rate of increase
# 922  Level 3 Developing in an inconsisten rate of increase
# 923  Level 1 Developing in an inconsisten rate of increase
# 924  Level 2 Developing in an inconsisten rate of increase
# 925  Level 3 Developing in an inconsisten rate of increase
# 926  Level 2          No deteminated by the OMS, but is OK
# 927  Level 3          No deteminated by the OMS, but is OK
# 928  Level 1 Developing in an inconsisten rate of increase
# 929  Level 2          No deteminated by the OMS, but is OK
# 930  Level 2 Developing in an inconsisten rate of increase
# 931  Level 1 Developing in an inconsisten rate of increase
# 932  Level 1          No deteminated by the OMS, but is OK
# 933  Level 2 Developing in an inconsisten rate of increase
# 934  Level 3          No deteminated by the OMS, but is OK
# 935  Level 1 Developing in an inconsisten rate of increase
# 936  Level 1 Developing in an inconsisten rate of increase
# 937  Level 1 Developing in an inconsisten rate of increase
# 938  Level 2          No deteminated by the OMS, but is OK
# 939  Level 3          No deteminated by the OMS, but is OK
# 940  Level 3 Developing in an inconsisten rate of increase
# 941  Level 2 Developing in an inconsisten rate of increase
# 942  Level 2          No deteminated by the OMS, but is OK
# 943  Level 3          No deteminated by the OMS, but is OK
# 944  Level 1          No deteminated by the OMS, but is OK
# 945  Level 2          No deteminated by the OMS, but is OK
# 946  Level 1          No deteminated by the OMS, but is OK
# 947  Level 2 Developing in an inconsisten rate of increase
# 948  Level 1 Developing in an inconsisten rate of increase
# 949  Level 3 Developing in an inconsisten rate of increase
# 950  Level 1 Developing in an inconsisten rate of increase
# 951  Level 1 Developing in an inconsisten rate of increase
# 952  Level 2 Developing in an inconsisten rate of increase
# 953  Level 1 Developing in an inconsisten rate of increase
# 954  Level 1          No deteminated by the OMS, but is OK
# 955  Level 1          No deteminated by the OMS, but is OK
# 956  Level 1 Developing in an inconsisten rate of increase
# 957  Level 1 Developing in an inconsisten rate of increase
# 958  Level 1          No deteminated by the OMS, but is OK
# 959  Level 1          No deteminated by the OMS, but is OK
# 960  Level 2          No deteminated by the OMS, but is OK
# 961  Level 2          No deteminated by the OMS, but is OK
# 962  Level 3          No deteminated by the OMS, but is OK
# 963  Level 1 Developing in an inconsisten rate of increase
# 964  Level 1 Developing in an inconsisten rate of increase
# 965  Level 1 Developing in an inconsisten rate of increase
# 966  Level 2 Developing in an inconsisten rate of increase
# 967  Level 2 Developing in an inconsisten rate of increase
# 968  Level 2          No deteminated by the OMS, but is OK
# 969  Level 2          No deteminated by the OMS, but is OK
# 970  Level 3 Developing in an inconsisten rate of increase
# 971  Level 2 Developing in an inconsisten rate of increase
# 972  Level 3          No deteminated by the OMS, but is OK
# 973  Level 1          No deteminated by the OMS, but is OK
# 974  Level 2          No deteminated by the OMS, but is OK
# 975  Level 2          No deteminated by the OMS, but is OK
# 976  Level 1          No deteminated by the OMS, but is OK
# 977  Level 2 Developing in an inconsisten rate of increase
# 978  Level 3 Developing in an inconsisten rate of increase
# 979  Level 2 Developing in an inconsisten rate of increase
# 980  Level 3 Developing in an inconsisten rate of increase
# 981  Level 1 Developing in an inconsisten rate of increase
# 982  Level 3          No deteminated by the OMS, but is OK
# 983  Level 1          No deteminated by the OMS, but is OK
# 984  Level 3 Developing in an inconsisten rate of increase
# 985  Level 1 Developing in an inconsisten rate of increase
# 986  Level 3          No deteminated by the OMS, but is OK
# 987  Level 3          No deteminated by the OMS, but is OK
# 988  Level 3          No deteminated by the OMS, but is OK
# 989  Level 1          No deteminated by the OMS, but is OK
# 990  Level 2          No deteminated by the OMS, but is OK
# 991  Level 2 Developing in an inconsisten rate of increase
# 992  Level 2 Developing in an inconsisten rate of increase
# 993  Level 3 Developing in an inconsisten rate of increase
# 994  Level 2 Developing in an inconsisten rate of increase
# 995  Level 1 Developing in an inconsisten rate of increase
# 996  Level 1          No deteminated by the OMS, but is OK
# 997  Level 2          No deteminated by the OMS, but is OK
# 998  Level 2 Developing in an inconsisten rate of increase
# 999  Level 2 Developing in an inconsisten rate of increase
# 1000 Level 3          No deteminated by the OMS, but is OK
# 1001 Level 2          No deteminated by the OMS, but is OK
# 1002 Level 2          No deteminated by the OMS, but is OK
# 1003 Level 3          No deteminated by the OMS, but is OK
# 1004 Level 3          No deteminated by the OMS, but is OK
# 1005 Level 3 Developing in an inconsisten rate of increase
# 1006 Level 1 Developing in an inconsisten rate of increase
# 1007 Level 2 Developing in an inconsisten rate of increase
# 1008 Level 3 Developing in an inconsisten rate of increase
# 1009 Level 2 Developing in an inconsisten rate of increase
# 1010 Level 3          No deteminated by the OMS, but is OK
# 1011 Level 3          No deteminated by the OMS, but is OK
# 1012 Level 3 Developing in an inconsisten rate of increase
# 1013 Level 1          No deteminated by the OMS, but is OK
# 1014 Level 1 Developing in an inconsisten rate of increase
# 1015 Level 2 Developing in an inconsisten rate of increase
# 1016 Level 3          No deteminated by the OMS, but is OK
# 1017 Level 2 Developing in an inconsisten rate of increase
# 1018 Level 1          No deteminated by the OMS, but is OK
# 1019 Level 1 Developing in an inconsisten rate of increase
# 1020 Level 1 Developing in an inconsisten rate of increase
# 1021 Level 1 Developing in an inconsisten rate of increase
# 1022 Level 2          No deteminated by the OMS, but is OK
# 1023 Level 3          No deteminated by the OMS, but is OK
# 1024 Level 1 Developing in an inconsisten rate of increase
# 1025 Level 2 Developing in an inconsisten rate of increase
# 1026 Level 1          No deteminated by the OMS, but is OK
# 1027 Level 2          No deteminated by the OMS, but is OK
# 1028 Level 3          No deteminated by the OMS, but is OK
# 1029 Level 3          No deteminated by the OMS, but is OK
# 1030 Level 1          No deteminated by the OMS, but is OK
# 1031 Level 1 Developing in an inconsisten rate of increase
# 1032 Level 1 Developing in an inconsisten rate of increase
# 1033 Level 2 Developing in an inconsisten rate of increase
# 1034 Level 2 Developing in an inconsisten rate of increase
# 1035 Level 1 Developing in an inconsisten rate of increase
# 1036 Level 3 Developing in an inconsisten rate of increase
# 1037 Level 2 Developing in an inconsisten rate of increase
# 1038 Level 1          No deteminated by the OMS, but is OK
# 1039 Level 1          No deteminated by the OMS, but is OK
# 1040 Level 1 Developing in an inconsisten rate of increase
# 1041 Level 3 Developing in an inconsisten rate of increase
# 1042 Level 3          No deteminated by the OMS, but is OK
# 1043 Level 2          No deteminated by the OMS, but is OK
# 1044 Level 3          No deteminated by the OMS, but is OK
# 1045 Level 2          No deteminated by the OMS, but is OK
# 1046 Level 3          No deteminated by the OMS, but is OK
# 1047 Level 1 Developing in an inconsisten rate of increase
# 1048 Level 1 Developing in an inconsisten rate of increase
# 1049 Level 3 Developing in an inconsisten rate of increase
# 1050 Level 1 Developing in an inconsisten rate of increase
# 1051 Level 1 Developing in an inconsisten rate of increase
# 1052 Level 3          No deteminated by the OMS, but is OK
# 1053 Level 2          No deteminated by the OMS, but is OK
# 1054 Level 2 Developing in an inconsisten rate of increase
# 1055 Level 3 Developing in an inconsisten rate of increase
# 1056 Level 2          No deteminated by the OMS, but is OK
# 1057 Level 3          No deteminated by the OMS, but is OK
# 1058 Level 2          No deteminated by the OMS, but is OK
# 1059 Level 2          No deteminated by the OMS, but is OK
# 1060 Level 3          No deteminated by the OMS, but is OK
# 1061 Level 3 Developing in an inconsisten rate of increase
# 1062 Level 3 Developing in an inconsisten rate of increase
# 1063 Level 3 Developing in an inconsisten rate of increase
# 1064 Level 1 Developing in an inconsisten rate of increase
# 1065 Level 3 Developing in an inconsisten rate of increase
# 1066 Level 1          No deteminated by the OMS, but is OK
# 1067 Level 3          No deteminated by the OMS, but is OK
# 1068 Level 1 Developing in an inconsisten rate of increase
# 1069 Level 3 Developing in an inconsisten rate of increase
# 1070 Level 2          No deteminated by the OMS, but is OK
# 1071 Level 3          No deteminated by the OMS, but is OK
# 1072 Level 2          No deteminated by the OMS, but is OK
# 1073 Level 3          No deteminated by the OMS, but is OK
# 1074 Level 2          No deteminated by the OMS, but is OK
# 1075 Level 3 Developing in an inconsisten rate of increase
# 1076 Level 3 Developing in an inconsisten rate of increase
# 1077 Level 3 Developing in an inconsisten rate of increase
# 1078 Level 3 Developing in an inconsisten rate of increase
# 1079 Level 3 Developing in an inconsisten rate of increase
# 1080 Level 1          No deteminated by the OMS, but is OK
# 1081 Level 1          No deteminated by the OMS, but is OK
# 1082 Level 1 Developing in an inconsisten rate of increase
# 1083 Level 1 Developing in an inconsisten rate of increase
# 1084 Level 3          No deteminated by the OMS, but is OK
# 1085 Level 1          No deteminated by the OMS, but is OK
# 1086 Level 1          No deteminated by the OMS, but is OK
# 1087 Level 1          No deteminated by the OMS, but is OK
# 1088 Level 3          No deteminated by the OMS, but is OK
# 1089 Level 2 Developing in an inconsisten rate of increase
# 1090 Level 3 Developing in an inconsisten rate of increase
# 1091 Level 1 Developing in an inconsisten rate of increase
# 1092 Level 3 Developing in an inconsisten rate of increase
# 1093 Level 1 Developing in an inconsisten rate of increase
# 1094 Level 1          No deteminated by the OMS, but is OK
# 1095 Level 2          No deteminated by the OMS, but is OK
# 1096 Level 1 Developing in an inconsisten rate of increase
# 1097 Level 1          No deteminated by the OMS, but is OK
# 1098 Level 2 Developing in an inconsisten rate of increase
# 1099 Level 2 Developing in an inconsisten rate of increase
# 1100 Level 1          No deteminated by the OMS, but is OK
# 1101 Level 1 Developing in an inconsisten rate of increase
# 1102 Level 2          No deteminated by the OMS, but is OK
# 1103 Level 2 Developing in an inconsisten rate of increase
# 1104 Level 1 Developing in an inconsisten rate of increase
# 1105 Level 1 Developing in an inconsisten rate of increase
# 1106 Level 2          No deteminated by the OMS, but is OK
# 1107 Level 2          No deteminated by the OMS, but is OK
# 1108 Level 2 Developing in an inconsisten rate of increase
# 1109 Level 1 Developing in an inconsisten rate of increase
# 1110 Level 3          No deteminated by the OMS, but is OK
# 1111 Level 3          No deteminated by the OMS, but is OK
# 1112 Level 1          No deteminated by the OMS, but is OK
# 1113 Level 3          No deteminated by the OMS, but is OK
# 1114 Level 2          No deteminated by the OMS, but is OK
# 1115 Level 2 Developing in an inconsisten rate of increase
# 1116 Level 1 Developing in an inconsisten rate of increase
# 1117 Level 3 Developing in an inconsisten rate of increase
# 1118 Level 1 Developing in an inconsisten rate of increase
# 1119 Level 1 Developing in an inconsisten rate of increase
# 1120 Level 1 Developing in an inconsisten rate of increase
# 1121 Level 1 Developing in an inconsisten rate of increase
# 1122 Level 3          No deteminated by the OMS, but is OK
# 1123 Level 3          No deteminated by the OMS, but is OK
# 1124 Level 2 Developing in an inconsisten rate of increase
# 1125 Level 1 Developing in an inconsisten rate of increase
# 1126 Level 3          No deteminated by the OMS, but is OK
# 1127 Level 1          No deteminated by the OMS, but is OK
# 1128 Level 2          No deteminated by the OMS, but is OK
# 1129 Level 3          No deteminated by the OMS, but is OK
# 1130 Level 2          No deteminated by the OMS, but is OK
# 1131 Level 3 Developing in an inconsisten rate of increase
# 1132 Level 2 Developing in an inconsisten rate of increase
# 1133 Level 1 Developing in an inconsisten rate of increase
# 1134 Level 1 Developing in an inconsisten rate of increase
# 1135 Level 1 Developing in an inconsisten rate of increase
# 1136 Level 2          No deteminated by the OMS, but is OK
# 1137 Level 2          No deteminated by the OMS, but is OK
# 1138 Level 2 Developing in an inconsisten rate of increase
# 1139 Level 3 Developing in an inconsisten rate of increase
# 1140 Level 2          No deteminated by the OMS, but is OK
# 1141 Level 1          No deteminated by the OMS, but is OK
# 1142 Level 2          No deteminated by the OMS, but is OK
# 1143 Level 3          No deteminated by the OMS, but is OK
# 1144 Level 3          No deteminated by the OMS, but is OK
# 1145 Level 3 Developing in an inconsisten rate of increase
# 1146 Level 2 Developing in an inconsisten rate of increase
# 1147 Level 1 Developing in an inconsisten rate of increase
# 1148 Level 1 Developing in an inconsisten rate of increase
# 1149 Level 3 Developing in an inconsisten rate of increase
# 1150 Level 2          No deteminated by the OMS, but is OK
# 1151 Level 2          No deteminated by the OMS, but is OK
# 1152 Level 2 Developing in an inconsisten rate of increase
# 1153 Level 3 Developing in an inconsisten rate of increase
# 1154 Level 3          No deteminated by the OMS, but is OK
# 1155 Level 3          No deteminated by the OMS, but is OK
# 1156 Level 1          No deteminated by the OMS, but is OK
# 1157 Level 3          No deteminated by the OMS, but is OK
# 1158 Level 3          No deteminated by the OMS, but is OK
# 1159 Level 2 Developing in an inconsisten rate of increase
# 1160 Level 1 Developing in an inconsisten rate of increase
# 1161 Level 1 Developing in an inconsisten rate of increase
# 1162 Level 1 Developing in an inconsisten rate of increase
# 1163 Level 3 Developing in an inconsisten rate of increase
# 1164 Level 1          No deteminated by the OMS, but is OK
# 1165 Level 2          No deteminated by the OMS, but is OK
# 1166 Level 1 Developing in an inconsisten rate of increase
# 1167 Level 2 Developing in an inconsisten rate of increase
# 1168 Level 2          No deteminated by the OMS, but is OK
# 1169 Level 1          No deteminated by the OMS, but is OK
# 1170 Level 3          No deteminated by the OMS, but is OK
# 1171 Level 2          No deteminated by the OMS, but is OK
# 1172 Level 2          No deteminated by the OMS, but is OK
# 1173 Level 2 Developing in an inconsisten rate of increase
# 1174 Level 2 Developing in an inconsisten rate of increase
# 1175 Level 1 Developing in an inconsisten rate of increase
# 1176 Level 2 Developing in an inconsisten rate of increase
# 1177 Level 3 Developing in an inconsisten rate of increase
# 1178 Level 2          No deteminated by the OMS, but is OK
# 1179 Level 1          No deteminated by the OMS, but is OK
# 1180 Level 2 Developing in an inconsisten rate of increase
# 1181 Level 3          No deteminated by the OMS, but is OK
# 1182 Level 3 Developing in an inconsisten rate of increase
# 1183 Level 1 Developing in an inconsisten rate of increase
# 1184 Level 3          No deteminated by the OMS, but is OK
# 1185 Level 2 Developing in an inconsisten rate of increase
# 1186 Level 3          No deteminated by the OMS, but is OK
# 1187 Level 1 Developing in an inconsisten rate of increase
# 1188 Level 1 Developing in an inconsisten rate of increase
# 1189 Level 2 Developing in an inconsisten rate of increase
# 1190 Level 3          No deteminated by the OMS, but is OK
# 1191 Level 2          No deteminated by the OMS, but is OK
# 1192 Level 1 Developing in an inconsisten rate of increase
# 1193 Level 1 Developing in an inconsisten rate of increase
# 1194 Level 2          No deteminated by the OMS, but is OK
# 1195 Level 1          No deteminated by the OMS, but is OK
# 1196 Level 1          No deteminated by the OMS, but is OK
# 1197 Level 3          No deteminated by the OMS, but is OK
# 1198 Level 1          No deteminated by the OMS, but is OK
# 1199 Level 3 Developing in an inconsisten rate of increase
# 1200 Level 1 Developing in an inconsisten rate of increase
# 1201 Level 3 Developing in an inconsisten rate of increase
# 1202 Level 1 Developing in an inconsisten rate of increase
# 1203 Level 3 Developing in an inconsisten rate of increase
# 1204 Level 2 Developing in an inconsisten rate of increase
# 1205 Level 3 Developing in an inconsisten rate of increase
# 1206 Level 3          No deteminated by the OMS, but is OK
# 1207 Level 3          No deteminated by the OMS, but is OK
# 1208 Level 3 Developing in an inconsisten rate of increase
# 1209 Level 1 Developing in an inconsisten rate of increase
# 1210 Level 1          No deteminated by the OMS, but is OK
# 1211 Level 2          No deteminated by the OMS, but is OK
# 1212 Level 3          No deteminated by the OMS, but is OK
# 1213 Level 2          No deteminated by the OMS, but is OK
# 1214 Level 3          No deteminated by the OMS, but is OK
# 1215 Level 2 Developing in an inconsisten rate of increase
# 1216 Level 1 Developing in an inconsisten rate of increase
# 1217 Level 1 Developing in an inconsisten rate of increase
# 1218 Level 2 Developing in an inconsisten rate of increase
# 1219 Level 1 Developing in an inconsisten rate of increase
# 1220 Level 1          No deteminated by the OMS, but is OK
# 1221 Level 1          No deteminated by the OMS, but is OK
# 1222 Level 2 Developing in an inconsisten rate of increase
# 1223 Level 3 Developing in an inconsisten rate of increase
# 1224 Level 3          No deteminated by the OMS, but is OK
# 1225 Level 3          No deteminated by the OMS, but is OK
# 1226 Level 1          No deteminated by the OMS, but is OK
# 1227 Level 2          No deteminated by the OMS, but is OK
# 1228 Level 1          No deteminated by the OMS, but is OK
# 1229 Level 2 Developing in an inconsisten rate of increase
# 1230 Level 1 Developing in an inconsisten rate of increase
# 1231 Level 2 Developing in an inconsisten rate of increase
# 1232 Level 3 Developing in an inconsisten rate of increase
# 1233 Level 3 Developing in an inconsisten rate of increase
# 1234 Level 3          No deteminated by the OMS, but is OK
# 1235 Level 1          No deteminated by the OMS, but is OK
# 1236 Level 3 Developing in an inconsisten rate of increase
# 1237 Level 2 Developing in an inconsisten rate of increase
# 1238 Level 1          No deteminated by the OMS, but is OK
# 1239 Level 3          No deteminated by the OMS, but is OK
# 1240 Level 1          No deteminated by the OMS, but is OK
# 1241 Level 3          No deteminated by the OMS, but is OK
# 1242 Level 1          No deteminated by the OMS, but is OK
# 1243 Level 2 Developing in an inconsisten rate of increase
# 1244 Level 1 Developing in an inconsisten rate of increase
# 1245 Level 3 Developing in an inconsisten rate of increase
# 1246 Level 3 Developing in an inconsisten rate of increase
# 1247 Level 3 Developing in an inconsisten rate of increase
# 1248 Level 3          No deteminated by the OMS, but is OK
# 1249 Level 2          No deteminated by the OMS, but is OK
# 1250 Level 1 Developing in an inconsisten rate of increase
# 1251 Level 3 Developing in an inconsisten rate of increase
# 1252 Level 1          No deteminated by the OMS, but is OK
# 1253 Level 1          No deteminated by the OMS, but is OK
# 1254 Level 1          No deteminated by the OMS, but is OK
# 1255 Level 1          No deteminated by the OMS, but is OK
# 1256 Level 1          No deteminated by the OMS, but is OK
# 1257 Level 1 Developing in an inconsisten rate of increase
# 1258 Level 1 Developing in an inconsisten rate of increase
# 1259 Level 3 Developing in an inconsisten rate of increase
# 1260 Level 1 Developing in an inconsisten rate of increase
# 1261 Level 3 Developing in an inconsisten rate of increase
# 1262 Level 3          No deteminated by the OMS, but is OK
# 1263 Level 1          No deteminated by the OMS, but is OK
# 1264 Level 2 Developing in an inconsisten rate of increase
# 1265 Level 3          No deteminated by the OMS, but is OK
# 1266 Level 1 Developing in an inconsisten rate of increase
# 1267 Level 2 Developing in an inconsisten rate of increase
# 1268 Level 2          No deteminated by the OMS, but is OK
# 1269 Level 3 Developing in an inconsisten rate of increase
# 1270 Level 2          No deteminated by the OMS, but is OK
# 1271 Level 3 Developing in an inconsisten rate of increase
# 1272 Level 1 Developing in an inconsisten rate of increase
# 1273 Level 3 Developing in an inconsisten rate of increase
# 1274 Level 3          No deteminated by the OMS, but is OK
# 1275 Level 2          No deteminated by the OMS, but is OK
# 1276 Level 3 Developing in an inconsisten rate of increase
# 1277 Level 1 Developing in an inconsisten rate of increase
# 1278 Level 1          No deteminated by the OMS, but is OK
# 1279 Level 1          No deteminated by the OMS, but is OK
# 1280 Level 1          No deteminated by the OMS, but is OK
# 1281 Level 3          No deteminated by the OMS, but is OK
# 1282 Level 2          No deteminated by the OMS, but is OK
# 1283 Level 1 Developing in an inconsisten rate of increase
# 1284 Level 1 Developing in an inconsisten rate of increase
# 1285 Level 3 Developing in an inconsisten rate of increase
# 1286 Level 1 Developing in an inconsisten rate of increase
# 1287 Level 3 Developing in an inconsisten rate of increase
# 1288 Level 1 Developing in an inconsisten rate of increase
# 1289 Level 1 Developing in an inconsisten rate of increase
# 1290 Level 3          No deteminated by the OMS, but is OK
# 1291 Level 1          No deteminated by the OMS, but is OK
# 1292 Level 3 Developing in an inconsisten rate of increase
# 1293 Level 3 Developing in an inconsisten rate of increase
# 1294 Level 3          No deteminated by the OMS, but is OK
# 1295 Level 1          No deteminated by the OMS, but is OK
# 1296 Level 3          No deteminated by the OMS, but is OK
# 1297 Level 2          No deteminated by the OMS, but is OK
# 1298 Level 1          No deteminated by the OMS, but is OK
# 1299 Level 3 Developing in an inconsisten rate of increase
# 1300 Level 3 Developing in an inconsisten rate of increase
# 1301 Level 2 Developing in an inconsisten rate of increase
# 1302 Level 2 Developing in an inconsisten rate of increase
# 1303 Level 3 Developing in an inconsisten rate of increase
# 1304 Level 1          No deteminated by the OMS, but is OK
# 1305 Level 3          No deteminated by the OMS, but is OK
# 1306 Level 2 Developing in an inconsisten rate of increase
# 1307 Level 1 Developing in an inconsisten rate of increase
# 1308 Level 1          No deteminated by the OMS, but is OK
# 1309 Level 2          No deteminated by the OMS, but is OK
# 1310 Level 1          No deteminated by the OMS, but is OK
# 1311 Level 3          No deteminated by the OMS, but is OK
# 1312 Level 2          No deteminated by the OMS, but is OK
# 1313 Level 3 Developing in an inconsisten rate of increase
# 1314 Level 2 Developing in an inconsisten rate of increase
# 1315 Level 1 Developing in an inconsisten rate of increase
# 1316 Level 1 Developing in an inconsisten rate of increase
# 1317 Level 3 Developing in an inconsisten rate of increase
# 1318 Level 3          No deteminated by the OMS, but is OK
# 1319 Level 2          No deteminated by the OMS, but is OK
# 1320 Level 1 Developing in an inconsisten rate of increase
# 1321 Level 2 Developing in an inconsisten rate of increase
# 1322 Level 1          No deteminated by the OMS, but is OK
# 1323 Level 1          No deteminated by the OMS, but is OK
# 1324 Level 3          No deteminated by the OMS, but is OK
# 1325 Level 3          No deteminated by the OMS, but is OK
# 1326 Level 3          No deteminated by the OMS, but is OK
# 1327 Level 1 Developing in an inconsisten rate of increase
# 1328 Level 2 Developing in an inconsisten rate of increase
# 1329 Level 2 Developing in an inconsisten rate of increase
# 1330 Level 2 Developing in an inconsisten rate of increase
# 1331 Level 1 Developing in an inconsisten rate of increase
# 1332 Level 2          No deteminated by the OMS, but is OK
# 1333 Level 2          No deteminated by the OMS, but is OK
# 1334 Level 3 Developing in an inconsisten rate of increase
# 1335 Level 1 Developing in an inconsisten rate of increase
# 1336 Level 1          No deteminated by the OMS, but is OK
# 1337 Level 3          No deteminated by the OMS, but is OK
# 1338 Level 2          No deteminated by the OMS, but is OK
# 1339 Level 3          No deteminated by the OMS, but is OK
# 1340 Level 3          No deteminated by the OMS, but is OK
# 1341 Level 1 Developing in an inconsisten rate of increase
# 1342 Level 3 Developing in an inconsisten rate of increase
# 1343 Level 2 Developing in an inconsisten rate of increase
# 1344 Level 2 Developing in an inconsisten rate of increase
# 1345 Level 2 Developing in an inconsisten rate of increase
# 1346 Level 1          No deteminated by the OMS, but is OK
# 1347 Level 2          No deteminated by the OMS, but is OK
# 1348 Level 2 Developing in an inconsisten rate of increase
# 1349 Level 1          No deteminated by the OMS, but is OK
# 1350 Level 1 Developing in an inconsisten rate of increase
# 1351 Level 2 Developing in an inconsisten rate of increase
# 1352 Level 3          No deteminated by the OMS, but is OK
# 1353 Level 3 Developing in an inconsisten rate of increase
# 1354 Level 2          No deteminated by the OMS, but is OK
# 1355 Level 3 Developing in an inconsisten rate of increase
# 1356 Level 3 Developing in an inconsisten rate of increase
# 1357 Level 2 Developing in an inconsisten rate of increase
# 1358 Level 2          No deteminated by the OMS, but is OK
# 1359 Level 3          No deteminated by the OMS, but is OK
# 1360 Level 3 Developing in an inconsisten rate of increase
# 1361 Level 1 Developing in an inconsisten rate of increase
# 1362 Level 1          No deteminated by the OMS, but is OK
# 1363 Level 1          No deteminated by the OMS, but is OK
# 1364 Level 2          No deteminated by the OMS, but is OK
# 1365 Level 1          No deteminated by the OMS, but is OK
# 1366 Level 2          No deteminated by the OMS, but is OK
# 1367 Level 2 Developing in an inconsisten rate of increase
# 1368 Level 2 Developing in an inconsisten rate of increase
# 1369 Level 3 Developing in an inconsisten rate of increase
# 1370 Level 1 Developing in an inconsisten rate of increase
# 1371 Level 1 Developing in an inconsisten rate of increase
# 1372 Level 2 Developing in an inconsisten rate of increase
# 1373 Level 2 Developing in an inconsisten rate of increase
# 1374 Level 2          No deteminated by the OMS, but is OK
# 1375 Level 1          No deteminated by the OMS, but is OK
# 1376 Level 1 Developing in an inconsisten rate of increase
# 1377 Level 1 Developing in an inconsisten rate of increase
# 1378 Level 3          No deteminated by the OMS, but is OK
# 1379 Level 2          No deteminated by the OMS, but is OK
# 1380 Level 1          No deteminated by the OMS, but is OK
# 1381 Level 1          No deteminated by the OMS, but is OK
# 1382 Level 3          No deteminated by the OMS, but is OK
# 1383 Level 1 Developing in an inconsisten rate of increase
# 1384 Level 1 Developing in an inconsisten rate of increase
# 1385 Level 3 Developing in an inconsisten rate of increase
# 1386 Level 3 Developing in an inconsisten rate of increase
# 1387 Level 1 Developing in an inconsisten rate of increase
# 1388 Level 1          No deteminated by the OMS, but is OK
# 1389 Level 1          No deteminated by the OMS, but is OK
# 1390 Level 3 Developing in an inconsisten rate of increase
# 1391 Level 2 Developing in an inconsisten rate of increase
# 1392 Level 1          No deteminated by the OMS, but is OK
# 1393 Level 2          No deteminated by the OMS, but is OK
# 1394 Level 1          No deteminated by the OMS, but is OK
# 1395 Level 1          No deteminated by the OMS, but is OK
# 1396 Level 3          No deteminated by the OMS, but is OK
# 1397 Level 3 Developing in an inconsisten rate of increase
# 1398 Level 3 Developing in an inconsisten rate of increase
# 1399 Level 1 Developing in an inconsisten rate of increase
# 1400 Level 2 Developing in an inconsisten rate of increase
# 1401 Level 1 Developing in an inconsisten rate of increase
# 1402 Level 1          No deteminated by the OMS, but is OK
# 1403 Level 1          No deteminated by the OMS, but is OK
# 1404 Level 3 Developing in an inconsisten rate of increase
# 1405 Level 3 Developing in an inconsisten rate of increase
# 1406 Level 2          No deteminated by the OMS, but is OK
# 1407 Level 3          No deteminated by the OMS, but is OK
# 1408 Level 2          No deteminated by the OMS, but is OK
# 1409 Level 1          No deteminated by the OMS, but is OK
# 1410 Level 3          No deteminated by the OMS, but is OK
# 1411 Level 1 Developing in an inconsisten rate of increase
# 1412 Level 1 Developing in an inconsisten rate of increase
# 1413 Level 1 Developing in an inconsisten rate of increase
# 1414 Level 2 Developing in an inconsisten rate of increase
# 1415 Level 2 Developing in an inconsisten rate of increase
# 1416 Level 2          No deteminated by the OMS, but is OK
# 1417 Level 1          No deteminated by the OMS, but is OK
# 1418 Level 1 Developing in an inconsisten rate of increase
# 1419 Level 1 Developing in an inconsisten rate of increase
# 1420 Level 1          No deteminated by the OMS, but is OK
# 1421 Level 1          No deteminated by the OMS, but is OK
# 1422 Level 1          No deteminated by the OMS, but is OK
# 1423 Level 2          No deteminated by the OMS, but is OK
# 1424 Level 1          No deteminated by the OMS, but is OK
# 1425 Level 1 Developing in an inconsisten rate of increase
# 1426 Level 3 Developing in an inconsisten rate of increase
# 1427 Level 2 Developing in an inconsisten rate of increase
# 1428 Level 3 Developing in an inconsisten rate of increase
# 1429 Level 1 Developing in an inconsisten rate of increase
# 1430 Level 3          No deteminated by the OMS, but is OK
# 1431 Level 1          No deteminated by the OMS, but is OK
# 1432 Level 3 Developing in an inconsisten rate of increase
# 1433 Level 1          No deteminated by the OMS, but is OK
# 1434 Level 3 Developing in an inconsisten rate of increase
# 1435 Level 2 Developing in an inconsisten rate of increase
# 1436 Level 1          No deteminated by the OMS, but is OK
# 1437 Level 2 Developing in an inconsisten rate of increase
# 1438 Level 3          No deteminated by the OMS, but is OK
# 1439 Level 2 Developing in an inconsisten rate of increase
# 1440 Level 1 Developing in an inconsisten rate of increase
# 1441 Level 3 Developing in an inconsisten rate of increase
# 1442 Level 3          No deteminated by the OMS, but is OK
# 1443 Level 2          No deteminated by the OMS, but is OK
# 1444 Level 3 Developing in an inconsisten rate of increase
# 1445 Level 1 Developing in an inconsisten rate of increase
# 1446 Level 3          No deteminated by the OMS, but is OK
# 1447 Level 2          No deteminated by the OMS, but is OK
# 1448 Level 2          No deteminated by the OMS, but is OK
# 1449 Level 1          No deteminated by the OMS, but is OK
# 1450 Level 1          No deteminated by the OMS, but is OK
# 1451 Level 3 Developing in an inconsisten rate of increase
# 1452 Level 1 Developing in an inconsisten rate of increase
# 1453 Level 3 Developing in an inconsisten rate of increase
# 1454 Level 2 Developing in an inconsisten rate of increase
# 1455 Level 2 Developing in an inconsisten rate of increase
# 1456 Level 3 Developing in an inconsisten rate of increase
# 1457 Level 3 Developing in an inconsisten rate of increase
# 1458 Level 2          No deteminated by the OMS, but is OK
# 1459 Level 3          No deteminated by the OMS, but is OK
# 1460 Level 1 Developing in an inconsisten rate of increase
# 1461 Level 2 Developing in an inconsisten rate of increase
# 1462 Level 2          No deteminated by the OMS, but is OK
# 1463 Level 2          No deteminated by the OMS, but is OK
# 1464 Level 1          No deteminated by the OMS, but is OK
# 1465 Level 3          No deteminated by the OMS, but is OK
# 1466 Level 2          No deteminated by the OMS, but is OK
# 1467 Level 1 Developing in an inconsisten rate of increase
# 1468 Level 3 Developing in an inconsisten rate of increase
# 1469 Level 3 Developing in an inconsisten rate of increase
# 1470 Level 1 Developing in an inconsisten rate of increase
# 1471 Level 2 Developing in an inconsisten rate of increase
# 1472 Level 3          No deteminated by the OMS, but is OK
# 1473 Level 3          No deteminated by the OMS, but is OK
# 1474 Level 2 Developing in an inconsisten rate of increase
# 1475 Level 3 Developing in an inconsisten rate of increase
# 1476 Level 3          No deteminated by the OMS, but is OK
# 1477 Level 3          No deteminated by the OMS, but is OK
# 1478 Level 1          No deteminated by the OMS, but is OK
# 1479 Level 3          No deteminated by the OMS, but is OK
# 1480 Level 2          No deteminated by the OMS, but is OK
# 1481 Level 1 Developing in an inconsisten rate of increase
# 1482 Level 3 Developing in an inconsisten rate of increase
# 1483 Level 2 Developing in an inconsisten rate of increase
# 1484 Level 2 Developing in an inconsisten rate of increase
# 1485 Level 1 Developing in an inconsisten rate of increase
# 1486 Level 2          No deteminated by the OMS, but is OK
# 1487 Level 3          No deteminated by the OMS, but is OK
# 1488 Level 3 Developing in an inconsisten rate of increase
# 1489 Level 3 Developing in an inconsisten rate of increase
# 1490 Level 2          No deteminated by the OMS, but is OK
# 1491 Level 2          No deteminated by the OMS, but is OK
# 1492 Level 3          No deteminated by the OMS, but is OK
# 1493 Level 2          No deteminated by the OMS, but is OK
# 1494 Level 1          No deteminated by the OMS, but is OK
# 1495 Level 2 Developing in an inconsisten rate of increase
# 1496 Level 2 Developing in an inconsisten rate of increase
# 1497 Level 1 Developing in an inconsisten rate of increase
# 1498 Level 2 Developing in an inconsisten rate of increase
# 1499 Level 1 Developing in an inconsisten rate of increase
# 1500 Level 2          No deteminated by the OMS, but is OK
# 1501 Level 1          No deteminated by the OMS, but is OK
# 1502 Level 3 Developing in an inconsisten rate of increase
# 1503 Level 2 Developing in an inconsisten rate of increase
# 1504 Level 1          No deteminated by the OMS, but is OK
# 1505 Level 3          No deteminated by the OMS, but is OK
# 1506 Level 2          No deteminated by the OMS, but is OK
# 1507 Level 3          No deteminated by the OMS, but is OK
# 1508 Level 3          No deteminated by the OMS, but is OK
# 1509 Level 3 Developing in an inconsisten rate of increase
# 1510 Level 2 Developing in an inconsisten rate of increase
# 1511 Level 3 Developing in an inconsisten rate of increase
# 1512 Level 2 Developing in an inconsisten rate of increase
# 1513 Level 3 Developing in an inconsisten rate of increase
# 1514 Level 3          No deteminated by the OMS, but is OK
# 1515 Level 2          No deteminated by the OMS, but is OK
# 1516 Level 2 Developing in an inconsisten rate of increase
# 1517 Level 2          No deteminated by the OMS, but is OK
# 1518 Level 2 Developing in an inconsisten rate of increase
# 1519 Level 2 Developing in an inconsisten rate of increase
# 1520 Level 1          No deteminated by the OMS, but is OK
# 1521 Level 1 Developing in an inconsisten rate of increase
# 1522 Level 2          No deteminated by the OMS, but is OK
# 1523 Level 3 Developing in an inconsisten rate of increase
# 1524 Level 3 Developing in an inconsisten rate of increase
# 1525 Level 3 Developing in an inconsisten rate of increase
# 1526 Level 3          No deteminated by the OMS, but is OK
# 1527 Level 3          No deteminated by the OMS, but is OK
# 1528 Level 3 Developing in an inconsisten rate of increase
# 1529 Level 3 Developing in an inconsisten rate of increase
# 1530 Level 3          No deteminated by the OMS, but is OK
# 1531 Level 2          No deteminated by the OMS, but is OK
# 1532 Level 3          No deteminated by the OMS, but is OK
# 1533 Level 1          No deteminated by the OMS, but is OK
# 1534 Level 1          No deteminated by the OMS, but is OK
# 1535 Level 3 Developing in an inconsisten rate of increase
# 1536 Level 2 Developing in an inconsisten rate of increase
# 1537 Level 1 Developing in an inconsisten rate of increase
# 1538 Level 2 Developing in an inconsisten rate of increase
# 1539 Level 1 Developing in an inconsisten rate of increase
# 1540 Level 1 Developing in an inconsisten rate of increase
# 1541 Level 3 Developing in an inconsisten rate of increase
# 1542 Level 3          No deteminated by the OMS, but is OK
# 1543 Level 3          No deteminated by the OMS, but is OK
# 1544 Level 1 Developing in an inconsisten rate of increase
# 1545 Level 3 Developing in an inconsisten rate of increase
# 1546 Level 1          No deteminated by the OMS, but is OK
# 1547 Level 2          No deteminated by the OMS, but is OK
# 1548 Level 3          No deteminated by the OMS, but is OK
# 1549 Level 3          No deteminated by the OMS, but is OK
# 1550 Level 2          No deteminated by the OMS, but is OK
# 1551 Level 2 Developing in an inconsisten rate of increase
# 1552 Level 2 Developing in an inconsisten rate of increase
# 1553 Level 2 Developing in an inconsisten rate of increase
# 1554 Level 3 Developing in an inconsisten rate of increase
# 1555 Level 2 Developing in an inconsisten rate of increase
# 1556 Level 1          No deteminated by the OMS, but is OK
# 1557 Level 2          No deteminated by the OMS, but is OK
# 1558 Level 1 Developing in an inconsisten rate of increase
# 1559 Level 2 Developing in an inconsisten rate of increase
# 1560 Level 2          No deteminated by the OMS, but is OK
# 1561 Level 3          No deteminated by the OMS, but is OK
# 1562 Level 3          No deteminated by the OMS, but is OK
# 1563 Level 1          No deteminated by the OMS, but is OK
# 1564 Level 3          No deteminated by the OMS, but is OK
# 1565 Level 1 Developing in an inconsisten rate of increase
# 1566 Level 1 Developing in an inconsisten rate of increase
# 1567 Level 3 Developing in an inconsisten rate of increase
# 1568 Level 3 Developing in an inconsisten rate of increase
# 1569 Level 2 Developing in an inconsisten rate of increase
# 1570 Level 3          No deteminated by the OMS, but is OK
# 1571 Level 2          No deteminated by the OMS, but is OK
# 1572 Level 3 Developing in an inconsisten rate of increase
# 1573 Level 3 Developing in an inconsisten rate of increase
# 1574 Level 3          No deteminated by the OMS, but is OK
# 1575 Level 1          No deteminated by the OMS, but is OK
# 1576 Level 3          No deteminated by the OMS, but is OK
# 1577 Level 1          No deteminated by the OMS, but is OK
# 1578 Level 2          No deteminated by the OMS, but is OK
# 1579 Level 3 Developing in an inconsisten rate of increase
# 1580 Level 2 Developing in an inconsisten rate of increase
# 1581 Level 3 Developing in an inconsisten rate of increase
# 1582 Level 1 Developing in an inconsisten rate of increase
# 1583 Level 1 Developing in an inconsisten rate of increase
# 1584 Level 3          No deteminated by the OMS, but is OK
# 1585 Level 2          No deteminated by the OMS, but is OK
# 1586 Level 3 Developing in an inconsisten rate of increase
# 1587 Level 1 Developing in an inconsisten rate of increase
# 1588 Level 2          No deteminated by the OMS, but is OK
# 1589 Level 3          No deteminated by the OMS, but is OK
# 1590 Level 3          No deteminated by the OMS, but is OK
# 1591 Level 1          No deteminated by the OMS, but is OK
# 1592 Level 2          No deteminated by the OMS, but is OK
# 1593 Level 1 Developing in an inconsisten rate of increase
# 1594 Level 3 Developing in an inconsisten rate of increase
# 1595 Level 1 Developing in an inconsisten rate of increase
# 1596 Level 1 Developing in an inconsisten rate of increase
# 1597 Level 3 Developing in an inconsisten rate of increase
# 1598 Level 1          No deteminated by the OMS, but is OK
# 1599 Level 3          No deteminated by the OMS, but is OK
# 1600 Level 1 Developing in an inconsisten rate of increase
# 1601 Level 2          No deteminated by the OMS, but is OK
# 1602 Level 1 Developing in an inconsisten rate of increase
# 1603 Level 2 Developing in an inconsisten rate of increase
# 1604 Level 3          No deteminated by the OMS, but is OK
# 1605 Level 1 Developing in an inconsisten rate of increase
# 1606 Level 2          No deteminated by the OMS, but is OK
# 1607 Level 3 Developing in an inconsisten rate of increase
# 1608 Level 3 Developing in an inconsisten rate of increase
# 1609 Level 2 Developing in an inconsisten rate of increase
# 1610 Level 1          No deteminated by the OMS, but is OK
# 1611 Level 1          No deteminated by the OMS, but is OK
# 1612 Level 2 Developing in an inconsisten rate of increase
# 1613 Level 1 Developing in an inconsisten rate of increase
# 1614 Level 2          No deteminated by the OMS, but is OK
# 1615 Level 3          No deteminated by the OMS, but is OK
# 1616 Level 3          No deteminated by the OMS, but is OK
# 1617 Level 3          No deteminated by the OMS, but is OK
# 1618 Level 1          No deteminated by the OMS, but is OK
# 1619 Level 1 Developing in an inconsisten rate of increase
# 1620 Level 1 Developing in an inconsisten rate of increase
# 1621 Level 3 Developing in an inconsisten rate of increase
# 1622 Level 3 Developing in an inconsisten rate of increase
# 1623 Level 2 Developing in an inconsisten rate of increase
# 1624 Level 2 Developing in an inconsisten rate of increase
# 1625 Level 2 Developing in an inconsisten rate of increase
# 1626 Level 3          No deteminated by the OMS, but is OK
# 1627 Level 2          No deteminated by the OMS, but is OK
# 1628 Level 3 Developing in an inconsisten rate of increase
# 1629 Level 3 Developing in an inconsisten rate of increase
# 1630 Level 3          No deteminated by the OMS, but is OK
# 1631 Level 1          No deteminated by the OMS, but is OK
# 1632 Level 1          No deteminated by the OMS, but is OK
# 1633 Level 3          No deteminated by the OMS, but is OK
# 1634 Level 1          No deteminated by the OMS, but is OK
# 1635 Level 2 Developing in an inconsisten rate of increase
# 1636 Level 1 Developing in an inconsisten rate of increase
# 1637 Level 2 Developing in an inconsisten rate of increase
# 1638 Level 2 Developing in an inconsisten rate of increase
# 1639 Level 2 Developing in an inconsisten rate of increase
# 1640 Level 2          No deteminated by the OMS, but is OK
# 1641 Level 3          No deteminated by the OMS, but is OK
# 1642 Level 1 Developing in an inconsisten rate of increase
# 1643 Level 2 Developing in an inconsisten rate of increase
# 1644 Level 3          No deteminated by the OMS, but is OK
# 1645 Level 1          No deteminated by the OMS, but is OK
# 1646 Level 1          No deteminated by the OMS, but is OK
# 1647 Level 2          No deteminated by the OMS, but is OK
# 1648 Level 3          No deteminated by the OMS, but is OK
# 1649 Level 3 Developing in an inconsisten rate of increase
# 1650 Level 3 Developing in an inconsisten rate of increase
# 1651 Level 3 Developing in an inconsisten rate of increase
# 1652 Level 1 Developing in an inconsisten rate of increase
# 1653 Level 1 Developing in an inconsisten rate of increase
# 1654 Level 3          No deteminated by the OMS, but is OK
# 1655 Level 2          No deteminated by the OMS, but is OK
# 1656 Level 1 Developing in an inconsisten rate of increase
# 1657 Level 3 Developing in an inconsisten rate of increase
# 1658 Level 3          No deteminated by the OMS, but is OK
# 1659 Level 2          No deteminated by the OMS, but is OK
# 1660 Level 1          No deteminated by the OMS, but is OK
# 1661 Level 2          No deteminated by the OMS, but is OK
# 1662 Level 3          No deteminated by the OMS, but is OK
# 1663 Level 3 Developing in an inconsisten rate of increase
# 1664 Level 3 Developing in an inconsisten rate of increase
# 1665 Level 3 Developing in an inconsisten rate of increase
# 1666 Level 2 Developing in an inconsisten rate of increase
# 1667 Level 1 Developing in an inconsisten rate of increase
# 1668 Level 2          No deteminated by the OMS, but is OK
# 1669 Level 2          No deteminated by the OMS, but is OK
# 1670 Level 3 Developing in an inconsisten rate of increase
# 1671 Level 1 Developing in an inconsisten rate of increase
# 1672 Level 2          No deteminated by the OMS, but is OK
# 1673 Level 3          No deteminated by the OMS, but is OK
# 1674 Level 2          No deteminated by the OMS, but is OK
# 1675 Level 1          No deteminated by the OMS, but is OK
# 1676 Level 1          No deteminated by the OMS, but is OK
# 1677 Level 1 Developing in an inconsisten rate of increase
# 1678 Level 1 Developing in an inconsisten rate of increase
# 1679 Level 2 Developing in an inconsisten rate of increase
# 1680 Level 2 Developing in an inconsisten rate of increase
# 1681 Level 2 Developing in an inconsisten rate of increase
# 1682 Level 2          No deteminated by the OMS, but is OK
# 1683 Level 1          No deteminated by the OMS, but is OK
# 1684 Level 1 Developing in an inconsisten rate of increase
# 1685 Level 1          No deteminated by the OMS, but is OK
# 1686 Level 3 Developing in an inconsisten rate of increase
# 1687 Level 1 Developing in an inconsisten rate of increase
# 1688 Level 2          No deteminated by the OMS, but is OK
# 1689 Level 2 Developing in an inconsisten rate of increase
# 1690 Level 3          No deteminated by the OMS, but is OK
# 1691 Level 3 Developing in an inconsisten rate of increase
# 1692 Level 1 Developing in an inconsisten rate of increase
# 1693 Level 2 Developing in an inconsisten rate of increase
# 1694 Level 1          No deteminated by the OMS, but is OK
# 1695 Level 2          No deteminated by the OMS, but is OK
# 1696 Level 2 Developing in an inconsisten rate of increase
# 1697 Level 1 Developing in an inconsisten rate of increase
# 1698 Level 2          No deteminated by the OMS, but is OK
# 1699 Level 2          No deteminated by the OMS, but is OK
# 1700 Level 2          No deteminated by the OMS, but is OK
# 1701 Level 2          No deteminated by the OMS, but is OK
# 1702 Level 2          No deteminated by the OMS, but is OK
# 1703 Level 1 Developing in an inconsisten rate of increase
# 1704 Level 2 Developing in an inconsisten rate of increase
# 1705 Level 1 Developing in an inconsisten rate of increase
# 1706 Level 2 Developing in an inconsisten rate of increase
# 1707 Level 2 Developing in an inconsisten rate of increase
# 1708 Level 1 Developing in an inconsisten rate of increase
# 1709 Level 2 Developing in an inconsisten rate of increase
# 1710 Level 2          No deteminated by the OMS, but is OK
# 1711 Level 1          No deteminated by the OMS, but is OK
# 1712 Level 2 Developing in an inconsisten rate of increase
# 1713 Level 2 Developing in an inconsisten rate of increase
# 1714 Level 3          No deteminated by the OMS, but is OK
# 1715 Level 3          No deteminated by the OMS, but is OK
# 1716 Level 3          No deteminated by the OMS, but is OK
# 1717 Level 1          No deteminated by the OMS, but is OK
# 1718 Level 2          No deteminated by the OMS, but is OK
# 1719 Level 3 Developing in an inconsisten rate of increase
# 1720 Level 1 Developing in an inconsisten rate of increase
# 1721 Level 1 Developing in an inconsisten rate of increase
# 1722 Level 2 Developing in an inconsisten rate of increase
# 1723 Level 2 Developing in an inconsisten rate of increase
# 1724 Level 2          No deteminated by the OMS, but is OK
# 1725 Level 2          No deteminated by the OMS, but is OK
# 1726 Level 2 Developing in an inconsisten rate of increase
# 1727 Level 1 Developing in an inconsisten rate of increase
# 1728 Level 1          No deteminated by the OMS, but is OK
# 1729 Level 3          No deteminated by the OMS, but is OK
# 1730 Level 3          No deteminated by the OMS, but is OK
# 1731 Level 2          No deteminated by the OMS, but is OK
# 1732 Level 2          No deteminated by the OMS, but is OK
# 1733 Level 2 Developing in an inconsisten rate of increase
# 1734 Level 2 Developing in an inconsisten rate of increase
# 1735 Level 1 Developing in an inconsisten rate of increase
# 1736 Level 3 Developing in an inconsisten rate of increase
# 1737 Level 3 Developing in an inconsisten rate of increase
# 1738 Level 3          No deteminated by the OMS, but is OK
# 1739 Level 1          No deteminated by the OMS, but is OK
# 1740 Level 2 Developing in an inconsisten rate of increase
# 1741 Level 2 Developing in an inconsisten rate of increase
# 1742 Level 1          No deteminated by the OMS, but is OK
# 1743 Level 3          No deteminated by the OMS, but is OK
# 1744 Level 3          No deteminated by the OMS, but is OK
# 1745 Level 3          No deteminated by the OMS, but is OK
# 1746 Level 2          No deteminated by the OMS, but is OK
# 1747 Level 2 Developing in an inconsisten rate of increase
# 1748 Level 2 Developing in an inconsisten rate of increase
# 1749 Level 3 Developing in an inconsisten rate of increase
# 1750 Level 3 Developing in an inconsisten rate of increase
# 1751 Level 3 Developing in an inconsisten rate of increase
# 1752 Level 2          No deteminated by the OMS, but is OK
# 1753 Level 3          No deteminated by the OMS, but is OK
# 1754 Level 2 Developing in an inconsisten rate of increase
# 1755 Level 3 Developing in an inconsisten rate of increase
# 1756 Level 2          No deteminated by the OMS, but is OK
# 1757 Level 1          No deteminated by the OMS, but is OK
# 1758 Level 2          No deteminated by the OMS, but is OK
# 1759 Level 2          No deteminated by the OMS, but is OK
# 1760 Level 1          No deteminated by the OMS, but is OK
# 1761 Level 2 Developing in an inconsisten rate of increase
# 1762 Level 2 Developing in an inconsisten rate of increase
# 1763 Level 2 Developing in an inconsisten rate of increase
# 1764 Level 2 Developing in an inconsisten rate of increase
# 1765 Level 2 Developing in an inconsisten rate of increase
# 1766 Level 2          No deteminated by the OMS, but is OK
# 1767 Level 1          No deteminated by the OMS, but is OK
# 1768 Level 3 Developing in an inconsisten rate of increase
# 1769 Level 1          No deteminated by the OMS, but is OK
# 1770 Level 3 Developing in an inconsisten rate of increase
# 1771 Level 2 Developing in an inconsisten rate of increase
# 1772 Level 2          No deteminated by the OMS, but is OK
# 1773 Level 3 Developing in an inconsisten rate of increase
# 1774 Level 3          No deteminated by the OMS, but is OK
# 1775 Level 1 Developing in an inconsisten rate of increase
# 1776 Level 3 Developing in an inconsisten rate of increase
# 1777 Level 3 Developing in an inconsisten rate of increase
# 1778 Level 2          No deteminated by the OMS, but is OK
# 1779 Level 2          No deteminated by the OMS, but is OK
# 1780 Level 2 Developing in an inconsisten rate of increase
# 1781 Level 1 Developing in an inconsisten rate of increase
# 1782 Level 1          No deteminated by the OMS, but is OK
# 1783 Level 3          No deteminated by the OMS, but is OK
# 1784 Level 3          No deteminated by the OMS, but is OK
# 1785 Level 1          No deteminated by the OMS, but is OK
# 1786 Level 3          No deteminated by the OMS, but is OK
# 1787 Level 1 Developing in an inconsisten rate of increase
# 1788 Level 2 Developing in an inconsisten rate of increase
# 1789 Level 3 Developing in an inconsisten rate of increase
# 1790 Level 2 Developing in an inconsisten rate of increase
# 1791 Level 2 Developing in an inconsisten rate of increase
# 1792 Level 1 Developing in an inconsisten rate of increase
# 1793 Level 2 Developing in an inconsisten rate of increase
# 1794 Level 2          No deteminated by the OMS, but is OK
# 1795 Level 2          No deteminated by the OMS, but is OK
# 1796 Level 2 Developing in an inconsisten rate of increase
# 1797 Level 3 Developing in an inconsisten rate of increase
# 1798 Level 1          No deteminated by the OMS, but is OK
# 1799 Level 2          No deteminated by the OMS, but is OK
# 1800 Level 2          No deteminated by the OMS, but is OK
# 1801 Level 2          No deteminated by the OMS, but is OK
# 1802 Level 1          No deteminated by the OMS, but is OK
# 1803 Level 3 Developing in an inconsisten rate of increase
# 1804 Level 1 Developing in an inconsisten rate of increase
# 1805 Level 3 Developing in an inconsisten rate of increase
# 1806 Level 2 Developing in an inconsisten rate of increase
# 1807 Level 2 Developing in an inconsisten rate of increase
# 1808 Level 3          No deteminated by the OMS, but is OK
# 1809 Level 3          No deteminated by the OMS, but is OK
# 1810 Level 1 Developing in an inconsisten rate of increase
# 1811 Level 3 Developing in an inconsisten rate of increase
# 1812 Level 3          No deteminated by the OMS, but is OK
# 1813 Level 2          No deteminated by the OMS, but is OK
# 1814 Level 2          No deteminated by the OMS, but is OK
# 1815 Level 1          No deteminated by the OMS, but is OK
# 1816 Level 3          No deteminated by the OMS, but is OK
# 1817 Level 3 Developing in an inconsisten rate of increase
# 1818 Level 1 Developing in an inconsisten rate of increase
# 1819 Level 3 Developing in an inconsisten rate of increase
# 1820 Level 1 Developing in an inconsisten rate of increase
# 1821 Level 1 Developing in an inconsisten rate of increase
# 1822 Level 1          No deteminated by the OMS, but is OK
# 1823 Level 1          No deteminated by the OMS, but is OK
# 1824 Level 3 Developing in an inconsisten rate of increase
# 1825 Level 2 Developing in an inconsisten rate of increase
# 1826 Level 1          No deteminated by the OMS, but is OK
# 1827 Level 3          No deteminated by the OMS, but is OK
# 1828 Level 3          No deteminated by the OMS, but is OK
# 1829 Level 2          No deteminated by the OMS, but is OK
# 1830 Level 1          No deteminated by the OMS, but is OK
# 1831 Level 1 Developing in an inconsisten rate of increase
# 1832 Level 2 Developing in an inconsisten rate of increase
# 1833 Level 3 Developing in an inconsisten rate of increase
# 1834 Level 2 Developing in an inconsisten rate of increase
# 1835 Level 1 Developing in an inconsisten rate of increase
# 1836 Level 3          No deteminated by the OMS, but is OK
# 1837 Level 2          No deteminated by the OMS, but is OK
# 1838 Level 3 Developing in an inconsisten rate of increase
# 1839 Level 3 Developing in an inconsisten rate of increase
# 1840 Level 2          No deteminated by the OMS, but is OK
# 1841 Level 3          No deteminated by the OMS, but is OK
# 1842 Level 2          No deteminated by the OMS, but is OK
# 1843 Level 1          No deteminated by the OMS, but is OK
# 1844 Level 1          No deteminated by the OMS, but is OK
# 1845 Level 3 Developing in an inconsisten rate of increase
# 1846 Level 1 Developing in an inconsisten rate of increase
# 1847 Level 2 Developing in an inconsisten rate of increase
# 1848 Level 3 Developing in an inconsisten rate of increase
# 1849 Level 3 Developing in an inconsisten rate of increase
# 1850 Level 3          No deteminated by the OMS, but is OK
# 1851 Level 3          No deteminated by the OMS, but is OK
# 1852 Level 1 Developing in an inconsisten rate of increase
# 1853 Level 3          No deteminated by the OMS, but is OK
# 1854 Level 1 Developing in an inconsisten rate of increase
# 1855 Level 1 Developing in an inconsisten rate of increase
# 1856 Level 1          No deteminated by the OMS, but is OK
# 1857 Level 1 Developing in an inconsisten rate of increase
# 1858 Level 1          No deteminated by the OMS, but is OK
# 1859 Level 2 Developing in an inconsisten rate of increase
# 1860 Level 3 Developing in an inconsisten rate of increase
# 1861 Level 3 Developing in an inconsisten rate of increase
# 1862 Level 2          No deteminated by the OMS, but is OK
# 1863 Level 2          No deteminated by the OMS, but is OK
# 1864 Level 3 Developing in an inconsisten rate of increase
# 1865 Level 2 Developing in an inconsisten rate of increase
# 1866 Level 3          No deteminated by the OMS, but is OK
# 1867 Level 3          No deteminated by the OMS, but is OK
# 1868 Level 2          No deteminated by the OMS, but is OK
# 1869 Level 2          No deteminated by the OMS, but is OK
# 1870 Level 1          No deteminated by the OMS, but is OK
# 1871 Level 3 Developing in an inconsisten rate of increase
# 1872 Level 2 Developing in an inconsisten rate of increase
# 1873 Level 3 Developing in an inconsisten rate of increase
# 1874 Level 2 Developing in an inconsisten rate of increase
# 1875 Level 3 Developing in an inconsisten rate of increase
# 1876 Level 3 Developing in an inconsisten rate of increase
# 1877 Level 1 Developing in an inconsisten rate of increase
# 1878 Level 1          No deteminated by the OMS, but is OK
# 1879 Level 1          No deteminated by the OMS, but is OK
# 1880 Level 1 Developing in an inconsisten rate of increase
# 1881 Level 1 Developing in an inconsisten rate of increase
# 1882 Level 3          No deteminated by the OMS, but is OK
# 1883 Level 1          No deteminated by the OMS, but is OK
# 1884 Level 2          No deteminated by the OMS, but is OK
# 1885 Level 1          No deteminated by the OMS, but is OK
# 1886 Level 3          No deteminated by the OMS, but is OK
# 1887 Level 2 Developing in an inconsisten rate of increase
# 1888 Level 1 Developing in an inconsisten rate of increase
# 1889 Level 3 Developing in an inconsisten rate of increase
# 1890 Level 1 Developing in an inconsisten rate of increase
# 1891 Level 3 Developing in an inconsisten rate of increase
# 1892 Level 2          No deteminated by the OMS, but is OK
# 1893 Level 3          No deteminated by the OMS, but is OK
# 1894 Level 1 Developing in an inconsisten rate of increase
# 1895 Level 2 Developing in an inconsisten rate of increase
# 1896 Level 2          No deteminated by the OMS, but is OK
# 1897 Level 3          No deteminated by the OMS, but is OK
# 1898 Level 2          No deteminated by the OMS, but is OK
# 1899 Level 1          No deteminated by the OMS, but is OK
# 1900 Level 3          No deteminated by the OMS, but is OK
# 1901 Level 2 Developing in an inconsisten rate of increase
# 1902 Level 1 Developing in an inconsisten rate of increase
# 1903 Level 1 Developing in an inconsisten rate of increase
# 1904 Level 2 Developing in an inconsisten rate of increase
# 1905 Level 3 Developing in an inconsisten rate of increase
# 1906 Level 3          No deteminated by the OMS, but is OK
# 1907 Level 2          No deteminated by the OMS, but is OK
# 1908 Level 1 Developing in an inconsisten rate of increase
# 1909 Level 2 Developing in an inconsisten rate of increase
# 1910 Level 3          No deteminated by the OMS, but is OK
# 1911 Level 3          No deteminated by the OMS, but is OK
# 1912 Level 1          No deteminated by the OMS, but is OK
# 1913 Level 1          No deteminated by the OMS, but is OK
# 1914 Level 2          No deteminated by the OMS, but is OK
# 1915 Level 2 Developing in an inconsisten rate of increase
# 1916 Level 3 Developing in an inconsisten rate of increase
# 1917 Level 3 Developing in an inconsisten rate of increase
# 1918 Level 2 Developing in an inconsisten rate of increase
# 1919 Level 3 Developing in an inconsisten rate of increase
# 1920 Level 3          No deteminated by the OMS, but is OK
# 1921 Level 1          No deteminated by the OMS, but is OK
# 1922 Level 1 Developing in an inconsisten rate of increase
# 1923 Level 2 Developing in an inconsisten rate of increase
# 1924 Level 2          No deteminated by the OMS, but is OK
# 1925 Level 1          No deteminated by the OMS, but is OK
# 1926 Level 3          No deteminated by the OMS, but is OK
# 1927 Level 1          No deteminated by the OMS, but is OK
# 1928 Level 3          No deteminated by the OMS, but is OK
# 1929 Level 1 Developing in an inconsisten rate of increase
# 1930 Level 1 Developing in an inconsisten rate of increase
# 1931 Level 3 Developing in an inconsisten rate of increase
# 1932 Level 1 Developing in an inconsisten rate of increase
# 1933 Level 2 Developing in an inconsisten rate of increase
# 1934 Level 1          No deteminated by the OMS, but is OK
# 1935 Level 2          No deteminated by the OMS, but is OK
# 1936 Level 2 Developing in an inconsisten rate of increase
# 1937 Level 3          No deteminated by the OMS, but is OK
# 1938 Level 3 Developing in an inconsisten rate of increase
# 1939 Level 2 Developing in an inconsisten rate of increase
# 1940 Level 1          No deteminated by the OMS, but is OK
# 1941 Level 1 Developing in an inconsisten rate of increase
# 1942 Level 1          No deteminated by the OMS, but is OK
# 1943 Level 1 Developing in an inconsisten rate of increase
# 1944 Level 2 Developing in an inconsisten rate of increase
# 1945 Level 1 Developing in an inconsisten rate of increase
# 1946 Level 2          No deteminated by the OMS, but is OK
# 1947 Level 2          No deteminated by the OMS, but is OK
# 1948 Level 1 Developing in an inconsisten rate of increase
# 1949 Level 1 Developing in an inconsisten rate of increase
# 1950 Level 2          No deteminated by the OMS, but is OK
# 1951 Level 3          No deteminated by the OMS, but is OK
# 1952 Level 3          No deteminated by the OMS, but is OK
# 1953 Level 3          No deteminated by the OMS, but is OK
# 1954 Level 3          No deteminated by the OMS, but is OK
# 1955 Level 3 Developing in an inconsisten rate of increase
# 1956 Level 3 Developing in an inconsisten rate of increase
# 1957 Level 2 Developing in an inconsisten rate of increase
# 1958 Level 3 Developing in an inconsisten rate of increase
# 1959 Level 3 Developing in an inconsisten rate of increase
# 1960 Level 2 Developing in an inconsisten rate of increase
# 1961 Level 3 Developing in an inconsisten rate of increase
# 1962 Level 1          No deteminated by the OMS, but is OK
# 1963 Level 1          No deteminated by the OMS, but is OK
# 1964 Level 2 Developing in an inconsisten rate of increase
# 1965 Level 1 Developing in an inconsisten rate of increase
# 1966 Level 2          No deteminated by the OMS, but is OK
# 1967 Level 3          No deteminated by the OMS, but is OK
# 1968 Level 3          No deteminated by the OMS, but is OK
# 1969 Level 2          No deteminated by the OMS, but is OK
# 1970 Level 3          No deteminated by the OMS, but is OK
# 1971 Level 3 Developing in an inconsisten rate of increase
# 1972 Level 3 Developing in an inconsisten rate of increase
# 1973 Level 1 Developing in an inconsisten rate of increase
# 1974 Level 1 Developing in an inconsisten rate of increase
# 1975 Level 2 Developing in an inconsisten rate of increase
# 1976 Level 1          No deteminated by the OMS, but is OK
# 1977 Level 3          No deteminated by the OMS, but is OK
# 1978 Level 1 Developing in an inconsisten rate of increase
# 1979 Level 1 Developing in an inconsisten rate of increase
# 1980 Level 2          No deteminated by the OMS, but is OK
# 1981 Level 1          No deteminated by the OMS, but is OK
# 1982 Level 3          No deteminated by the OMS, but is OK
# 1983 Level 1          No deteminated by the OMS, but is OK
# 1984 Level 2          No deteminated by the OMS, but is OK
# 1985 Level 3 Developing in an inconsisten rate of increase
# 1986 Level 3 Developing in an inconsisten rate of increase
# 1987 Level 1 Developing in an inconsisten rate of increase
# 1988 Level 2 Developing in an inconsisten rate of increase
# 1989 Level 3 Developing in an inconsisten rate of increase
# 1990 Level 1          No deteminated by the OMS, but is OK
# 1991 Level 2          No deteminated by the OMS, but is OK
# 1992 Level 2 Developing in an inconsisten rate of increase
# 1993 Level 1 Developing in an inconsisten rate of increase
# 1994 Level 2          No deteminated by the OMS, but is OK
# 1995 Level 2          No deteminated by the OMS, but is OK
# 1996 Level 1          No deteminated by the OMS, but is OK
# 1997 Level 2          No deteminated by the OMS, but is OK
# 1998 Level 2          No deteminated by the OMS, but is OK
# 1999 Level 1 Developing in an inconsisten rate of increase
# 2000 Level 2 Developing in an inconsisten rate of increase
# 2001 Level 1 Developing in an inconsisten rate of increase
# 2002 Level 3 Developing in an inconsisten rate of increase
# 2003 Level 2 Developing in an inconsisten rate of increase
# 2004 Level 1          No deteminated by the OMS, but is OK
# 2005 Level 2          No deteminated by the OMS, but is OK
# 2006 Level 3 Developing in an inconsisten rate of increase
# 2007 Level 1 Developing in an inconsisten rate of increase
# 2008 Level 3          No deteminated by the OMS, but is OK
# 2009 Level 2          No deteminated by the OMS, but is OK
# 2010 Level 3          No deteminated by the OMS, but is OK
# 2011 Level 1          No deteminated by the OMS, but is OK
# 2012 Level 3          No deteminated by the OMS, but is OK
# 2013 Level 1 Developing in an inconsisten rate of increase
# 2014 Level 1 Developing in an inconsisten rate of increase
# 2015 Level 2 Developing in an inconsisten rate of increase
# 2016 Level 1 Developing in an inconsisten rate of increase
# 2017 Level 3 Developing in an inconsisten rate of increase
# 2018 Level 2          No deteminated by the OMS, but is OK
# 2019 Level 2          No deteminated by the OMS, but is OK
# 2020 Level 3 Developing in an inconsisten rate of increase
# 2021 Level 2          No deteminated by the OMS, but is OK
# 2022 Level 3 Developing in an inconsisten rate of increase
# 2023 Level 2 Developing in an inconsisten rate of increase
# 2024 Level 3          No deteminated by the OMS, but is OK
# 2025 Level 3 Developing in an inconsisten rate of increase
# 2026 Level 1          No deteminated by the OMS, but is OK
# 2027 Level 1 Developing in an inconsisten rate of increase
# 2028 Level 1 Developing in an inconsisten rate of increase
# 2029 Level 1 Developing in an inconsisten rate of increase
# 2030 Level 3          No deteminated by the OMS, but is OK
# 2031 Level 2          No deteminated by the OMS, but is OK
# 2032 Level 2 Developing in an inconsisten rate of increase
# 2033 Level 3 Developing in an inconsisten rate of increase
# 2034 Level 1          No deteminated by the OMS, but is OK
# 2035 Level 3          No deteminated by the OMS, but is OK
# 2036 Level 1          No deteminated by the OMS, but is OK
# 2037 Level 1          No deteminated by the OMS, but is OK
# 2038 Level 2          No deteminated by the OMS, but is OK
# 2039 Level 1 Developing in an inconsisten rate of increase
# 2040 Level 3 Developing in an inconsisten rate of increase
# 2041 Level 2 Developing in an inconsisten rate of increase
# 2042 Level 3 Developing in an inconsisten rate of increase
# 2043 Level 2 Developing in an inconsisten rate of increase
# 2044 Level 3 Developing in an inconsisten rate of increase
# 2045 Level 3 Developing in an inconsisten rate of increase
# 2046 Level 2          No deteminated by the OMS, but is OK
# 2047 Level 3          No deteminated by the OMS, but is OK
# 2048 Level 3 Developing in an inconsisten rate of increase
# 2049 Level 1 Developing in an inconsisten rate of increase
# 2050 Level 3          No deteminated by the OMS, but is OK
# 2051 Level 2          No deteminated by the OMS, but is OK
# 2052 Level 3          No deteminated by the OMS, but is OK
# 2053 Level 2          No deteminated by the OMS, but is OK
# 2054 Level 1          No deteminated by the OMS, but is OK
# 2055 Level 1 Developing in an inconsisten rate of increase
# 2056 Level 2 Developing in an inconsisten rate of increase
# 2057 Level 3 Developing in an inconsisten rate of increase
# 2058 Level 3 Developing in an inconsisten rate of increase
# 2059 Level 3 Developing in an inconsisten rate of increase
# 2060 Level 2          No deteminated by the OMS, but is OK
# 2061 Level 3          No deteminated by the OMS, but is OK
# 2062 Level 2 Developing in an inconsisten rate of increase
# 2063 Level 2 Developing in an inconsisten rate of increase
# 2064 Level 3          No deteminated by the OMS, but is OK
# 2065 Level 1          No deteminated by the OMS, but is OK
# 2066 Level 1          No deteminated by the OMS, but is OK
# 2067 Level 3          No deteminated by the OMS, but is OK
# 2068 Level 2          No deteminated by the OMS, but is OK
# 2069 Level 2 Developing in an inconsisten rate of increase
# 2070 Level 1 Developing in an inconsisten rate of increase
# 2071 Level 1 Developing in an inconsisten rate of increase
# 2072 Level 1 Developing in an inconsisten rate of increase
# 2073 Level 2 Developing in an inconsisten rate of increase
# 2074 Level 3          No deteminated by the OMS, but is OK
# 2075 Level 3          No deteminated by the OMS, but is OK
# 2076 Level 1 Developing in an inconsisten rate of increase
# 2077 Level 2 Developing in an inconsisten rate of increase
# 2078 Level 3          No deteminated by the OMS, but is OK
# 2079 Level 2          No deteminated by the OMS, but is OK
# 2080 Level 1          No deteminated by the OMS, but is OK
# 2081 Level 1          No deteminated by the OMS, but is OK
# 2082 Level 1          No deteminated by the OMS, but is OK
# 2083 Level 3 Developing in an inconsisten rate of increase
# 2084 Level 2 Developing in an inconsisten rate of increase
# 2085 Level 2 Developing in an inconsisten rate of increase
# 2086 Level 3 Developing in an inconsisten rate of increase
# 2087 Level 2 Developing in an inconsisten rate of increase
# 2088 Level 2          No deteminated by the OMS, but is OK
# 2089 Level 2          No deteminated by the OMS, but is OK
# 2090 Level 3 Developing in an inconsisten rate of increase
# 2091 Level 2 Developing in an inconsisten rate of increase
# 2092 Level 1          No deteminated by the OMS, but is OK
# 2093 Level 3          No deteminated by the OMS, but is OK
# 2094 Level 1          No deteminated by the OMS, but is OK
# 2095 Level 2          No deteminated by the OMS, but is OK
# 2096 Level 2          No deteminated by the OMS, but is OK
# 2097 Level 1 Developing in an inconsisten rate of increase
# 2098 Level 3 Developing in an inconsisten rate of increase
# 2099 Level 1 Developing in an inconsisten rate of increase
# 2100 Level 2 Developing in an inconsisten rate of increase
# 2101 Level 1 Developing in an inconsisten rate of increase
# 2102 Level 2          No deteminated by the OMS, but is OK
# 2103 Level 2          No deteminated by the OMS, but is OK
# 2104 Level 1 Developing in an inconsisten rate of increase
# 2105 Level 2          No deteminated by the OMS, but is OK
# 2106 Level 3 Developing in an inconsisten rate of increase
# 2107 Level 2 Developing in an inconsisten rate of increase
# 2108 Level 3          No deteminated by the OMS, but is OK
# 2109 Level 3 Developing in an inconsisten rate of increase
# 2110 Level 1          No deteminated by the OMS, but is OK
# 2111 Level 3 Developing in an inconsisten rate of increase
# 2112 Level 3 Developing in an inconsisten rate of increase
# 2113 Level 2 Developing in an inconsisten rate of increase
# 2114 Level 1          No deteminated by the OMS, but is OK
# 2115 Level 2          No deteminated by the OMS, but is OK
# 2116 Level 2 Developing in an inconsisten rate of increase
# 2117 Level 1 Developing in an inconsisten rate of increase
# 2118 Level 1          No deteminated by the OMS, but is OK
# 2119 Level 1          No deteminated by the OMS, but is OK
# 2120 Level 1          No deteminated by the OMS, but is OK
# 2121 Level 3          No deteminated by the OMS, but is OK
# 2122 Level 2          No deteminated by the OMS, but is OK
# 2123 Level 2 Developing in an inconsisten rate of increase
# 2124 Level 2 Developing in an inconsisten rate of increase
# 2125 Level 2 Developing in an inconsisten rate of increase
# 2126 Level 1 Developing in an inconsisten rate of increase
# 2127 Level 2 Developing in an inconsisten rate of increase
# 2128 Level 3 Developing in an inconsisten rate of increase
# 2129 Level 2 Developing in an inconsisten rate of increase
# 2130 Level 3          No deteminated by the OMS, but is OK
# 2131 Level 3          No deteminated by the OMS, but is OK
# 2132 Level 2 Developing in an inconsisten rate of increase
# 2133 Level 3 Developing in an inconsisten rate of increase
# 2134 Level 2          No deteminated by the OMS, but is OK
# 2135 Level 3          No deteminated by the OMS, but is OK
# 2136 Level 1          No deteminated by the OMS, but is OK
# 2137 Level 1          No deteminated by the OMS, but is OK
# 2138 Level 3          No deteminated by the OMS, but is OK
# 2139 Level 2 Developing in an inconsisten rate of increase
# 2140 Level 1 Developing in an inconsisten rate of increase
# 2141 Level 3 Developing in an inconsisten rate of increase
# 2142 Level 1 Developing in an inconsisten rate of increase
# 2143 Level 2 Developing in an inconsisten rate of increase
# 2144 Level 3          No deteminated by the OMS, but is OK
# 2145 Level 3          No deteminated by the OMS, but is OK
# 2146 Level 2 Developing in an inconsisten rate of increase
# 2147 Level 3 Developing in an inconsisten rate of increase
# 2148 Level 2          No deteminated by the OMS, but is OK
# 2149 Level 3          No deteminated by the OMS, but is OK
# 2150 Level 2          No deteminated by the OMS, but is OK
# 2151 Level 3          No deteminated by the OMS, but is OK
# 2152 Level 3          No deteminated by the OMS, but is OK
# 2153 Level 3 Developing in an inconsisten rate of increase
# 2154 Level 3 Developing in an inconsisten rate of increase
# 2155 Level 2 Developing in an inconsisten rate of increase
# 2156 Level 1 Developing in an inconsisten rate of increase
# 2157 Level 3 Developing in an inconsisten rate of increase
# 2158 Level 2          No deteminated by the OMS, but is OK
# 2159 Level 1          No deteminated by the OMS, but is OK
# 2160 Level 1 Developing in an inconsisten rate of increase
# 2161 Level 2 Developing in an inconsisten rate of increase
# 2162 Level 1          No deteminated by the OMS, but is OK
# 2163 Level 2          No deteminated by the OMS, but is OK
# 2164 Level 2          No deteminated by the OMS, but is OK
# 2165 Level 2          No deteminated by the OMS, but is OK
# 2166 Level 3          No deteminated by the OMS, but is OK
# 2167 Level 3 Developing in an inconsisten rate of increase
# 2168 Level 3 Developing in an inconsisten rate of increase
# 2169 Level 1 Developing in an inconsisten rate of increase
# 2170 Level 3 Developing in an inconsisten rate of increase
# 2171 Level 3 Developing in an inconsisten rate of increase
# 2172 Level 2          No deteminated by the OMS, but is OK
# 2173 Level 2          No deteminated by the OMS, but is OK
# 2174 Level 2 Developing in an inconsisten rate of increase
# 2175 Level 1 Developing in an inconsisten rate of increase
# 2176 Level 3          No deteminated by the OMS, but is OK
# 2177 Level 2          No deteminated by the OMS, but is OK
# 2178 Level 3          No deteminated by the OMS, but is OK
# 2179 Level 1          No deteminated by the OMS, but is OK
# 2180 Level 1          No deteminated by the OMS, but is OK
# 2181 Level 3 Developing in an inconsisten rate of increase
# 2182 Level 2 Developing in an inconsisten rate of increase
# 2183 Level 3 Developing in an inconsisten rate of increase
# 2184 Level 3 Developing in an inconsisten rate of increase
# 2185 Level 3 Developing in an inconsisten rate of increase
# 2186 Level 1          No deteminated by the OMS, but is OK
# 2187 Level 3          No deteminated by the OMS, but is OK
# 2188 Level 3 Developing in an inconsisten rate of increase
# 2189 Level 3          No deteminated by the OMS, but is OK
# 2190 Level 3 Developing in an inconsisten rate of increase
# 2191 Level 1 Developing in an inconsisten rate of increase
# 2192 Level 3          No deteminated by the OMS, but is OK
# 2193 Level 3 Developing in an inconsisten rate of increase
# 2194 Level 2          No deteminated by the OMS, but is OK
# 2195 Level 1 Developing in an inconsisten rate of increase
# 2196 Level 3 Developing in an inconsisten rate of increase
# 2197 Level 3 Developing in an inconsisten rate of increase
# 2198 Level 3          No deteminated by the OMS, but is OK
# 2199 Level 1          No deteminated by the OMS, but is OK
# 2200 Level 3 Developing in an inconsisten rate of increase
# 2201 Level 3 Developing in an inconsisten rate of increase
# 2202 Level 2          No deteminated by the OMS, but is OK
# 2203 Level 3          No deteminated by the OMS, but is OK
# 2204 Level 2          No deteminated by the OMS, but is OK
# 2205 Level 2          No deteminated by the OMS, but is OK
# 2206 Level 1          No deteminated by the OMS, but is OK
# 2207 Level 2 Developing in an inconsisten rate of increase
# 2208 Level 1 Developing in an inconsisten rate of increase
# 2209 Level 2 Developing in an inconsisten rate of increase
# 2210 Level 3 Developing in an inconsisten rate of increase
# 2211 Level 1 Developing in an inconsisten rate of increase
# 2212 Level 3 Developing in an inconsisten rate of increase
# 2213 Level 3 Developing in an inconsisten rate of increase
# 2214 Level 3          No deteminated by the OMS, but is OK
# 2215 Level 3          No deteminated by the OMS, but is OK
# 2216 Level 2 Developing in an inconsisten rate of increase
# 2217 Level 1 Developing in an inconsisten rate of increase
# 2218 Level 2          No deteminated by the OMS, but is OK
# 2219 Level 3          No deteminated by the OMS, but is OK
# 2220 Level 1          No deteminated by the OMS, but is OK
# 2221 Level 2          No deteminated by the OMS, but is OK
# 2222 Level 2          No deteminated by the OMS, but is OK
# 2223 Level 2 Developing in an inconsisten rate of increase
# 2224 Level 3 Developing in an inconsisten rate of increase
# 2225 Level 3 Developing in an inconsisten rate of increase
# 2226 Level 1 Developing in an inconsisten rate of increase
# 2227 Level 1 Developing in an inconsisten rate of increase
# 2228 Level 3          No deteminated by the OMS, but is OK
# 2229 Level 2          No deteminated by the OMS, but is OK
# 2230 Level 3 Developing in an inconsisten rate of increase
# 2231 Level 1 Developing in an inconsisten rate of increase
# 2232 Level 3          No deteminated by the OMS, but is OK
# 2233 Level 1          No deteminated by the OMS, but is OK
# 2234 Level 3          No deteminated by the OMS, but is OK
# 2235 Level 1          No deteminated by the OMS, but is OK
# 2236 Level 3          No deteminated by the OMS, but is OK
# 2237 Level 1 Developing in an inconsisten rate of increase
# 2238 Level 1 Developing in an inconsisten rate of increase
# 2239 Level 2 Developing in an inconsisten rate of increase
# 2240 Level 3 Developing in an inconsisten rate of increase
# 2241 Level 3 Developing in an inconsisten rate of increase
# 2242 Level 1          No deteminated by the OMS, but is OK
# 2243 Level 3          No deteminated by the OMS, but is OK
# 2244 Level 3 Developing in an inconsisten rate of increase
# 2245 Level 2 Developing in an inconsisten rate of increase
# 2246 Level 1          No deteminated by the OMS, but is OK
# 2247 Level 2          No deteminated by the OMS, but is OK
# 2248 Level 1          No deteminated by the OMS, but is OK
# 2249 Level 2          No deteminated by the OMS, but is OK
# 2250 Level 3          No deteminated by the OMS, but is OK
# 2251 Level 2 Developing in an inconsisten rate of increase
# 2252 Level 2 Developing in an inconsisten rate of increase
# 2253 Level 3 Developing in an inconsisten rate of increase
# 2254 Level 2 Developing in an inconsisten rate of increase
# 2255 Level 3 Developing in an inconsisten rate of increase
# 2256 Level 3          No deteminated by the OMS, but is OK
# 2257 Level 3          No deteminated by the OMS, but is OK
# 2258 Level 1 Developing in an inconsisten rate of increase
# 2259 Level 3 Developing in an inconsisten rate of increase
# 2260 Level 2          No deteminated by the OMS, but is OK
# 2261 Level 2          No deteminated by the OMS, but is OK
# 2262 Level 2          No deteminated by the OMS, but is OK
# 2263 Level 3          No deteminated by the OMS, but is OK
# 2264 Level 3          No deteminated by the OMS, but is OK
# 2265 Level 2 Developing in an inconsisten rate of increase
# 2266 Level 3 Developing in an inconsisten rate of increase
# 2267 Level 2 Developing in an inconsisten rate of increase
# 2268 Level 1 Developing in an inconsisten rate of increase
# 2269 Level 1 Developing in an inconsisten rate of increase
# 2270 Level 2          No deteminated by the OMS, but is OK
# 2271 Level 1          No deteminated by the OMS, but is OK
# 2272 Level 1 Developing in an inconsisten rate of increase
# 2273 Level 1          No deteminated by the OMS, but is OK
# 2274 Level 2 Developing in an inconsisten rate of increase
# 2275 Level 1 Developing in an inconsisten rate of increase
# 2276 Level 2          No deteminated by the OMS, but is OK
# 2277 Level 3 Developing in an inconsisten rate of increase
# 2278 Level 1          No deteminated by the OMS, but is OK
# 2279 Level 3 Developing in an inconsisten rate of increase
# 2280 Level 3 Developing in an inconsisten rate of increase
# 2281 Level 2 Developing in an inconsisten rate of increase
# 2282 Level 3          No deteminated by the OMS, but is OK
# 2283 Level 3          No deteminated by the OMS, but is OK
# 2284 Level 3 Developing in an inconsisten rate of increase
# 2285 Level 2 Developing in an inconsisten rate of increase
# 2286 Level 1          No deteminated by the OMS, but is OK
# 2287 Level 2          No deteminated by the OMS, but is OK
# 2288 Level 3          No deteminated by the OMS, but is OK
# 2289 Level 3          No deteminated by the OMS, but is OK
# 2290 Level 2          No deteminated by the OMS, but is OK
# 2291 Level 2 Developing in an inconsisten rate of increase
# 2292 Level 2 Developing in an inconsisten rate of increase
# 2293 Level 2 Developing in an inconsisten rate of increase
# 2294 Level 1 Developing in an inconsisten rate of increase
# 2295 Level 2 Developing in an inconsisten rate of increase
# 2296 Level 1 Developing in an inconsisten rate of increase
# 2297 Level 2 Developing in an inconsisten rate of increase
# 2298 Level 2          No deteminated by the OMS, but is OK
# 2299 Level 2          No deteminated by the OMS, but is OK
# 2300 Level 3 Developing in an inconsisten rate of increase
# 2301 Level 2 Developing in an inconsisten rate of increase
# 2302 Level 3          No deteminated by the OMS, but is OK
# 2303 Level 2          No deteminated by the OMS, but is OK
# 2304 Level 1          No deteminated by the OMS, but is OK
# 2305 Level 2          No deteminated by the OMS, but is OK
# 2306 Level 2          No deteminated by the OMS, but is OK
# 2307 Level 2 Developing in an inconsisten rate of increase
# 2308 Level 3 Developing in an inconsisten rate of increase
# 2309 Level 3 Developing in an inconsisten rate of increase
# 2310 Level 1 Developing in an inconsisten rate of increase
# 2311 Level 2 Developing in an inconsisten rate of increase
# 2312 Level 3          No deteminated by the OMS, but is OK
# 2313 Level 2          No deteminated by the OMS, but is OK
# 2314 Level 3 Developing in an inconsisten rate of increase
# 2315 Level 2 Developing in an inconsisten rate of increase
# 2316 Level 1          No deteminated by the OMS, but is OK
# 2317 Level 2          No deteminated by the OMS, but is OK
# 2318 Level 3          No deteminated by the OMS, but is OK
# 2319 Level 1          No deteminated by the OMS, but is OK
# 2320 Level 2          No deteminated by the OMS, but is OK
# 2321 Level 3 Developing in an inconsisten rate of increase
# 2322 Level 2 Developing in an inconsisten rate of increase
# 2323 Level 3 Developing in an inconsisten rate of increase
# 2324 Level 3 Developing in an inconsisten rate of increase
# 2325 Level 1 Developing in an inconsisten rate of increase
# 2326 Level 3          No deteminated by the OMS, but is OK
# 2327 Level 1          No deteminated by the OMS, but is OK
# 2328 Level 1 Developing in an inconsisten rate of increase
# 2329 Level 2 Developing in an inconsisten rate of increase
# 2330 Level 1          No deteminated by the OMS, but is OK
# 2331 Level 1          No deteminated by the OMS, but is OK
# 2332 Level 3          No deteminated by the OMS, but is OK
# 2333 Level 1          No deteminated by the OMS, but is OK
# 2334 Level 2          No deteminated by the OMS, but is OK
# 2335 Level 1 Developing in an inconsisten rate of increase
# 2336 Level 2 Developing in an inconsisten rate of increase
# 2337 Level 1 Developing in an inconsisten rate of increase
# 2338 Level 1 Developing in an inconsisten rate of increase
# 2339 Level 2 Developing in an inconsisten rate of increase
# 2340 Level 3          No deteminated by the OMS, but is OK
# 2341 Level 2          No deteminated by the OMS, but is OK
# 2342 Level 3 Developing in an inconsisten rate of increase
# 2343 Level 1 Developing in an inconsisten rate of increase
# 2344 Level 1          No deteminated by the OMS, but is OK
# 2345 Level 1          No deteminated by the OMS, but is OK
# 2346 Level 2          No deteminated by the OMS, but is OK
# 2347 Level 2          No deteminated by the OMS, but is OK
# 2348 Level 2          No deteminated by the OMS, but is OK
# 2349 Level 2 Developing in an inconsisten rate of increase
# 2350 Level 2 Developing in an inconsisten rate of increase
# 2351 Level 1 Developing in an inconsisten rate of increase
# 2352 Level 3 Developing in an inconsisten rate of increase
# 2353 Level 2 Developing in an inconsisten rate of increase
# 2354 Level 3          No deteminated by the OMS, but is OK
# 2355 Level 2          No deteminated by the OMS, but is OK
# 2356 Level 2 Developing in an inconsisten rate of increase
# 2357 Level 2          No deteminated by the OMS, but is OK
# 2358 Level 3 Developing in an inconsisten rate of increase
# 2359 Level 3 Developing in an inconsisten rate of increase
# 2360 Level 3          No deteminated by the OMS, but is OK
# 2361 Level 3 Developing in an inconsisten rate of increase
# 2362 Level 2          No deteminated by the OMS, but is OK
# 2363 Level 2 Developing in an inconsisten rate of increase
# 2364 Level 3 Developing in an inconsisten rate of increase
# 2365 Level 2 Developing in an inconsisten rate of increase
# 2366 Level 1          No deteminated by the OMS, but is OK
# 2367 Level 1          No deteminated by the OMS, but is OK
# 2368 Level 3 Developing in an inconsisten rate of increase
# 2369 Level 3 Developing in an inconsisten rate of increase
# 2370 Level 1          No deteminated by the OMS, but is OK
# 2371 Level 3          No deteminated by the OMS, but is OK
# 2372 Level 1          No deteminated by the OMS, but is OK
# 2373 Level 3          No deteminated by the OMS, but is OK
# 2374 Level 3          No deteminated by the OMS, but is OK
# 2375 Level 2 Developing in an inconsisten rate of increase
# 2376 Level 2 Developing in an inconsisten rate of increase
# 2377 Level 2 Developing in an inconsisten rate of increase
# 2378 Level 2 Developing in an inconsisten rate of increase
# 2379 Level 1 Developing in an inconsisten rate of increase
# 2380 Level 2 Developing in an inconsisten rate of increase
# 2381 Level 2 Developing in an inconsisten rate of increase
# 2382 Level 1          No deteminated by the OMS, but is OK
# 2383 Level 3          No deteminated by the OMS, but is OK
# 2384 Level 1 Developing in an inconsisten rate of increase
# 2385 Level 1 Developing in an inconsisten rate of increase
# 2386 Level 3          No deteminated by the OMS, but is OK
# 2387 Level 2          No deteminated by the OMS, but is OK
# 2388 Level 1          No deteminated by the OMS, but is OK
# 2389 Level 2          No deteminated by the OMS, but is OK
# 2390 Level 3          No deteminated by the OMS, but is OK
# 2391 Level 2 Developing in an inconsisten rate of increase
# 2392 Level 1 Developing in an inconsisten rate of increase
# 2393 Level 3 Developing in an inconsisten rate of increase
# 2394 Level 3 Developing in an inconsisten rate of increase
# 2395 Level 2 Developing in an inconsisten rate of increase
# 2396 Level 3          No deteminated by the OMS, but is OK
# 2397 Level 3          No deteminated by the OMS, but is OK
# 2398 Level 2 Developing in an inconsisten rate of increase
# 2399 Level 3 Developing in an inconsisten rate of increase
# 2400 Level 3          No deteminated by the OMS, but is OK
# 2401 Level 1          No deteminated by the OMS, but is OK
# 2402 Level 1          No deteminated by the OMS, but is OK
# 2403 Level 1          No deteminated by the OMS, but is OK
# 2404 Level 3          No deteminated by the OMS, but is OK
# 2405 Level 1 Developing in an inconsisten rate of increase
# 2406 Level 2 Developing in an inconsisten rate of increase
# 2407 Level 1 Developing in an inconsisten rate of increase
# 2408 Level 2 Developing in an inconsisten rate of increase
# 2409 Level 1 Developing in an inconsisten rate of increase
# 2410 Level 3          No deteminated by the OMS, but is OK
# 2411 Level 3          No deteminated by the OMS, but is OK
# 2412 Level 3 Developing in an inconsisten rate of increase
# 2413 Level 1 Developing in an inconsisten rate of increase
# 2414 Level 1          No deteminated by the OMS, but is OK
# 2415 Level 1          No deteminated by the OMS, but is OK
# 2416 Level 1          No deteminated by the OMS, but is OK
# 2417 Level 1          No deteminated by the OMS, but is OK
# 2418 Level 2          No deteminated by the OMS, but is OK
# 2419 Level 1 Developing in an inconsisten rate of increase
# 2420 Level 2 Developing in an inconsisten rate of increase
# 2421 Level 1 Developing in an inconsisten rate of increase
# 2422 Level 1 Developing in an inconsisten rate of increase
# 2423 Level 1 Developing in an inconsisten rate of increase
# 2424 Level 3          No deteminated by the OMS, but is OK
# 2425 Level 1          No deteminated by the OMS, but is OK
# 2426 Level 1 Developing in an inconsisten rate of increase
# 2427 Level 1 Developing in an inconsisten rate of increase
# 2428 Level 2          No deteminated by the OMS, but is OK
# 2429 Level 1          No deteminated by the OMS, but is OK
# 2430 Level 1          No deteminated by the OMS, but is OK
# 2431 Level 1          No deteminated by the OMS, but is OK
# 2432 Level 2          No deteminated by the OMS, but is OK
# 2433 Level 3 Developing in an inconsisten rate of increase
# 2434 Level 3 Developing in an inconsisten rate of increase
# 2435 Level 1 Developing in an inconsisten rate of increase
# 2436 Level 2 Developing in an inconsisten rate of increase
# 2437 Level 2 Developing in an inconsisten rate of increase
# 2438 Level 1          No deteminated by the OMS, but is OK
# 2439 Level 2          No deteminated by the OMS, but is OK
# 2440 Level 1 Developing in an inconsisten rate of increase
# 2441 Level 3          No deteminated by the OMS, but is OK
# 2442 Level 3 Developing in an inconsisten rate of increase
# 2443 Level 3 Developing in an inconsisten rate of increase
# 2444 Level 3          No deteminated by the OMS, but is OK
# 2445 Level 1 Developing in an inconsisten rate of increase
# 2446 Level 2          No deteminated by the OMS, but is OK
# 2447 Level 1 Developing in an inconsisten rate of increase
# 2448 Level 3 Developing in an inconsisten rate of increase
# 2449 Level 3 Developing in an inconsisten rate of increase
# 2450 Level 1          No deteminated by the OMS, but is OK
# 2451 Level 2          No deteminated by the OMS, but is OK
# 2452 Level 3 Developing in an inconsisten rate of increase
# 2453 Level 1 Developing in an inconsisten rate of increase
# 2454 Level 1          No deteminated by the OMS, but is OK
# 2455 Level 3          No deteminated by the OMS, but is OK
# 2456 Level 1          No deteminated by the OMS, but is OK
# 2457 Level 3          No deteminated by the OMS, but is OK
# 2458 Level 2          No deteminated by the OMS, but is OK
# 2459 Level 3 Developing in an inconsisten rate of increase
# 2460 Level 1 Developing in an inconsisten rate of increase
# 2461 Level 3 Developing in an inconsisten rate of increase
# 2462 Level 1 Developing in an inconsisten rate of increase
# 2463 Level 3 Developing in an inconsisten rate of increase
# 2464 Level 1 Developing in an inconsisten rate of increase
# 2465 Level 3 Developing in an inconsisten rate of increase
# 2466 Level 1          No deteminated by the OMS, but is OK
# 2467 Level 3          No deteminated by the OMS, but is OK
# 2468 Level 1 Developing in an inconsisten rate of increase
# 2469 Level 3 Developing in an inconsisten rate of increase
# 2470 Level 2          No deteminated by the OMS, but is OK
# 2471 Level 2          No deteminated by the OMS, but is OK
# 2472 Level 1          No deteminated by the OMS, but is OK
# 2473 Level 3          No deteminated by the OMS, but is OK
# 2474 Level 3          No deteminated by the OMS, but is OK
# 2475 Level 1 Developing in an inconsisten rate of increase
# 2476 Level 3 Developing in an inconsisten rate of increase
# 2477 Level 1 Developing in an inconsisten rate of increase
# 2478 Level 1 Developing in an inconsisten rate of increase
# 2479 Level 2 Developing in an inconsisten rate of increase
# 2480 Level 1          No deteminated by the OMS, but is OK
# 2481 Level 2          No deteminated by the OMS, but is OK
# 2482 Level 2 Developing in an inconsisten rate of increase
# 2483 Level 1 Developing in an inconsisten rate of increase
# 2484 Level 3          No deteminated by the OMS, but is OK
# 2485 Level 3          No deteminated by the OMS, but is OK
# 2486 Level 3          No deteminated by the OMS, but is OK
# 2487 Level 1          No deteminated by the OMS, but is OK
# 2488 Level 1          No deteminated by the OMS, but is OK
# 2489 Level 3 Developing in an inconsisten rate of increase
# 2490 Level 1 Developing in an inconsisten rate of increase
# 2491 Level 2 Developing in an inconsisten rate of increase
# 2492 Level 3 Developing in an inconsisten rate of increase
# 2493 Level 3 Developing in an inconsisten rate of increase
# 2494 Level 2          No deteminated by the OMS, but is OK
# 2495 Level 2          No deteminated by the OMS, but is OK
# 2496 Level 2 Developing in an inconsisten rate of increase
# 2497 Level 3 Developing in an inconsisten rate of increase
# 2498 Level 1          No deteminated by the OMS, but is OK
# 2499 Level 3          No deteminated by the OMS, but is OK
# 2500 Level 3          No deteminated by the OMS, but is OK
# 2501 Level 2          No deteminated by the OMS, but is OK
# 2502 Level 3          No deteminated by the OMS, but is OK
# 2503 Level 3 Developing in an inconsisten rate of increase
# 2504 Level 3 Developing in an inconsisten rate of increase
# 2505 Level 2 Developing in an inconsisten rate of increase
# 2506 Level 2 Developing in an inconsisten rate of increase
# 2507 Level 1 Developing in an inconsisten rate of increase
# 2508 Level 2          No deteminated by the OMS, but is OK
# 2509 Level 1          No deteminated by the OMS, but is OK
# 2510 Level 2 Developing in an inconsisten rate of increase
# 2511 Level 3 Developing in an inconsisten rate of increase
# 2512 Level 1          No deteminated by the OMS, but is OK
# 2513 Level 3          No deteminated by the OMS, but is OK
# 2514 Level 2          No deteminated by the OMS, but is OK
# 2515 Level 1          No deteminated by the OMS, but is OK
# 2516 Level 2          No deteminated by the OMS, but is OK
# 2517 Level 3 Developing in an inconsisten rate of increase
# 2518 Level 2 Developing in an inconsisten rate of increase
# 2519 Level 3 Developing in an inconsisten rate of increase
# 2520 Level 2 Developing in an inconsisten rate of increase
# 2521 Level 2 Developing in an inconsisten rate of increase
# 2522 Level 1          No deteminated by the OMS, but is OK
# 2523 Level 1          No deteminated by the OMS, but is OK
# 2524 Level 1 Developing in an inconsisten rate of increase
# 2525 Level 2          No deteminated by the OMS, but is OK
# 2526 Level 1 Developing in an inconsisten rate of increase
# 2527 Level 2 Developing in an inconsisten rate of increase
# 2528 Level 3          No deteminated by the OMS, but is OK
# 2529 Level 2 Developing in an inconsisten rate of increase
# 2530 Level 1          No deteminated by the OMS, but is OK
# 2531 Level 2 Developing in an inconsisten rate of increase
# 2532 Level 2 Developing in an inconsisten rate of increase
# 2533 Level 2 Developing in an inconsisten rate of increase
# 2534 Level 1          No deteminated by the OMS, but is OK
# 2535 Level 3          No deteminated by the OMS, but is OK
# 2536 Level 3 Developing in an inconsisten rate of increase
# 2537 Level 1 Developing in an inconsisten rate of increase
# 2538 Level 3          No deteminated by the OMS, but is OK
# 2539 Level 3          No deteminated by the OMS, but is OK
# 2540 Level 2          No deteminated by the OMS, but is OK
# 2541 Level 2          No deteminated by the OMS, but is OK
# 2542 Level 3          No deteminated by the OMS, but is OK
# 2543 Level 1 Developing in an inconsisten rate of increase
# 2544 Level 1 Developing in an inconsisten rate of increase
# 2545 Level 2 Developing in an inconsisten rate of increase
# 2546 Level 2 Developing in an inconsisten rate of increase
# 2547 Level 1 Developing in an inconsisten rate of increase
# 2548 Level 1 Developing in an inconsisten rate of increase
# 2549 Level 2 Developing in an inconsisten rate of increase
# 2550 Level 1          No deteminated by the OMS, but is OK
# 2551 Level 2          No deteminated by the OMS, but is OK
# 2552 Level 2 Developing in an inconsisten rate of increase
# 2553 Level 2 Developing in an inconsisten rate of increase
# 2554 Level 2          No deteminated by the OMS, but is OK
# 2555 Level 1          No deteminated by the OMS, but is OK
# 2556 Level 2          No deteminated by the OMS, but is OK
# 2557 Level 2          No deteminated by the OMS, but is OK
# 2558 Level 2          No deteminated by the OMS, but is OK
# 2559 Level 1 Developing in an inconsisten rate of increase
# 2560 Level 1 Developing in an inconsisten rate of increase
# 2561 Level 1 Developing in an inconsisten rate of increase
# 2562 Level 1 Developing in an inconsisten rate of increase
# 2563 Level 3 Developing in an inconsisten rate of increase
# 2564 Level 3          No deteminated by the OMS, but is OK
# 2565 Level 3          No deteminated by the OMS, but is OK
# 2566 Level 2 Developing in an inconsisten rate of increase
# 2567 Level 2 Developing in an inconsisten rate of increase
# 2568 Level 2          No deteminated by the OMS, but is OK
# 2569 Level 3          No deteminated by the OMS, but is OK
# 2570 Level 2          No deteminated by the OMS, but is OK
# 2571 Level 1          No deteminated by the OMS, but is OK
# 2572 Level 2          No deteminated by the OMS, but is OK
# 2573 Level 1 Developing in an inconsisten rate of increase
# 2574 Level 3 Developing in an inconsisten rate of increase
# 2575 Level 3 Developing in an inconsisten rate of increase
# 2576 Level 3 Developing in an inconsisten rate of increase
# 2577 Level 1 Developing in an inconsisten rate of increase
# 2578 Level 2          No deteminated by the OMS, but is OK
# 2579 Level 3          No deteminated by the OMS, but is OK
# 2580 Level 1 Developing in an inconsisten rate of increase
# 2581 Level 2 Developing in an inconsisten rate of increase
# 2582 Level 1          No deteminated by the OMS, but is OK
# 2583 Level 3          No deteminated by the OMS, but is OK
# 2584 Level 2          No deteminated by the OMS, but is OK
# 2585 Level 2          No deteminated by the OMS, but is OK
# 2586 Level 2          No deteminated by the OMS, but is OK
# 2587 Level 1 Developing in an inconsisten rate of increase
# 2588 Level 2 Developing in an inconsisten rate of increase
# 2589 Level 2 Developing in an inconsisten rate of increase
# 2590 Level 1 Developing in an inconsisten rate of increase
# 2591 Level 3 Developing in an inconsisten rate of increase
# 2592 Level 2          No deteminated by the OMS, but is OK
# 2593 Level 2          No deteminated by the OMS, but is OK
# 2594 Level 1 Developing in an inconsisten rate of increase
# 2595 Level 3 Developing in an inconsisten rate of increase
# 2596 Level 1          No deteminated by the OMS, but is OK
# 2597 Level 2          No deteminated by the OMS, but is OK
# 2598 Level 2          No deteminated by the OMS, but is OK
# 2599 Level 3          No deteminated by the OMS, but is OK
# 2600 Level 2          No deteminated by the OMS, but is OK
# 2601 Level 3 Developing in an inconsisten rate of increase
# 2602 Level 1 Developing in an inconsisten rate of increase
# 2603 Level 2 Developing in an inconsisten rate of increase
# 2604 Level 2 Developing in an inconsisten rate of increase
# 2605 Level 1 Developing in an inconsisten rate of increase
# 2606 Level 2          No deteminated by the OMS, but is OK
# 2607 Level 1          No deteminated by the OMS, but is OK
# 2608 Level 2 Developing in an inconsisten rate of increase
# 2609 Level 2          No deteminated by the OMS, but is OK
# 2610 Level 1 Developing in an inconsisten rate of increase
# 2611 Level 3 Developing in an inconsisten rate of increase
# 2612 Level 1          No deteminated by the OMS, but is OK
# 2613 Level 1 Developing in an inconsisten rate of increase
# 2614 Level 2          No deteminated by the OMS, but is OK
# 2615 Level 1 Developing in an inconsisten rate of increase
# 2616 Level 2 Developing in an inconsisten rate of increase
# 2617 Level 1 Developing in an inconsisten rate of increase
# 2618 Level 2          No deteminated by the OMS, but is OK
# 2619 Level 2          No deteminated by the OMS, but is OK
# 2620 Level 1 Developing in an inconsisten rate of increase
# 2621 Level 2 Developing in an inconsisten rate of increase
# 2622 Level 3          No deteminated by the OMS, but is OK
# 2623 Level 2          No deteminated by the OMS, but is OK
# 2624 Level 3          No deteminated by the OMS, but is OK
# 2625 Level 3          No deteminated by the OMS, but is OK
# 2626 Level 1          No deteminated by the OMS, but is OK
# 2627 Level 3 Developing in an inconsisten rate of increase
# 2628 Level 1 Developing in an inconsisten rate of increase
# 2629 Level 3 Developing in an inconsisten rate of increase
# 2630 Level 3 Developing in an inconsisten rate of increase
# 2631 Level 1 Developing in an inconsisten rate of increase
# 2632 Level 1 Developing in an inconsisten rate of increase
# 2633 Level 1 Developing in an inconsisten rate of increase
# 2634 Level 1          No deteminated by the OMS, but is OK
# 2635 Level 1          No deteminated by the OMS, but is OK
# 2636 Level 3 Developing in an inconsisten rate of increase
# 2637 Level 1 Developing in an inconsisten rate of increase
# 2638 Level 1          No deteminated by the OMS, but is OK
# 2639 Level 2          No deteminated by the OMS, but is OK
# 2640 Level 1          No deteminated by the OMS, but is OK
# 2641 Level 1          No deteminated by the OMS, but is OK
# 2642 Level 2          No deteminated by the OMS, but is OK
# 2643 Level 3 Developing in an inconsisten rate of increase
# 2644 Level 2 Developing in an inconsisten rate of increase
# 2645 Level 2 Developing in an inconsisten rate of increase
# 2646 Level 1 Developing in an inconsisten rate of increase
# 2647 Level 2 Developing in an inconsisten rate of increase
# 2648 Level 2          No deteminated by the OMS, but is OK
# 2649 Level 3          No deteminated by the OMS, but is OK
# 2650 Level 3 Developing in an inconsisten rate of increase
# 2651 Level 2 Developing in an inconsisten rate of increase
# 2652 Level 3          No deteminated by the OMS, but is OK
# 2653 Level 3          No deteminated by the OMS, but is OK
# 2654 Level 1          No deteminated by the OMS, but is OK
# 2655 Level 1          No deteminated by the OMS, but is OK
# 2656 Level 2          No deteminated by the OMS, but is OK
# 2657 Level 1 Developing in an inconsisten rate of increase
# 2658 Level 3 Developing in an inconsisten rate of increase
# 2659 Level 2 Developing in an inconsisten rate of increase
# 2660 Level 1 Developing in an inconsisten rate of increase
# 2661 Level 3 Developing in an inconsisten rate of increase
# 2662 Level 3          No deteminated by the OMS, but is OK
# 2663 Level 3          No deteminated by the OMS, but is OK
# 2664 Level 3 Developing in an inconsisten rate of increase
# 2665 Level 1 Developing in an inconsisten rate of increase
# 2666 Level 2          No deteminated by the OMS, but is OK
# 2667 Level 1          No deteminated by the OMS, but is OK
# 2668 Level 3          No deteminated by the OMS, but is OK
# 2669 Level 1          No deteminated by the OMS, but is OK
# 2670 Level 3          No deteminated by the OMS, but is OK
# 2671 Level 3 Developing in an inconsisten rate of increase
# 2672 Level 3 Developing in an inconsisten rate of increase
# 2673 Level 1 Developing in an inconsisten rate of increase
# 2674 Level 1 Developing in an inconsisten rate of increase
# 2675 Level 2 Developing in an inconsisten rate of increase
# 2676 Level 1          No deteminated by the OMS, but is OK
# 2677 Level 1          No deteminated by the OMS, but is OK
# 2678 Level 1 Developing in an inconsisten rate of increase
# 2679 Level 1 Developing in an inconsisten rate of increase
# 2680 Level 1          No deteminated by the OMS, but is OK
# 2681 Level 1          No deteminated by the OMS, but is OK
# 2682 Level 3          No deteminated by the OMS, but is OK
# 2683 Level 3          No deteminated by the OMS, but is OK
# 2684 Level 1          No deteminated by the OMS, but is OK
# 2685 Level 3 Developing in an inconsisten rate of increase
# 2686 Level 3 Developing in an inconsisten rate of increase
# 2687 Level 3 Developing in an inconsisten rate of increase
# 2688 Level 3 Developing in an inconsisten rate of increase
# 2689 Level 3 Developing in an inconsisten rate of increase
# 2690 Level 3          No deteminated by the OMS, but is OK
# 2691 Level 2          No deteminated by the OMS, but is OK
# 2692 Level 2 Developing in an inconsisten rate of increase
# 2693 Level 3          No deteminated by the OMS, but is OK
# 2694 Level 1 Developing in an inconsisten rate of increase
# 2695 Level 1 Developing in an inconsisten rate of increase
# 2696 Level 1          No deteminated by the OMS, but is OK
# 2697 Level 3 Developing in an inconsisten rate of increase
# 2698 Level 3          No deteminated by the OMS, but is OK
# 2699 Level 2 Developing in an inconsisten rate of increase
# 2700 Level 3 Developing in an inconsisten rate of increase
# 2701 Level 1 Developing in an inconsisten rate of increase
# 2702 Level 2          No deteminated by the OMS, but is OK
# 2703 Level 1          No deteminated by the OMS, but is OK
# 2704 Level 1 Developing in an inconsisten rate of increase
# 2705 Level 2 Developing in an inconsisten rate of increase
# 2706 Level 3          No deteminated by the OMS, but is OK
# 2707 Level 1          No deteminated by the OMS, but is OK
# 2708 Level 2          No deteminated by the OMS, but is OK
# 2709 Level 2          No deteminated by the OMS, but is OK
# 2710 Level 1          No deteminated by the OMS, but is OK
# 2711 Level 1 Developing in an inconsisten rate of increase
# 2712 Level 1 Developing in an inconsisten rate of increase
# 2713 Level 2 Developing in an inconsisten rate of increase
# 2714 Level 2 Developing in an inconsisten rate of increase
# 2715 Level 1 Developing in an inconsisten rate of increase
# 2716 Level 2 Developing in an inconsisten rate of increase
# 2717 Level 2 Developing in an inconsisten rate of increase
# 2718 Level 3          No deteminated by the OMS, but is OK
# 2719 Level 2          No deteminated by the OMS, but is OK
# 2720 Level 3 Developing in an inconsisten rate of increase
# 2721 Level 1 Developing in an inconsisten rate of increase
# 2722 Level 2          No deteminated by the OMS, but is OK
# 2723 Level 1          No deteminated by the OMS, but is OK
# 2724 Level 2          No deteminated by the OMS, but is OK
# 2725 Level 2          No deteminated by the OMS, but is OK
# 2726 Level 3          No deteminated by the OMS, but is OK
# 2727 Level 3 Developing in an inconsisten rate of increase
# 2728 Level 3 Developing in an inconsisten rate of increase
# 2729 Level 3 Developing in an inconsisten rate of increase
# 2730 Level 2 Developing in an inconsisten rate of increase
# 2731 Level 2 Developing in an inconsisten rate of increase
# 2732 Level 2          No deteminated by the OMS, but is OK
# 2733 Level 1          No deteminated by the OMS, but is OK
# 2734 Level 1 Developing in an inconsisten rate of increase
# 2735 Level 2 Developing in an inconsisten rate of increase
# 2736 Level 3          No deteminated by the OMS, but is OK
# 2737 Level 3          No deteminated by the OMS, but is OK
# 2738 Level 1          No deteminated by the OMS, but is OK
# 2739 Level 3          No deteminated by the OMS, but is OK
# 2740 Level 2          No deteminated by the OMS, but is OK
# 2741 Level 2 Developing in an inconsisten rate of increase
# 2742 Level 3 Developing in an inconsisten rate of increase
# 2743 Level 1 Developing in an inconsisten rate of increase
# 2744 Level 2 Developing in an inconsisten rate of increase
# 2745 Level 1 Developing in an inconsisten rate of increase
# 2746 Level 2          No deteminated by the OMS, but is OK
# 2747 Level 2          No deteminated by the OMS, but is OK
# 2748 Level 3 Developing in an inconsisten rate of increase
# 2749 Level 1 Developing in an inconsisten rate of increase
# 2750 Level 2          No deteminated by the OMS, but is OK
# 2751 Level 1          No deteminated by the OMS, but is OK
# 2752 Level 2          No deteminated by the OMS, but is OK
# 2753 Level 3          No deteminated by the OMS, but is OK
# 2754 Level 1          No deteminated by the OMS, but is OK
# 2755 Level 3 Developing in an inconsisten rate of increase
# 2756 Level 2 Developing in an inconsisten rate of increase
# 2757 Level 1 Developing in an inconsisten rate of increase
# 2758 Level 3 Developing in an inconsisten rate of increase
# 2759 Level 3 Developing in an inconsisten rate of increase
# 2760 Level 3          No deteminated by the OMS, but is OK
# 2761 Level 1          No deteminated by the OMS, but is OK
# 2762 Level 3 Developing in an inconsisten rate of increase
# 2763 Level 3 Developing in an inconsisten rate of increase
# 2764 Level 1          No deteminated by the OMS, but is OK
# 2765 Level 1          No deteminated by the OMS, but is OK
# 2766 Level 1          No deteminated by the OMS, but is OK
# 2767 Level 1          No deteminated by the OMS, but is OK
# 2768 Level 1          No deteminated by the OMS, but is OK
# 2769 Level 1 Developing in an inconsisten rate of increase
# 2770 Level 1 Developing in an inconsisten rate of increase
# 2771 Level 1 Developing in an inconsisten rate of increase
# 2772 Level 1 Developing in an inconsisten rate of increase
# 2773 Level 2 Developing in an inconsisten rate of increase
# 2774 Level 2          No deteminated by the OMS, but is OK
# 2775 Level 2          No deteminated by the OMS, but is OK
# 2776 Level 1 Developing in an inconsisten rate of increase
# 2777 Level 2          No deteminated by the OMS, but is OK
# 2778 Level 1 Developing in an inconsisten rate of increase
# 2779 Level 2 Developing in an inconsisten rate of increase
# 2780 Level 3          No deteminated by the OMS, but is OK
# 2781 Level 2 Developing in an inconsisten rate of increase
# 2782 Level 1          No deteminated by the OMS, but is OK
# 2783 Level 2 Developing in an inconsisten rate of increase
# 2784 Level 1 Developing in an inconsisten rate of increase
# 2785 Level 1 Developing in an inconsisten rate of increase
# 2786 Level 3          No deteminated by the OMS, but is OK
# 2787 Level 3          No deteminated by the OMS, but is OK
# 2788 Level 2 Developing in an inconsisten rate of increase
# 2789 Level 1 Developing in an inconsisten rate of increase
# 2790 Level 3          No deteminated by the OMS, but is OK
# 2791 Level 3          No deteminated by the OMS, but is OK
# 2792 Level 1          No deteminated by the OMS, but is OK
# 2793 Level 2          No deteminated by the OMS, but is OK
# 2794 Level 1          No deteminated by the OMS, but is OK
# 2795 Level 1 Developing in an inconsisten rate of increase
# 2796 Level 3 Developing in an inconsisten rate of increase
# 2797 Level 3 Developing in an inconsisten rate of increase
# 2798 Level 1 Developing in an inconsisten rate of increase
# 2799 Level 2 Developing in an inconsisten rate of increase
# 2800 Level 3 Developing in an inconsisten rate of increase
# 2801 Level 2 Developing in an inconsisten rate of increase
# 2802 Level 2          No deteminated by the OMS, but is OK
# 2803 Level 2          No deteminated by the OMS, but is OK
# 2804 Level 3 Developing in an inconsisten rate of increase
# 2805 Level 2 Developing in an inconsisten rate of increase
# 2806 Level 1          No deteminated by the OMS, but is OK
# 2807 Level 1          No deteminated by the OMS, but is OK
# 2808 Level 2          No deteminated by the OMS, but is OK
# 2809 Level 1          No deteminated by the OMS, but is OK
# 2810 Level 1          No deteminated by the OMS, but is OK
# 2811 Level 1 Developing in an inconsisten rate of increase
# 2812 Level 3 Developing in an inconsisten rate of increase
# 2813 Level 1 Developing in an inconsisten rate of increase
# 2814 Level 2 Developing in an inconsisten rate of increase
# 2815 Level 3 Developing in an inconsisten rate of increase
# 2816 Level 1          No deteminated by the OMS, but is OK
# 2817 Level 2          No deteminated by the OMS, but is OK
# 2818 Level 1 Developing in an inconsisten rate of increase
# 2819 Level 3 Developing in an inconsisten rate of increase
# 2820 Level 3          No deteminated by the OMS, but is OK
# 2821 Level 1          No deteminated by the OMS, but is OK
# 2822 Level 2          No deteminated by the OMS, but is OK
# 2823 Level 1          No deteminated by the OMS, but is OK
# 2824 Level 3          No deteminated by the OMS, but is OK
# 2825 Level 2 Developing in an inconsisten rate of increase
# 2826 Level 2 Developing in an inconsisten rate of increase
# 2827 Level 3 Developing in an inconsisten rate of increase
# 2828 Level 2 Developing in an inconsisten rate of increase
# 2829 Level 2 Developing in an inconsisten rate of increase
# 2830 Level 3          No deteminated by the OMS, but is OK
# 2831 Level 1          No deteminated by the OMS, but is OK
# 2832 Level 3 Developing in an inconsisten rate of increase
# 2833 Level 2 Developing in an inconsisten rate of increase
# 2834 Level 2          No deteminated by the OMS, but is OK
# 2835 Level 2          No deteminated by the OMS, but is OK
# 2836 Level 1          No deteminated by the OMS, but is OK
# 2837 Level 1          No deteminated by the OMS, but is OK
# 2838 Level 2          No deteminated by the OMS, but is OK
# 2839 Level 3 Developing in an inconsisten rate of increase
# 2840 Level 2 Developing in an inconsisten rate of increase
# 2841 Level 2 Developing in an inconsisten rate of increase
# 2842 Level 3 Developing in an inconsisten rate of increase
# 2843 Level 3 Developing in an inconsisten rate of increase
# 2844 Level 3          No deteminated by the OMS, but is OK
# 2845 Level 1          No deteminated by the OMS, but is OK
# 2846 Level 1 Developing in an inconsisten rate of increase
# 2847 Level 3 Developing in an inconsisten rate of increase
# 2848 Level 3          No deteminated by the OMS, but is OK
# 2849 Level 2          No deteminated by the OMS, but is OK
# 2850 Level 3          No deteminated by the OMS, but is OK
# 2851 Level 1          No deteminated by the OMS, but is OK
# 2852 Level 1          No deteminated by the OMS, but is OK
# 2853 Level 1 Developing in an inconsisten rate of increase
# 2854 Level 2 Developing in an inconsisten rate of increase
# 2855 Level 3 Developing in an inconsisten rate of increase
# 2856 Level 3 Developing in an inconsisten rate of increase
# 2857 Level 1 Developing in an inconsisten rate of increase
# 2858 Level 1          No deteminated by the OMS, but is OK
# 2859 Level 1          No deteminated by the OMS, but is OK
# 2860 Level 3 Developing in an inconsisten rate of increase
# 2861 Level 3          No deteminated by the OMS, but is OK
# 2862 Level 1 Developing in an inconsisten rate of increase
# 2863 Level 2 Developing in an inconsisten rate of increase
# 2864 Level 3          No deteminated by the OMS, but is OK
# 2865 Level 1 Developing in an inconsisten rate of increase
# 2866 Level 1          No deteminated by the OMS, but is OK
# 2867 Level 2 Developing in an inconsisten rate of increase
# 2868 Level 1 Developing in an inconsisten rate of increase
# 2869 Level 3 Developing in an inconsisten rate of increase
# 2870 Level 2          No deteminated by the OMS, but is OK
# 2871 Level 2          No deteminated by the OMS, but is OK
# 2872 Level 3 Developing in an inconsisten rate of increase
# 2873 Level 1 Developing in an inconsisten rate of increase
# 2874 Level 2          No deteminated by the OMS, but is OK
# 2875 Level 2          No deteminated by the OMS, but is OK
# 2876 Level 1          No deteminated by the OMS, but is OK
# 2877 Level 1          No deteminated by the OMS, but is OK
# 2878 Level 2          No deteminated by the OMS, but is OK
# 2879 Level 1 Developing in an inconsisten rate of increase
# 2880 Level 3 Developing in an inconsisten rate of increase
# 2881 Level 2 Developing in an inconsisten rate of increase
# 2882 Level 3 Developing in an inconsisten rate of increase
# 2883 Level 1 Developing in an inconsisten rate of increase
# 2884 Level 1 Developing in an inconsisten rate of increase
# 2885 Level 2 Developing in an inconsisten rate of increase
# 2886 Level 3          No deteminated by the OMS, but is OK
# 2887 Level 1          No deteminated by the OMS, but is OK
# 2888 Level 2 Developing in an inconsisten rate of increase
# 2889 Level 1 Developing in an inconsisten rate of increase
# 2890 Level 3          No deteminated by the OMS, but is OK
# 2891 Level 2          No deteminated by the OMS, but is OK
# 2892 Level 3          No deteminated by the OMS, but is OK
# 2893 Level 1          No deteminated by the OMS, but is OK
# 2894 Level 3          No deteminated by the OMS, but is OK
# 2895 Level 3 Developing in an inconsisten rate of increase
# 2896 Level 2 Developing in an inconsisten rate of increase
# 2897 Level 3 Developing in an inconsisten rate of increase
# 2898 Level 3 Developing in an inconsisten rate of increase
# 2899 Level 1 Developing in an inconsisten rate of increase
# 2900 Level 3          No deteminated by the OMS, but is OK
# 2901 Level 3          No deteminated by the OMS, but is OK
# 2902 Level 2 Developing in an inconsisten rate of increase
# 2903 Level 3 Developing in an inconsisten rate of increase
# 2904 Level 3          No deteminated by the OMS, but is OK
# 2905 Level 3          No deteminated by the OMS, but is OK
# 2906 Level 1          No deteminated by the OMS, but is OK
# 2907 Level 2          No deteminated by the OMS, but is OK
# 2908 Level 2          No deteminated by the OMS, but is OK
# 2909 Level 2 Developing in an inconsisten rate of increase
# 2910 Level 2 Developing in an inconsisten rate of increase
# 2911 Level 1 Developing in an inconsisten rate of increase
# 2912 Level 2 Developing in an inconsisten rate of increase
# 2913 Level 2 Developing in an inconsisten rate of increase
# 2914 Level 3          No deteminated by the OMS, but is OK
# 2915 Level 1          No deteminated by the OMS, but is OK
# 2916 Level 3 Developing in an inconsisten rate of increase
# 2917 Level 3 Developing in an inconsisten rate of increase
# 2918 Level 1          No deteminated by the OMS, but is OK
# 2919 Level 2          No deteminated by the OMS, but is OK
# 2920 Level 2          No deteminated by the OMS, but is OK
# 2921 Level 1          No deteminated by the OMS, but is OK
# 2922 Level 3          No deteminated by the OMS, but is OK
# 2923 Level 1 Developing in an inconsisten rate of increase
# 2924 Level 2 Developing in an inconsisten rate of increase
# 2925 Level 1 Developing in an inconsisten rate of increase
# 2926 Level 1 Developing in an inconsisten rate of increase
# 2927 Level 2 Developing in an inconsisten rate of increase
# 2928 Level 2          No deteminated by the OMS, but is OK
# 2929 Level 3          No deteminated by the OMS, but is OK
# 2930 Level 2 Developing in an inconsisten rate of increase
# 2931 Level 2 Developing in an inconsisten rate of increase
# 2932 Level 2          No deteminated by the OMS, but is OK
# 2933 Level 2          No deteminated by the OMS, but is OK
# 2934 Level 3          No deteminated by the OMS, but is OK
# 2935 Level 2          No deteminated by the OMS, but is OK
# 2936 Level 2          No deteminated by the OMS, but is OK
# 2937 Level 3 Developing in an inconsisten rate of increase
# 2938 Level 1 Developing in an inconsisten rate of increase
```

:::
