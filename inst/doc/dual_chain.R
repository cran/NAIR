## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE, warning = FALSE, message = FALSE, collapse = TRUE, comment = "#>", 
  fig.align = "center", fig.width = 10, fig.height = 10, out.width = "100%")

## -----------------------------------------------------------------------------
set.seed(42)
library(NAIR)

dat <- simulateToyData(chains = 2)
head(dat)

## -----------------------------------------------------------------------------
# Build network based on joint dual-chain similarity
network <- buildNet(dat, 
                    seq_col = c("AlphaSeq", "BetaSeq"),
                    count_col = "UMIs",
                    node_stats = TRUE, 
                    stats_to_include = "all",
                    cluster_stats = TRUE, 
                    color_nodes_by = "SampleID",
                    size_nodes_by = "UMIs",
                    node_size_limits = c(0.5, 3)
)

## -----------------------------------------------------------------------------
addClusterLabels(network$plots$SampleID, network, top_n_clusters = 2, size = 8)

## -----------------------------------------------------------------------------
names(network)

## -----------------------------------------------------------------------------
head(network$cluster_data)

