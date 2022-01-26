
install.packages("captioner")
#https://www.r-bloggers.com/2016/09/r-markdown-how-to-number-and-reference-tables/
table_nums <- captioner::captioner(prefix = "Tab.")

tab.1_cap <- table_nums(name = "tab_1",
                        caption = "German Bundesliga: Final Table 2015/16, Position 7-12")
tab.2_cap <- table_nums(name = "tab_2",
                        caption = "German Bundesliga: Final Table 2015/16, Position 12-18")


# Incluir simbolos en tablas
# https://stackoverflow.com/questions/66292455/latex-code-inside-a-kable-table-in-an-rmarkdownbeamer-presentation
