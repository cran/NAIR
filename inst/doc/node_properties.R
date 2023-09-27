## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.align = "center", 
  out.width = "100%",
  fig.width = 9, fig.height = 7
)

## -----------------------------------------------------------------------------
set.seed(42)
library(NAIR)
dir_out <- tempdir()

toy_data <- simulateToyData()
head(toy_data)

## -----------------------------------------------------------------------------
nrow(toy_data)

## -----------------------------------------------------------------------------
# build network with computation of node-level network properties
net <- buildNet(toy_data, "CloneSeq", 
                node_stats = TRUE
)

## ----eval = FALSE-------------------------------------------------------------
#  net <- buildNet(toy_data, "CloneSeq")
#  
#  net <- addNodeStats(net)

## -----------------------------------------------------------------------------
names(net$node_data)

## -----------------------------------------------------------------------------
head(net$node_data[ , c("CloneSeq", "degree", "authority_score")])

## ----eval = FALSE-------------------------------------------------------------
#  # Modifying the default set of node-level properties
#  net <- buildNet(toy_data, "CloneSeq",
#                  node_stats = TRUE,
#                  stats_to_include =
#                    chooseNodeStats(closeness = TRUE,
#                                    page_rank = FALSE
#                    )
#  )

## ----eval = FALSE-------------------------------------------------------------
#  # Include only the node-level properties specified below
#  net <- buildNet(toy_data, "CloneSeq",
#                  node_stats = TRUE,
#                  stats_to_include =
#                    exclusiveNodeStats(degree = TRUE,
#                                       transitivity = TRUE
#                    )
#  )

