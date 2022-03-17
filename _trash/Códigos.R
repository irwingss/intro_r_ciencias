bookdown::render_book("index.Rmd", "bookdown::bs4_book")
bookdown::render_book("index.Rmd", "bookdown::gitbook")

colorPal <- c("#8BC73D","#077173","#5CCAE2","#F2CD00","#CD001A","#5E36CC")
colorPal <- c("#b41214","#007588","#ffc000")
fillPal <- c("#ffdede","#d9faff","#fff6de")
colorPal <- c("#03071e","#dc2f02","#ffba08")
# BLOQUES DE COMENTARIOS, ADVERTENCIAS O DATO R

```{block2, type='rmdnote'}
NOTAS SOBRE EL CÓDIGO
```

```{block2, type='rmdtip'}
COMENTARIOS
```

```{block2, type='rmdwarning'}
ADVERTENCIAS
```

<div class="question">
  1. Pregunta
</div>

# Color de casilla de codigo
#background-image: linear-gradient(160deg,#f0fcfe 0,#fff7f7 100%);


```{r echo=FALSE, message=FALSE, warning=FALSE}
openxlsx::read.xlsx("bases/tabla1.xlsx")%>%
  kable(format = "pandoc", caption = 'Operaciones (símbolos) aritméticas en R')
```


<div class="question">
  1. Carga la base de datos `BOD` que muestra unos datos sencillos sobre demanda bioquímica de oxígeno (BOD en inglés). Calcula el promedio y desvición estándar de la columna `demand`. Utiliza la forma de código utilizando **dplyr** y sin usar **dplyr**.
</div>

  ```{r}
# Sin dplyr
mean(BOD$demand)
sd(BOD$demand)

# Con dplyr
```


::: {.theorem #pyth name="Pythagorean theorem"}
  For a right triangle, if $c$ denotes the length of the hypotenuse
  and $a$ and $b$ denote the lengths of the other two sides, we have

  $$a^2 + b^2 = c^2$$
    :::


::: {.lemma}
This is a `theorem` environment that can contain **any**
  _Markdown_ syntax.
:::

  ::: {.corollary}
This is a `theorem` environment that can contain **any**
  _Markdown_ syntax.
:::

  ::: {.conjecture}
This is a `theorem` environment that can contain **any**
  _Markdown_ syntax.
:::

  ::: {.definition}
This is a `theorem` environment that can contain **any**
  _Markdown_ syntax.
:::

  ::: {.example}
This is a `theorem` environment that can contain **any**
  _Markdown_ syntax.
:::

  ::: {.exercise}
This is a `theorem` environment that can contain **any**
  _Markdown_ syntax.
:::

  ::: {.hypothesis}
This is a `theorem` environment that can contain **any**
  _Markdown_ syntax.
:::


  ::: {.hypothesis}
This is a `theorem` environment that can contain **any**
  _Markdown_ syntax.
:::
