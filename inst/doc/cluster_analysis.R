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
net <- buildRepSeqNetwork(toy_data, "CloneSeq", cluster_stats = TRUE)

## ---- eval = FALSE------------------------------------------------------------
#  net <- buildNet(toy_data, "CloneSeq")
#  
#  net <- addClusterStats(net)

## -----------------------------------------------------------------------------
head(net$node_data$cluster_id)

## -----------------------------------------------------------------------------
names(net)

## -----------------------------------------------------------------------------
nrow(net$cluster_data)

## -----------------------------------------------------------------------------
names(net$cluster_data)

## -----------------------------------------------------------------------------
head(net$cluster_data[ , 1:6])

## -----------------------------------------------------------------------------
net <- buildNet(toy_data, "CloneSeq", 
                cluster_stats = TRUE, 
                count_col = "CloneCount"
)

## ---- eval = FALSE------------------------------------------------------------
#  net <- buildNet(toy_data, "CloneSeq")
#  net <- addClusterStats(net, count_col = "CloneCount")

## -----------------------------------------------------------------------------
net$details$count_col_for_cluster_data

## ---- eval = FALSE------------------------------------------------------------
#  net <- buildRepSeqNetwork(toy_data, "CloneSeq",
#                            cluster_stats = TRUE,
#                            cluster_fun = "leiden"
#  )

## ---- eval = FALSE------------------------------------------------------------
#  net <- buildRepSeqNetwork(toy_data, "CloneSeq")
#  net <- addClusterStats(net,
#                         cluster_fun = "leiden",
#                         beta = 0.02,
#                         n_iterations = 3
#  )

## ---- eval = FALSE------------------------------------------------------------
#  net <- buildRepSeqNetwork(toy_data, "CloneSeq")
#  net <- addClusterMembership(net,
#                              cluster_fun = "leiden",
#                              beta = 0.02,
#                              n_iterations = 3
#  )

## -----------------------------------------------------------------------------
# First instance of clustering
net <- buildRepSeqNetwork(toy_data, "CloneSeq", 
                          print_plots = FALSE, 
                          cluster_stats = TRUE, 
                          cluster_id_name = "cluster_greedy"
)

# Second instance of clustering
net <- addClusterMembership(net,
                            cluster_fun = "louvain",
                            cluster_id_name = "cluster_louvain"
)

## -----------------------------------------------------------------------------
net <- addPlots(net,
                color_nodes_by = c("cluster_greedy", "cluster_louvain"),
                color_scheme = "Viridis",
                size_nodes_by = 1.5,
                print_plots = TRUE
)

## -----------------------------------------------------------------------------
net$details

## -----------------------------------------------------------------------------
# First instance of clustering
net <- buildNet(toy_data, "CloneSeq", 
                print_plots = FALSE, 
                cluster_stats = TRUE, 
                cluster_id_name = "cluster_greedy",
                color_nodes_by = "cluster_greedy",
                color_scheme = "Viridis",
                size_nodes_by = 1.5,
                plot_title = NULL
)
# Second instance of clustering
net <- addClusterMembership(net,
                            cluster_fun = "louvain",
                            cluster_id_name = "cluster_louvain"
)
net <- addPlots(net,
                color_nodes_by = "cluster_louvain",
                color_scheme = "Viridis",
                size_nodes_by = 1.5,
                print_plots = FALSE
)
# Label the clusters in each plot
net <- labelClusters(net,
                     plots = "cluster_greedy",
                     cluster_id_col = "cluster_greedy",
                     top_n_clusters = 7,
                     size = 7
)
net <- labelClusters(net,
                     plots = "cluster_louvain",
                     cluster_id_col = "cluster_louvain",
                     top_n_clusters = 7,
                     size = 7
)

net$plots$cluster_greedy
net$plots$cluster_louvain

