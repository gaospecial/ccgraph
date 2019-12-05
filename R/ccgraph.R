ccgraph <- function(layout,index){
  xylim <- c(-1,1)*length(index)
  ggraph(layout) +
    geom_edge_diagonal(aes(edge_color=node1.node.branch,
                           edge_alpha=as.factor(edge.level)) ) +
    geom_node_point(aes(size=node.size,color=node.branch,alpha=as.factor(node.level)),alpha=1/3) +
    geom_node_text(
      aes(
        x = 1.0175 * x,
        y = 1.0175 * y,
        label = node.short_name,
        angle = -((-node_angle(x, y) + 90) %% 180) + 90,
        filter = (node.level == index[[length(index)]]),
        color = node.branch
      ),
      size = 1, hjust = 'outward'
    ) +
    geom_node_text(
      aes(
        x = x,
        y = y,
        label = node.short_name,
        filter = (node.level == index[[1]])
      ),
      size = 4, hjust = 0.5,  fontface="bold"
    ) +
    scale_size_area(max_size = 50) +
    theme_void() +
    theme(legend.position = "none") +
    coord_equal()
}
