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


# ANY WAY TO USE rayvertex FOR GGPLOTS? CAN IT BE ADDED TO LONG TUTORIAL TO PART THAT DOESN'T UPDATE?

## TEST 2
mat2 = material_list(diffuse="grey80", ambient="grey80", ambient_intensity = 0.2)
# initialize image
png("test_rayvertex_2.png")
# build scene
generate_cornell_mesh(ceiling=FALSE) %>% 
  add_shape(sphere_mesh(position=c(555,555,555)/2, radius=80, material=mat)) %>% 
  add_shape(segment_mesh(start=c(555/2,0,555/2),end=c(555/2,196,555/2), 
                         radius=30, material=mat2)) %>% 
  add_shape(cube_mesh(position=c(555/2,555/2-90,555/2), 
                      scale=c(160,20,160),material=mat2)) %>% 
  rasterize_scene(light_info = directional_light(c(0.4,0.2,-1)))
#> Setting default values for Cornell box: lookfrom `c(278,278,-800)` lookat `c(278,278,0)` fov `40` .
# Save image
dev.off()



