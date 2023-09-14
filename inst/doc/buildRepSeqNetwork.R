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
net <- buildNet(toy_data, "CloneSeq")

## ---- eval = FALSE------------------------------------------------------------
#  net <- buildNet(toy_data, "CloneSeq", min_seq_length = 10)

## ---- eval = FALSE------------------------------------------------------------
#  net <- buildNet(toy_data, "CloneSeq", drop_matches = "\\W")

## ---- eval = FALSE------------------------------------------------------------
#  net <- buildNet(toy_data, "CloneSeq", dist_type = "lev")

## ---- eval = FALSE------------------------------------------------------------
#  net <- buildNet(toy_data, "CloneSeq", dist_cutoff = 0)

## ---- eval = FALSE------------------------------------------------------------
#  net <- buildNet(toy_data, "CloneSeq", drop_isolated_nodes = FALSE)

## -----------------------------------------------------------------------------
net <- buildNet(toy_data, "CloneSeq", node_stats = TRUE)

## ---- eval = FALSE------------------------------------------------------------
#  net <- buildNet(toy_data, "CloneSeq", cluster_stats = TRUE)

## -----------------------------------------------------------------------------
net <- buildNet(toy_data, "CloneSeq",
                node_stats = TRUE,
                color_nodes_by = c("SampleID", "transitivity", "coreness"),
                color_scheme = c("default", "plasma-1", "mako-1"),
                color_title = c("", "Transitivity", "Coreness"),
                size_nodes_by = "degree",
                node_size_limits = c(0.1, 1.5),
                plot_title = NULL,
                plot_subtitle = NULL,
                print_plots = TRUE
)

## -----------------------------------------------------------------------------
names(net)

## -----------------------------------------------------------------------------
net$details

## -----------------------------------------------------------------------------
head(net$node_data)

## -----------------------------------------------------------------------------
names(net$plots)

## -----------------------------------------------------------------------------
class(net$plots$uniform_color)

## ---- eval = FALSE------------------------------------------------------------
#  library(magrittr) # For pipe operator (%>%)
#  toy_data %>%
#    filterInputData("CloneSeq", drop_matches = "\\W") %>%
#    buildNet("CloneSeq") %>%
#    addNodeStats("all") %>%
#    addClusterMembership("greedy", cluster_id_name = "cluster_greedy") %>%
#    addClusterMembership("leiden", cluster_id_name = "cluster_leiden") %>%
#    addClusterStats("cluster_leiden", "CloneSeq", "CloneCount") %>%
#    addPlots(color_nodes_by = c("cluster_leiden", "cluster_greedy"),
#             color_scheme = "Viridis"
#    ) %>%
#    labelClusters("cluster_leiden", cluster_id_col = "cluster_leiden") %>%
#    labelClusters("cluster_greedy", cluster_id_col = "cluster_greedy") %>%
#    saveNetwork(output_dir = tempdir(), output_name = "my_network")

