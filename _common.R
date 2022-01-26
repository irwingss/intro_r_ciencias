library(tidyverse)
library(knitr)
library(kableExtra)

options(digits = 4, width = 84)
options(dplyr.print_min = 6, dplyr.print_max = 6)
options(cli.width = 85)
options(crayon.enabled = FALSE)

knitr::opts_chunk$set(
  echo = TRUE,
  collapse = TRUE,
  fig.align = 'center',
  tidy = FALSE,
  fig.retina=2
)



theme_transparent <- function(...) {

  ret <- ggplot2::theme_bw(...)

  trans_rect <- ggplot2::element_rect(fill = "transparent", colour = NA)
  ret$panel.background  <- trans_rect
  ret$plot.background   <- trans_rect
  ret$legend.background <- trans_rect
  ret$legend.key        <- trans_rect

  ret$legend.position <- "top"

  ret
}

theme_set(theme_transparent())
