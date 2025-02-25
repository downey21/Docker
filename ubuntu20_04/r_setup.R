
# coding: utf-8

vector_package <-
    c(
        "languageserver",
        "httpgd",
        "dplyr",
        "tidyr",
        "stringr",
        "tibble",
        "lubridate",
        "ggsignif",
        "ggplot2"
    )

utils::install.packages(
    pkgs = vector_package,
    dependencies = TRUE,
    repos = "https://cran.yu.ac.kr/"
)