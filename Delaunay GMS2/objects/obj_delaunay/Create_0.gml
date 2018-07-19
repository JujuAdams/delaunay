//Run over all nodes in the room and drop their coordinates into an array
node_array = array_create( 0 );
node_lookup_map = ds_map_create();
nodes_make_from_object( node_array, node_lookup_map, obj_node );

//Run the algorithm!
triangle_array = array_create( 0 );
delaunay_bowyer_watson( node_array, triangle_array,   0, 0, room_width, room_height,   true );

//Collect an array of unique edges (and also build a lookup table for them)
edge_array = array_create( 0 );
edge_lookup_map = ds_map_create();
triangulation_find_unique_edges( triangle_array, edge_array, edge_lookup_map );

//Build a map of nodes coordinates, and for each node create a list of edges that connect to it
node_to_edge_map = ds_map_create(); //Will contain nested lists
edges_associate_nodes( edge_array, node_to_edge_map );

//Add an array of edges to each node
nodes_assign_edges( node_array, node_to_edge_map );

//Order each node's edges in a counterclockwise order
//(The direction doesn't matter, only that they're all ordered the same way)
nodes_sort_edges( node_array, edge_array, false );

//Make borders around each set of nodes
border_array = array_create( 0 );
make_borders( border_array, node_array, edge_array, node_lookup_map );

//And prettify the borders a bit
smooth_borders( border_array );