library(ggplot2)
library(gridExtra)
library(viridis)
# devtools::install_github("jbaileyh/geogrid")
library(geogrid)

input_file <- "~/gis/boundary/Data/GB/district_borough_unitary_region.shp"

original_shapes <- read_polygons(input_file)

raw <- read_polygons(input_file)
raw@data$xcentroid <- sp::coordinates(raw)[,1]
raw@data$ycentroid <- sp::coordinates(raw)[,2]

clean <- function(shape) {
  shape@data$id = rownames(shape@data)
  shape.points = fortify(shape, region="id")
  shape.df = merge(shape.points, shape@data, by="id")
}
# 
# result_df_raw <- clean(raw)
# rawplot <- ggplot(result_df_raw) +
#   geom_polygon(aes(x = long, y = lat, fill = HECTARES, group = group)) +
#   geom_text(aes(xcentroid, ycentroid, label = substr(NAME, 1, 4)), size = 2,color = "white") +
#   coord_equal() +
#   scale_fill_viridis() +
#   guides(fill = FALSE) +
#   theme_void()
# 
# rawplot
# 
# par(mfrow = c(2, 3), mar = c(0, 0, 2, 0))
# for (i in 1:6) {
#   new_cells <- calculate_grid(shape = original_shapes, grid_type = "regular", seed = i)
#   sp::plot(new_cells, main = paste("Seed", i, sep = " "))
# }


new_cells_reg <- calculate_grid(shape = original_shapes, grid_type = "regular", seed = 2)
resultreg <- assign_polygons(original_shapes, new_cells_reg)
result_df_reg <- clean(resultreg)
