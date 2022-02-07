bookdown::render_book("index.Rmd", "bookdown::bs4_book")
bookdown::render_book("index.Rmd", "bookdown::gitbook")

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
