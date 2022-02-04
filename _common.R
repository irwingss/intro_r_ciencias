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
  fig.retina=2,
  prompt=FALSE,
  comment="#",
  dev = "svg"
)

# Use dev = "svg" for PDF output
