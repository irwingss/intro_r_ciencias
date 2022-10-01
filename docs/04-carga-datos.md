# **Carga y exportación de datos**

En este capítulo corto, se abordarán los tópicos de carga y exportación de bases de datos. Si bien no se abordará la carga de todos los tipos posibles de archivos en RStudio, se cubrirán las extensiones esenciales para todo iniciante en el manejo de datos. Extensiones especiales como, `.shp` para la diagramación de mapas, no serán desarrollados en este libro.

(ref:carga1) Extensiones de archivos frecuentemente usados en R y RStudio. Más allá de lo mencionado aquí, existe una vasta cantidad de extensiones posibles de gestionar con RStudio. Dependiendo del campo de aplicación específico en el que te desarrolles, continuarás encontrando nuevas extensiones.

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{figs/elaboradas/Extensiones} 

}

\caption{(ref:carga1)}(\#fig:figura46)
\end{figure}

En adelante se espera que los archivos a cargar estén colocados dentro de la carpete de proyecto activa. De no ser el caso, se pueden buscar manualmente los archivos con una ventana emergente de búsqueda activada por la función `file.choose()`.

Por ejemplo, para leer un archivo `.csv` dentro de la carpeta de proyecto, se usa:


```r
misDatos <- read.csv("archivo.csv")
```

Con búsqueda manual, se recomienda emplear `file.choose()` en reemplazo del nombre del archivo:


```r
misDatos <- read.csv(file.choose())
```

(ref:emergente1) Vista previa de la venta emergente que se abre tras ejecutar el código mostrado anteriormente con `file.choose()`. Si no se muestra automáticamente, algunas veces se abre minimizada. Se recomienda buscar en los programas abiertos de la barra de tareas del sistema operativo en cuestión.

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{figs/screenshots/ventana emergente file choose} 

}

