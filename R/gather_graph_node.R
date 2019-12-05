gather_graph_node <- function(df,index=NULL,value=tail(colnames(df),1)){
  if (length(index) < 2){
    stop("please specify at least two index column(s)")
  } else {
    list <- lapply(seq_along(index), function(i){
      dots <- index[1:i]
      df %>%
        group_by(.dots=dots) %>%
        summarise(node.size=sum(.data[[value]]),
                  node.level=index[[i]],
                  node.count=n()) %>%
        mutate(node.short_name=as.character(.data[[ dots[[length(dots)]] ]]),
               node.branch = as.character(.data[[ dots[[1]]]])) %>%
        unite(node.name,dots,sep = "/")
    })
    data <- do.call("rbind",list) %>% as_tibble()
    data$node.level <- factor(data$node.level,levels = index)
    return(data)
  }
}
