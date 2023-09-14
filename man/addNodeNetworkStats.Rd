\name{addNodeNetworkStats}
\alias{addNodeNetworkStats}
\title{
  Compute Node-Level Network Properties
}
\description{
  \if{html}{\figure{lifecycle-deprecated.svg}{options: width="35\%"}}

  Given the node metadata and \code{\link[igraph]{igraph}} for a network,
  computes a specified set of network properties for the network nodes.
  The node metadata is returned
  with each property added as a variable.

  This function was deprecated in favor of
  \code{\link[=addNodeStats]{addNodeStats()}}
  in NAIR 1.0.1.
  The new function accepts and returns the entire list of network
  objects returned by \code{\link[=buildRepSeqNetwork]{buildRepSeqNetwork()}}
  or by \code{\link[=generateNetworkObjects]{generateNetworkObjects()}}.
  It can compute cluster membership and add the values to the node metadata.
  It additionally updates the list element \code{details} with further
  information linking the node-level and cluster-level metadata.
}
\usage{
addNodeNetworkStats(
  data,
  net,
  stats_to_include = chooseNodeStats(),
  cluster_fun = "fast_greedy",
  cluster_id_name = "cluster_id",
  overwrite = FALSE,
  verbose = FALSE,
  ...
)

}
\arguments{
  \item{data}{
      A data frame containing the node-level metadata for the network, with each
      row corresponding to a network node.
}
  \item{net}{
      The network \code{\link[igraph]{igraph}}.
}
  \item{stats_to_include}{
      Specifies which network properties to compute.
      Accepts a vector created using
      \code{\link[=chooseNodeStats]{chooseNodeStats()}} or
      \code{\link[=exclusiveNodeStats]{exclusiveNodeStats()}},
      or the character string \code{"all"} to compute all network properties.
}
  \item{cluster_fun}{
      A character string specifying the clustering algorithm to use when
      computing cluster membership.
      Applicable only when \code{stats_to_include = "all"} or
      \code{stats_to_include["cluster_id"]} is \code{TRUE}.
      Passed to \code{\link[=addClusterMembership]{addClusterMembership()}}.
}
  \item{cluster_id_name}{
      A character string specifying the name of the cluster membership variable
      to be added to \code{data}.
      Applicable only when \code{stats_to_include = "all"} or
      \code{stats_to_include["cluster_id"]} is \code{TRUE}.
      Passed to \code{\link[=addClusterMembership]{addClusterMembership()}}.
}
  \item{overwrite}{
      Logical. If \code{TRUE} and \code{data} contains a variable whose
      name matches the value of \code{cluster_id_name}, then its values will be
      overwritten with new cluster membership values (obtained using
      \code{\link[=addClusterMembership]{addClusterMembership()}}
      with the specified value of \code{cluster_fun}).
      Applicable only when \code{stats_to_include = "all"} or
      \code{stats_to_include["cluster_id"]} is \code{TRUE}.
  }
  \item{verbose}{
      Logical. If \code{TRUE}, generates messages about the tasks
      performed and their progress, as well as relevant properties of intermediate
      outputs. Messages are sent to \code{\link[=stderr]{stderr()}}.
  }
  \item{...}{
      Named optional arguments to the function specified by \code{cluster_fun}.
  }
}
\details{
  Node-level network properties are properties that pertain to each individual
  node in the network graph.

  Some are local properties, meaning that their value for a given node depends only
  on a subset of the nodes in the network. One example is the network degree of a
  given node, which represents the number of other nodes that are directly joined
  to the given node by an edge connection.

  Other properties are global properties, meaning that their value for a given node
  depends on all of the nodes in the network. An example is the authority score of
  a node, which is computed using the entire graph adjacency matrix (if we denote
  this matrix by \eqn{A}, then the principal eigenvector of \eqn{A^T A} represents
  the authority scores of the network nodes).

  See \code{\link[=chooseNodeStats]{chooseNodeStats()}}
  for a list of the available node-level network properties.
}
\value{
  A copy of \code{data} with with an additional column for each
  new network property computed.
  See \code{\link[=chooseNodeStats]{chooseNodeStats()}}
  for the network property names,
  which are used as the column names,
  except for the cluster membership variable,
  whose name is the value of \code{cluster_id_name}.
}
\seealso{
\code{\link[=addNodeStats]{addNodeStats()}}
\code{\link[=chooseNodeStats]{chooseNodeStats()}}
}
\references{
Hai Yang, Jason Cham, Brian Neal, Zenghua Fan, Tao He and Li Zhang. (2023).
NAIR: Network Analysis of Immune Repertoire. \emph{Frontiers in Immunology},
vol. 14.
\href{https://www.frontiersin.org/articles/10.3389/fimmu.2023.1181825/full}{doi: 10.3389/fimmu.2023.1181825}

\href{https://mlizhangx.github.io/Network-Analysis-for-Repertoire-Sequencing-/index.html}{Webpage for the NAIR package}
}
\author{
    Brian Neal (\email{Brian.Neal@ucsf.edu})
}
\examples{
set.seed(42)
toy_data <- simulateToyData()

net <-
  generateNetworkObjects(
    toy_data,
    "CloneSeq"
  )

net$node_data <-
  addNodeNetworkStats(
    net$node_data,
    net$igraph
  )


}