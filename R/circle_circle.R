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
