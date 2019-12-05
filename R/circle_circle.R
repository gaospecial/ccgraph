#' calculate circle_circle layout manually
#'
#' @param layout
#' @param index
#'
#' @return
#' @export
#'
#' @examples
#'   libray(tidygraph)
#'   n <- 1000
#'   microbiome <- data.frame(
#'     otu = paste("OTU",1:n,sep="_"),
#'     phylum = sample(paste("phylum",1:5,sep="_"),n,replace = T),
#'     class = sample(paste("class",6:30,sep="_"),n,replace=T),
#'     order = sample(paste("order",31:80,sep="_"),n,replace = T),
#'     value = runif(n,min=1,max=1000)
#'   )
#'   index_micro <- c("phylum","class","order")
#'   nodes_micro <- gather_graph_node(microbiome,index=index_micro, root="Bac")
#'   edges_micro <- gather_graph_edge(microbiome,index=index_micro, root="Bac")
#'   graph_micro <- tbl_graph(nodes_micro,edges_micro)
#'   layout_micro <- create_layout(graph_micro,layout = "circle")
#'   layout <- circle_circle(layout_micro,index=index_micro)
circle_circle <- function(layout,index=NULL){
  if (is.null(index)){
    warning("index is NULL, do nothing")
    return(layout)
  }
  list <- lapply(seq_along(index),function(i){
    idx <- index[[i]]
    layout %>%
      filter(node.level==idx) %>%
      arrange(node.branch,node.short_name) %>%
      mutate(x=cos((cumsum(node.count)-node.count*0.5)/sum(node.count)*2*pi)*i,
             y=sin((cumsum(node.count)-node.count*0.5)/sum(node.count)*2*pi)*i)
  })
  layout[] <- do.call(bind_rows,list)
  return(layout)
}
