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

::: {.example}
Seleccionar las columnas `Country`, `Year`, `Polio`, `Diph`, y agrupar la base de datos `WHO` por año (columna `Year`). Mostrar las primeras 6 filas.


```r
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

## Resúmenes estadísticos

## Reordenamiento

## Creación y transformación de columnas


## Combinar bases de datos

## Valores perdidos

## Ejercicios del capítulo


