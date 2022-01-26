---
site: bookdown::bookdown_site
output:
  bookdown::gitbook
title: "Introducción a R para Ciencias"
subtitle: "Una gentil introducción al mundo de <br>la programación para investigadores"
author: "Irwing S. Saldaña"
description: "Libro introductorio al uso del lenguaje de programación R, con ejemplos orientados a ciencias"
date: "2022-01-26"
bibliography: [book.bib, packages.bib]
biblio-style: apalike
colorlinks: yes
graphics: yes
lot: yes
lof: yes
link-citations: yes
cover-image: 'Cover/cover R.png'
favicon: 'figs/favicon.ico'
url: 'https\://github.com/irwingss/intro_r_ciencias/'
github-repo:  'irwingss/intro_r_ciencias/'
---



# **Bienvenida** {-}

<a href="https://www.brackinstitute.com"><img src="Cover/cover R.png" width="281" height="398" alt="Cover image" align="right" style="margin: 1em 1em 1em 1em;" /></a> 

<br>
Esta es la página web del libro _Introducción a R para Ciencias_, publicado por [IC Press](https://www.brackinstitute.com/editorial), Fondo Editorial del Instituto de Ciencias Antonio Brack. Para solicitar una copia electrónica del libro en formato PDF, hacerlo a través de [Amazon](https://www.amazon.com/) o [IC PRESS](https://www.brackinstitute.com/editorial). 

Este libro busca:

- Democratizar el uso del lenguaje de programación R en investigación científica, a través de una explicación amigable, con ejemplos sencillos y ejercicios de refuerzo.

- Ser el libro de referencia de los primeros módulos del programa _Data Science: Análisis Estadístico para Ciencias con R_, el cual contiene cinco cursos dictados por el profesor [Irwing S. saldaña](https://scholar.google.com/citations?user=ZvRX_U0AAAAJ) en el [Instituto de Ciencias Antonio Brack](https://www.brackinstitute.com/) a través de la plataforma educativa online [masterX](https://www.masterx.org/). 

En tal sentido, para usar este libro, no se necesita saber de antemano el lenguaje de programación R ni conocimientos estadísticos.

Este libro ha sido completamente escrito en [R Markdown](https://bookdown.org/yihui/rmarkdown/), utilizando [RStudio](https://www.rstudio.com/). Si tienes alguna sugerencia, o detectas algún fallo ortográfico, error de forma o de fondo, por favor envia un mensaje a `isaldanau@gmail.com` con el asunto de correo "Corrección Libro Estadística".

Esta página web es de _libre uso dentro de los términos autorizados_ bajo la [Licencia Internacional Reconocimiento No Comercial - Sin Derivadas 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode). Además, esta obra utiliza un [Código de conducta para colaboradores](https://www.contributor-covenant.org/version/2/0/code_of_conduct/). Al contribuir a este libro, acepta cumplir sus términos. Finalmente, esta obra está alojada en [Netlify](https://www.netlify.com), con código abierto disponible en [Github](https://github.com/irwingss/libro-eadc).

> La **portada del libro** ha sido creada utilizando una fotografía de acceso abierto de <a href="https://unsplash.com/@pawel_czerwinski?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Pawel Czerwinski</a> publicada en <a href="https://unsplash.com/s/photos/abstract?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>.


Photo by <a href="">Pawel Czerwinski</a> on <a href="">Unsplash</a>
  
  
## **El paquete del libro** {-}

<img src="Cover/logo rbrack.png" width="40%" style="display: block; margin: auto;" />

Las bases de datos y funciones de soporte del programa de estudios aquí propuesto están disponibles en el paquete `rbrack`, disponible en el [repositorio de Github]().

Si no conoces como ejecutar código, puedes revisar la sección [2.1 Ejecutar código](#ejecutar-código), y sigue las instrucciones mencionadas a continuación.

**El paso a paso:**

1. Abrir RStudio.
2. En el teclado presionar: `Control + shift + N` o `Command + shift + N`. Esto creará un nuevo R script (para más información, revisa: [Tipos de documentos en RStudio](#tipos-de-documentos-en-rstudio)).
3. Copiar en el R script el código mostrado a continuación. 


```r
# Instalar la librería del libro
install.packages("devtools")
devtools::install_github("irwingss/rbrack")

# Activar la librería
libraries(rBrack)

# Ejecutar las funciones
instalar_paquetes_cran()
instalar_paquetes_github()

# Actualizar las librerías
update.packages(ask = FALSE)
```

4. Ejecutar el código (para más información, revisa: [Ejecutar código](#ejecutar-código)) hasta la función `instalar_paquetes_github()`.
5. Una vez estén todas las librerías instaladas, se debe ejecutar la última función `update.packages()` para actualizar las que se encuentren desactualizadas.


## **¿Cómo usar el libro?** {-}

El libro cuenta con capítulos secuenciales. Si es tu primera vez con R, se sugiere continuar la secuencia. La información está organizada de manera que permita al lector identificar la teoría y ejemplos, junto con ciertos contenidos resaltados como se muestra a continuación:

\BeginKnitrBlock{rmdnote}<div class="rmdnote">**NOTAS SOBRE EL CÓDIGO:** brindan ayuda respecto al código. Incluye comandos adicionales, sugerencias o alternativas para escribir de manera más sencilla y clara en el lenguaje R.</div>\EndKnitrBlock{rmdnote}

\BeginKnitrBlock{rmdtip}<div class="rmdtip">**COMENTARIOS:** con aclaraciones y mensajes que ayudarán a entender mejor lo explicado.</div>\EndKnitrBlock{rmdtip}

\BeginKnitrBlock{rmdwarning}<div class="rmdwarning">**ADVERTENCIAS:** de índole metodológica, técnica, o sobre alguna particularidad del código.</div>\EndKnitrBlock{rmdwarning}

# **Prefacio** {-}

## **¿Por qué aprender R?** {-}

Sin importar tu carrera de origen, es más que seguro nunca pensaste que algún día terminarías queriendo aprender a programar. Esta necesidad se está haciendo cada vez más frecuentes entre profesionales de distintas ramas de la ciencia. Las razones de aprender a programar pueden ser diversas, pero casi siempre se centran en la necesidad de analizar datos, hacer ciencia, participar en un grupo de investigación, o para tener herramientas analíticas para el doctorado. Pero ¿Por qué R?.

(ref:porquer1) Fortalezas que presenta el lenguaje de programación R y lo destacan por sobre otros lenguajes como Python o Julia.

<div class="figure" style="text-align: center">
<img src="figs/elaboradas/Por que R.png" alt="(ref:porquer1)" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-6)(ref:porquer1)</p>
</div>

R es uno de los lenguajes más populares para ciencia de datos e investigación científica. Es considerado uno de los lenguajes de programación más sencillos de aprender. Tres razones técnicas por las cuales aprender R por sobre otros lenguajes implican:

- Estuvo orientado al desarrollo estadístico desde su concepción. Casi cualquier análisis puede ejecutarse con él.

- No necesita compilarse para interpretarse. Es suficiente con usar un interprete como RStudio para que las órdenes se ejecuten.

- Una de las particularidades del lenguajes que es basado en vectores. Esto simplifica el uso de funciones hacia conjuntos de datos, haciendo del lenguaje  rápido en procesamientos básicos.

- Su amplia comunidad de desarrollo genera constantemente paquetes, manteniendo a los usuarios en la vanguardia del avance científico. 

- Cuenta con una comunidad de soporte enorme en plataformas como [StackOverflow](https://stackoverflow.com/), [RStudio Community](https://community.rstudio.com/), [R-Bloggers](https://www.r-bloggers.com/).

- Masiva cantidad de repositorios en la nube como [GitHub](https://github.com/), [GitLab](https://gitlab.com/) o [Bioconductor](https://www.bioconductor.org/) donde se alberga toda la información que ha sido alguna vez creada y publicada con R.

## **¿A quién está dirigido este libro?** {-}

El libro está planeado para llevarte desde cero en el manejo del lenguaje de programación R, sin importar el campo de la ciencia del que provengas. Los capítulos están diseñados para ser independientes entre sí. Siéntete libre de saltar entre los capítulos y seleccionar aquellos que sean de tu interés en el momento, si ya dominas conceptos más básicos. 

La progresión temática está adaptada a los primeros cursos del programa [Data Science: Estadística y Análisis de Datos en R](https://www.masterx.org/bundle/data-science-r), ofrecido por el autor del libro, [Irwing S. Saldaña](https://github.com/irwingss), a través del [Instituto de Ciencias Antonio Brack](https://www.brackinstitute.com/). El programa comenzó a ser dictado en 2020, y ha recibido a estudiantes de diferentes partes de Latinoamérica, El Caribe y España, de diversos perfiles profesionales: biólogos, médicos y otros profesionales de la salud, ingenieros, psicólogos, entre otros; además, profesionales de otras ramas no tan afines a las ciencias, como economistas, tecnólogos o especialistas en finanzas. 

## **Agradecimientos** {-}

<span style="color:red;">**FALTA**</span>
