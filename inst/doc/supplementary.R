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

## -----------------------------------------------------------------------------
net <- buildRepSeqNetwork(toy_data, "CloneSeq")
net <- addPlots(net, color_nodes_by = "SampleID")

## ---- eval = FALSE------------------------------------------------------------
#  net <- addNodeStats(net, stats_to_include = "all")

## ---- eval = FALSE------------------------------------------------------------
#  net <- addClusterStats(net, cluster_fun = "walktrap",
#                         cluster_id_name = "cluster_walktrap")

## -----------------------------------------------------------------------------
net <- addClusterMembership(net, 
                            cluster_fun = "leiden",
                            cluster_id_name = "cluster_leiden"
)
net <- addClusterMembership(net, 
                            cluster_fun = "louvain",
                            cluster_id_name = "cluster_louvain"
)

## -----------------------------------------------------------------------------
net <- addPlots(net,
                color_nodes_by = "cluster_louvain",
                color_scheme = "Viridis"
)
net <- labelClusters(net,
                     cluster_id_col = "cluster_louvain",
                     top_n_clusters = 7,
                     size = 7
)
net$plots$cluster_louvain

## -----------------------------------------------------------------------------
set.seed(42)
small_sample <- simulateToyData(1, sample_size = 10, prefix_length = 1)
net <- buildNet(small_sample, "CloneSeq", plot_title = NULL)
net <- labelNodes(net, "CloneSeq", size = 4)
net$plots[[1]]

## ---- eval = FALSE------------------------------------------------------------
#  saveNetwork(net, output_dir = dir_out, output_type = "individual")

## ---- eval = FALSE------------------------------------------------------------
#  saveNetworkPlots(net$plots, outfile = file.path(dir_out, "plots.pdf"))

## ---- eval = FALSE------------------------------------------------------------
#  dat <- loadDataFromFileList(list.files(my_dir), input_type = "rds")

## ---- eval = FALSE------------------------------------------------------------
#  loadDataFromFileList(list.files(my_dir),
#                       input_type = "table",
#                       read.args = list(
#                         header = TRUE,
#                         sep = " ",
#                         dec = ",",
#                         na.strings = "NA!",
#                         row.names = 1,
#                         col.names = c("RowID",
#                                       "CloneSeq", "CloneFrequency",
#                                       "CloneCount", "VGene"
#                         )
#                       )
#  )

## ---- eval = FALSE------------------------------------------------------------
#  save(df_sample1, file = file_1)
#  save(df_sample2, file = file_2)
#  save(df_sample3, file = file_3)
#  loadDataFromFileList(c(file_1, file_2, file_3),
#                       input_type = "rda",
#                       data_symbols = c("df_sample1",
#                                        "df_sample2",
#                                        "df_sample3"
#                       )
#  )

## ---- eval = FALSE------------------------------------------------------------
#  dat <- combineSamples(list.files(my_dir),
#                        input_type = "rds",
#                        min_seq_length = 7,
#                        drop_matches = "[*|_]",
#                        subset_cols = c("CloneSeq", "CloneCount", "VGene"),
#                        sample_ids = 1:5,
#                        subject_ids = c(1, 2, 2, 3, 3),
#                        group_ids = c(1, 1, 1, 2, 2)
#  )

## -----------------------------------------------------------------------------
filtered_data <- filterInputData(toy_data, 
                                 seq_col = "CloneSeq", 
                                 min_seq_length = 13,
                                 drop_matches = "GGGG", 
                                 subset_cols = c("CloneFrequency", "SampleID"),
                                 count_col = "CloneCount",
                                 verbose = TRUE
)

## ---- eval = FALSE------------------------------------------------------------
#  my_data <- data.frame(
#    clone_seq = c("ATCG", rep("ACAC", 2), rep("GGGG", 4)),
#    clone_count = rep(1, 7),
#    clone_freq = rep(1/7, 7),
#    time_point = c("t_0", rep(c("t_0", "t_1"), 3)),
#    subject_id = c(rep(1, 5), rep(2, 2))
#  )
#  
#  # group clones by time point and subject ID
#  data_agg_time_subject <-
#    aggregateIdenticalClones(my_data,
#                             clone_col = "clone_seq",
#                             count_col = "clone_count",
#                             freq_col = "clone_freq",
#                             grouping_cols = c("subject_id", "time_point")
#    )

## ---- eval = FALSE------------------------------------------------------------
#  nbd <- getNeighborhood(toy_data,
#                         seq_col = "CloneSeq",
#                         target_seq = "GGGGGGGAATTGG"
#  )

## ---- eval = FALSE------------------------------------------------------------
#  net <- generateNetworkObjects(toy_data, "CloneSeq")

## ---- eval = FALSE------------------------------------------------------------
#  net$igraph <- generateNetworkGraph(net$adjacency_matrix)

## ---- eval = FALSE------------------------------------------------------------
#  output$adjacency_matrix <- generateAdjacencyMatrix(toy_data$CloneSeq)
#  
#  # use same settings from original call to buildRepSeqNetwork()
#  net$adjacency_matrix <- generateAdjacencyMatrix(
#    net$node_data$CloneSeq,
#    dist_type = net$details$dist_type,
#    dist_cutoff = net$details$dist_cutoff,
#    drop_isolated_nodes = net$details$drop_isolated_nodes
#  )

## ----include=FALSE, eval = FALSE----------------------------------------------
#  # clean up temp directory
#  file.remove(
#    file.path(
#      tempdir(),
#      c("MyRepSeqNetwork_NodeMetadata.csv",
#        "MyRepSeqNetwork_ClusterMetadata.csv",
#        "MyRepSeqNetwork.pdf",
#        "MyRepSeqNetwork_EdgeList.txt",
#        "MyRepSeqNetwork_AdjacencyMatrix.mtx",
#        "MyRepSeqNetwork_Details.rds",
#        "MyRepSeqNetwork_Plots.rds",
#        "MyRepSeqNetwork_GraphLayout.txt",
#        "MyRepSeqNetwork.rds"
#      )
#    )
#  )