\caption{(ref:emergente1)}(\#fig:figura47)
\end{figure}

\BeginKnitrBlock{rmdwarning}
Nunca olvidar la extensión respectiva dentro de las comillas y al final del nombre del archivo (como en el ejemplo "archivo.csv" mostrado aneriormente). Si se coloca la extensión correcta, el archivo exportado será ilegible.
\EndKnitrBlock{rmdwarning}

## Lectura de bases de datos

### Archivos delimitados

Modo de uso de la función `read.csv()` para la carga de archivos delimitados por comas,  extensión `.csv`:


```r
### Argumentos a utilizar
read.csv("archivo.csv", # Nombre o ruta completa al archivo
         sep = ",",     # Separador de los valores
         dec = ".",     # Punto decimal
         header = TRUE, # Leer el encabezado (TRUE) o no (FALSE)
         fill = TRUE)   # Rellenar celdas vacías: sí (TRUE, por defecto) o no (FALSE)
```

Los argumentos por defecto de `read.csv()` permiten cargar un archivo con encabezados, rellenar las celdas vacías con NA (recomendado), con el separador de celdas coma `,` y el separador de decimales `.`. Si el documento de interés tiene estas características, bastará con colocar lo siguiente para cargarlo:


```r
read.csv("datos_investig.csv")
```

Modo de uso de la función `read.csv()` para la carga de archivos delimitados por comas,  extensión `.csv`:


```r
### Argumentos a utilizar
read.csv("archivo.csv", # Nombre o ruta completa al archivo
         sep = ",",     # Separador de los elementos
         dec = ".",     # Separador decimal
         header = TRUE, # Leer el encabezado (TRUE, por defecto) o no (FALSE)
         fill = TRUE)   # Rellenar celdas vacías: sí (TRUE, por defecto) o no (FALSE)
```

Por otro lado, existe `read.csv2()` que hace lo mismo que la anterior, pero para tablas que cuenten con el separador de celdas punto y coma `;` y el separador de decimales `,`. Todo dependerá de cómo esté configurado tu archivo original.


```r
read.csv2("datos_investig2.csv")
```

Otros argumentos interesantes en ambas funciones son:


```r
### Para definir qué valores sean considerados como NA (y no solo las celdas vacías)
read.csv2("datos_investig3.csv", na.strings = c("Na", "NA", "-9999"))

### Para coercer las columnas de texto a factor al leer el documento
read.csv2("datos_investig3.csv", stringsAsFactos = TRUE)

### Para no cargar ciertas filas del documento (por ejemplo la fila 10)
read.csv2("datos_investig3.csv", skip = 10)
```

### Archivos tabulados

Modo de uso de la función `read.table()` para la carga de archivos delimitados por tabulaciones,  extensión `.txt`:


```r
### Argumentos a utilizar
read.table("archivo.txt", # Nombre o ruta completa al archivo
         sep = "",        # Separador de los elementos
         dec = ".",       # Separador decimal
         header = FALSE)   # Leer el encabezado (TRUE) o no (FALSE, por defecto)
```

Otros argumentos interesantes son idénticos a los encontrados en las funciones mostradas anteriormente:


```r
### Para definir qué valores sean considerados como NA (y no solo las celdas vacías)
read.table("datos_investig3.txt", na.strings = c("Na", "NA", "-9999"))

### Para coercer las columnas de texto a factor al leer el documento
read.table("datos_investig3.txt", stringsAsFactos = TRUE)

### Para no cargar ciertas filas del documento (por ejemplo la fila 10)
read.table("datos_investig3.txt", skip = 10)
```

### Archivos delimitados con otros caracteres

Una función versátil es `read.delim()` y su compañera `read.delim2()`. Ambas permiten cargar archivos delimitados por cualquier carácter. Realizan carga de archivos tal y como lo hacen `read.csv()`, `read.csv2()` o `read.table()`.


```r
read.delim("archivo.txt", # Nombre o ruta completa al archivo (puede ser .csv también)
         sep = "\t",      # Separador de columnas
         dec = ".",       # Separador decimal
         header = TRUE,  # Leer el encabezado (TRUE, por defecto) o no (FALSE)
         fill = TRUE)     # Rellenar celdas vacías: sí (TRUE, por defecto) o no (FALSE)

read.delim2("archivo.txt", # Nombre o ruta completa al archivo (puede ser .csv también)
         sep = "\t",      # Separador de columnas
         dec = ",",       # Separador decimal
         header = TRUE,  # Leer el encabezado (TRUE, por defecto) o no (FALSE)
         fill = TRUE)     # Rellenar celdas vacías: sí (TRUE, por defecto) o no (FALSE)
```

Cuando se define el `sep = "\t"` leen archivos tabulados; `sep = " "`, separados por espacios; `sep = ","`, separados por comas; o `sep = ";"`, separados por punto y coma. Se podrá colocar el separador respectivo en caso sea uno diferente a los mencionados.

### Hojas de cálculo de Excel

Existen varias librerías para cargar archivos de excel en R, con extensión `.xlsx`. Se recomienda el uso de la librería **openxlsx**, por su simplicidad de uso y porque no demanda de instalaciones adicionales de otros programas.


```r
library(openxlsx)
read.xlsx("archivo.xslx", # Nombre o ruta completa al archivo
          colNames = TRUE, # Leer el encabezado (TRUE, por defecto) o no (FALSE)
          na.strings = c("Na", "NA", "-9999"), # Valores a ser considerados como NA
          sep.names = ".") # Rellena los espacios de los nombres de columnas con .
```

\BeginKnitrBlock{rmdnote}
Es mucho más fácil trabajar con archivos con extensión .xlsx. Si forzosamente se debe abrir un archivo .xls (más antiguo), utiliza: `readxl::read_xls("archivo.xls")`
\EndKnitrBlock{rmdnote}

### Bases de datos de R

Los archivos de extensión `.rda` son la forma más sencilla de compartir bases de datos que solo serán abiertas en el entorno de R. No son leídas con otro programa. Lo interesante de estas bases es que almacenan el nombre del objeto original con el que fueron creadas en R. Una vez cargas el archivo con la función `load()`, el objeto aparecerá en el ambiente con su nombre original (no necesariamente el mismo nombre que el archivo.rda):


```r
load("archivo.rda")
```

\BeginKnitrBlock{rmdtip}
También existen archivos `.RData` que aparecen automáticamente uno crea un proyecto. Estos son los archivos que almacenan el ambiente de un proyecto, es decir, todas las variables creadas durante la sesión de RStudio, y que fueron guardadas al cerrar esta misma.
\EndKnitrBlock{rmdtip}

### Archivos de SPSS

En algunas ocasiones, los investigadores que manejen SPSS querrán abrir sus archivos de datos, con extensión `.SAV`, para generar gráficos o análisis en R. Esto es posible gracias a la integración realizada por una librería de **tidyverse** llamada **haven**:


```r
library(haven)
read_sav("archivo.SAV")
```


## Exportar basas de datos

Exportar archivos desde R es tarea sencilla. Se listan a continuación las funciones de exportación de los formatos descritos en la sección anterior.


```r
### Exportar a .csv
write.csv(objeto,              # Objeto del ambiente a exportar
          "nombre nuevo.csv",  # Nombre del archivo a generar
          row.names = FALSE)   # Incluir (TRUE) o no (FALSE, por defecto) 
                               # los nombres de las filas en el archivo final

### Exportar a .txt
write.delim(objeto,              # Objeto del ambiente a exportar
            "nombre nuevo.txt",  # Nombre del archivo a generar
            sep="\t")            # Separador de columnas

### Exportar a .xlsx
library(openxlsx)
write.xlsx(objeto,              # Objeto del ambiente a exportar
           "nombre nuevo.xlsx")  # Nombre del archivo a generar)

### Exportar a .rda
save(objeto,              # Objeto del ambiente a exportar
     file = "nombre nuevo.rda")  # Nombre del archivo a generar)

# Exportar a .SAV
library(haven)
write_sav(objeto, "nombre nuevo.sav")
```
