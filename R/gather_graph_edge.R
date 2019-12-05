gather_graph_edge <- function(df,index=NULL){
  if (length(index) < 2){
    stop("please specify at least two index column(s)")
  } else if (length(index)==2){
    data <- df %>% mutate(from=.data[[index[[1]]]]) %>%
      unite(to,index,sep="/") %>%
      select(from,to) %>%
      mutate_at(c("from","to"),as.character) %>%
      mutate(edge.level=index[[1]])
  } else {
    list <- lapply(seq(2,length(index)), function(i){
      dots <- index[1:i]
      df %>% unite(from,dots[-length(dots)],sep = "/",remove = F)  %>%
        unite(to,dots,sep="/") %>%
        select(from,to) %>%
        mutate_at(c("from","to"),as.character) %>%
        mutate(edge.level=dots[[length(dots)-1]])
    })
    data <- do.call("rbind",list)
  }
  data <- as_tibble(data)
  data$edge.level <- factor(data$edge.level,levels = index)
  return(data)
}
