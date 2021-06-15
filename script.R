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



## TEST 3
library(Rvcg)

png("test_rayvertex_3.png")

data(humface)

cols = hsv(seq(0,1,length.out=6))

mats = list()
for(i in 1:5) {
  mats[[i]] = material_list(diffuse=cols[i], ambient=cols[i], type="phong",
                            ambient_intensity = 0.2)
}

generate_cornell_mesh(ceiling=FALSE) %>%
  add_shape(sphere_mesh(position=c(555,555,555)/2, radius=80, material=mat)) %>%
  add_shape(segment_mesh(start=c(555/2,0,555/2),end=c(555/2,196,555/2),
                         radius=30, material=mat2)) %>%
  add_shape(cube_mesh(position=c(555/2,555/2-90,555/2),
                      scale=c(160,20,160),material=mat2)) %>%
  add_shape(torus_mesh(position=c(100,100,100), radius = 50, ring_radius = 20,
                       angle=c(45,0,45),material=mats[[1]])) %>%
  add_shape(cone_mesh(start=c(555-100,0,100), end=c(555-100,150,100), radius = 50,
                      material=mats[[2]])) %>%
  add_shape(arrow_mesh(start=c(555-100,455,555-100), end=c(100,455,555-100),
                       radius_top = 50, radius_tail=10, tail_proportion = 0.8,
                       material=mats[[3]])) %>%
  add_shape(obj_mesh(r_obj(), position=c(100,200,555/2), angle=c(-10,200,0),
                     scale=80,material=mats[[4]])) %>%
  add_shape(mesh3d_mesh(humface, position = c(555-80,220,555/2),scale = 1,
                        material=mats[[5]],angle=c(0,180,-30))) %>% 
  rasterize_scene(light_info = directional_light(c(0.4,0.2,-1)))
#> Setting default values for Cornell box: lookfrom `c(278,278,-800)` lookat `c(278,278,0)` fov `40` .

# Save image
dev.off()


