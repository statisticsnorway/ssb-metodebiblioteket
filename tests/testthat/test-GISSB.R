#### shortest_path_cppRouting ####

testthat::test_that("Testing shortest_paths_cppRouting", {
  library(GISSB)
  data("vegnett_sampledata")
  vegnett <- vegnett_sampledata
  
  vegnett_list <- vegnett_to_R(vegnett = vegnett_sampledata,
                               year = 2021,
                               fromnodeID = "FROMNODEID",
                               tonodeID = "TONODEID",
                               FT_minutes = "FT_MINUTES",
                               TF_minutes = "TF_MINUTES",
                               meters = "SHAPE_LENGTH")
  
  graph_cppRouting_minutes <- vegnett_list[[4]]
  graph_cppRouting_meters <- vegnett_list[[5]]
  
  distance_cpp_min <- shortest_path_cppRouting(54,
                                               61,
                                               unit = "minutes",
                                               graph_cppRouting_object = graph_cppRouting_minutes)
  
  testthat::expect_type(distance_cpp_min, "list")
  
  distance_cpp_meter <- shortest_path_cppRouting(54,
                                                 61,
                                                 unit = "meters",
                                                 graph_cppRouting_object = graph_cppRouting_meters)
  
  testthat::expect_type(distance_cpp_meter, "list")
  
})


#### shortest_path_igraphs ####
testthat::test_that("Tester beregne_avstand", {
  library(GISSB)
  data("vegnett_sampledata")
  vegnett <- vegnett_sampledata
  
  vegnett_list <- vegnett_to_R(vegnett = vegnett_sampledata,
                               year = 2021,
                               fromnodeID = "FROMNODEID",
                               tonodeID = "TONODEID",
                               FT_minutes = "FT_MINUTES",
                               TF_minutes = "TF_MINUTES",
                               meters = "SHAPE_LENGTH")
  
  graph <- vegnett_list[[1]]
  
  distance_min <- shortest_path_igraph(from_node_ID = 54,
                                       to_node_ID = 61,
                                       graph_object = graph,
                                       unit = "minutes")
  
  testthat::expect_type(distance_min, "list")
  
  distance_meter <- shortest_path_igraph(from_node_ID = 54,
                                         to_node_ID = 61,
                                         graph_object = graph,
                                         unit = "meters")
  
  testthat::expect_type(distance_meter, "list")
  
  path <- shortest_path_igraph(from_node_ID = 54,
                               to_node_ID = 61,
                               graph_object = graph,
                               unit = "minutes",
                               path = T)
  
  testthat::expect_type(path, "list")
  
})

