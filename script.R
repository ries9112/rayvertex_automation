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


## TEST 4 SCENE

png("test_rayvertex_4.png")

base_model = cube_mesh() %>%
  scale_mesh(scale=c(5,0.2,5)) %>%
  translate_mesh(c(0,-0.1,0)) %>%
  set_material(diffuse="white")

r_model = obj_mesh(r_obj()) %>%
  scale_mesh(scale=0.5) %>%
  set_material(diffuse="red") %>%
  add_shape(base_model)

lights = directional_light(c(0.7,1.1,-0.9),color = "orange",intensity = 0.7) %>%
  add_light(directional_light(c(0.7,1,1),color = "dodgerblue",intensity = 0.7)) %>%
  add_light(directional_light(c(2,4,10),color = "white",intensity = 0.3))

rasterize_scene(r_model, lookfrom=c(2,4,10),fov=20,
                light_info = directional_light(direction=c(0.8,1,0.7)))
#> Setting `lookat` to: c(0.00, 0.34, 0.00)

# Save image
dev.off()



## TEST 5 SCENE (WITH CHART)
# Make plot
# tempfileplot = tempfile()
# png(filename=tempfileplot,height=1600,width=1600)
# plot(iris$Petal.Length,iris$Sepal.Width,col=iris$Species,pch=18,cex=12)
# dev.off()
# # Make scene
# image_array = png::readPNG(tempfileplot)
# 
# # initialize model (none of these steps working)
# new_model = cube_mesh() %>%
#   scale_mesh(scale=c(5,0.2,5)) %>%
#   translate_mesh(c(0,-0.1,0)) %>%
#   set_material(diffuse="test.png")
# 
# 
# 
# generate_cornell_mesh() %>%
#   # add_shape(ellipsoid(x=555/2,y=100,z=555/2,a=50,b=100,c=50, material = metal(color="lightblue"))) %>%
#   # add_shape(cube(x=100,y=130/2,z=200,xwidth = 130,ywidth=130,zwidth = 130,
#   #                 material=diffuse(checkercolor="purple", checkerperiod = 30),angle=c(0,10,0))) %>%
#   # add_shape(pig(x=100,y=190,z=200,scale=40,angle=c(0,30,0))) %>%
#   # add_shape(sphere(x=420,y=555/8,z=100,radius=555/8,
#   #                   material = dielectric(color="orange"))) %>%
#   add_shape(new_model) %>% 
#                          
#                      # material = diffuse(image_texture = image_array))) %>%
#   # add_shape(yz_rect(x=555/2,y=300,z=555-0.01,zwidth=400,ywidth=400,
#   #                    material = diffuse(image_texture = image_array),angle=c(0,90,0))) %>%
#   # add_shape(yz_rect(x=555-0.01,y=300,z=555/2,zwidth=400,ywidth=400,
#   #                    material = diffuse(image_texture = image_array),angle=c(0,180,0))) %>%
#   rasterize_scene(lookfrom=c(278,278,-800),lookat = c(278,278,0), fov=40,
#                parallel=TRUE, width=800, height=800)
# 
# 
# 
# # Cleaned up version:
# generate_cornell_mesh() %>%
#   add_shape(yz_rect_mesh(position=c(555,555,555)/2,
#                          material = material_list(diffuse = "red"))) %>% 
#   rasterize_scene(lookfrom=c(278,278,-800),lookat = c(278,278,0), fov=40,
#                   parallel=TRUE, width=800, height=800)
# 
# 
# 
# # initialize model (not working) 
# new_model = rayvertex::obj_mesh("models/uploads_files_2939767_Trawa.obj", material = "models/uploads_files_2939767_Trawa.mtl") %>%
#   scale_mesh(scale=c(5,0.2,5)) %>%
#   translate_mesh(c(0,-0.1,0))




## TEST 5 RAYSHADER (plot_gg)
library(rayshader)
library(ggplot2)
ggdiamonds = ggplot(diamonds) +
  stat_density_2d(aes(x = x, y = depth, fill = stat(nlevel)),
                  geom = "polygon", n = 100, bins = 10, contour = TRUE) +
  facet_wrap(clarity~.) +
  scale_fill_viridis_c(option = "A")

par(mfrow = c(1, 2))

plot_gg(ggdiamonds, width = 5, height = 5, raytrace = FALSE, preview = TRUE)
plot_gg(ggdiamonds, width = 5, height = 5, multicore = TRUE, scale = 250,
        zoom = 0.7, theta = 10, phi = 30, windowsize = c(800, 800))
Sys.sleep(0.2)
render_snapshot(clear = TRUE)








