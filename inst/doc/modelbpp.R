## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width  =  6,
  fig.height =  6,
  fig.align = "center",
  fig.path = ""
)

## -----------------------------------------------------------------------------
library(modelbpp)
head(dat_serial_4_weak)

## -----------------------------------------------------------------------------
library(lavaan)
mod1 <-
"
m1 ~ x
m2 ~ m1
y ~ m2 + x
"
fit1 <- sem(mod1, dat_serial_4_weak)

## -----------------------------------------------------------------------------
summary(fit1,
        fit.measures = TRUE)

## ----echo = FALSE-------------------------------------------------------------
tmp <- fitMeasures(fit1)
fit1_cfi <- unname(tmp["cfi"])
fit1_rmsea <- unname(tmp["rmsea"])

## ----results = FALSE----------------------------------------------------------
out1 <- model_set(fit1)

## -----------------------------------------------------------------------------
out1

## ----echo = FALSE-------------------------------------------------------------
out1_bpp <- out1$bpp
out1_bpp_2 <- sort(out1_bpp, decreasing = TRUE)[2]

## ----graph1, fig.height = 8, fig.width = 8, eval = FALSE----------------------
#  graph1 <- model_graph(out1)
#  plot(graph1)

## ----results = FALSE----------------------------------------------------------
out1_prior <- model_set(fit1,
                        prior_sem_out = .50)

## -----------------------------------------------------------------------------
out1_prior

## ----out1_prior, fig.height = 8, fig.width = 8, eval = FALSE------------------
#  graph1_prior <- model_graph(out1_prior)
#  plot(graph1_prior)

## ----results = FALSE----------------------------------------------------------
out1_df2 <- model_set(fit1,
                      df_change_add = 2,
                      df_change_drop = 2)

## -----------------------------------------------------------------------------
out1_df2

## ----graph1_df2, fig.height = 8, fig.width = 8, eval = FALSE------------------
#  graph1_df2 <- model_graph(out1_df2,
#                            node_label_size = .75)
#  plot(graph1_df2)

## ----results = FALSE----------------------------------------------------------
out1_no_m1_x <- model_set(fit1,
                          must_not_drop = "m1~x")

## -----------------------------------------------------------------------------
out1_no_m1_x

## ----out1_no_m1_x, ig.height = 8, fig.width = 8, eval = FALSE-----------------
#  out1_no_m1_x <- model_graph(out1_no_m1_x)
#  plot(out1_no_m1_x)

## ----results = FALSE----------------------------------------------------------
out1_new_prior <- model_set(model_set_out = out1,
                            prior_sem_out = .50)

## -----------------------------------------------------------------------------
out1_new_prior

