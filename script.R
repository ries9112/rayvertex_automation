library(rayvertex)

# initialize image
png("test_rayvertex.png")

# Example script
generate_cornell_mesh() %>% 
  rasterize_scene()

mat = material_list(diffuse="purple", type = "phong", ambient="purple", ambient_intensity = 0.2)

generate_cornell_mesh() %>% 
  add_shape(sphere_mesh(position=c(555,555,555)/2, radius=80, material=mat)) %>% 
  rasterize_scene()


# Save image
dev.off()

