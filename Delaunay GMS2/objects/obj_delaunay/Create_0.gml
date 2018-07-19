node_lookup_map = ds_map_create();

//Run over all nodes in the room and drop their coordinates into an array
var _nodes_count = 0;
var _size = instance_number( obj_node );
for( var _i = 0; _i < _size; _i++ ) {
    var _inst = instance_find( obj_node, _i );
    
    //The nodes array stores coordinates sequentially (x1,y1,x2,y2 etc.)
	node_array[ e_node.inst   + _nodes_count ] = _inst;
    node_array[ e_node.x      + _nodes_count ] = _inst.x;
    node_array[ e_node.y      + _nodes_count ] = _inst.y;
	node_array[ e_node.edges  + _nodes_count ] = array_create( 0 );
	node_array[ e_node.colour + _nodes_count ] = _inst.image_blend;
    
	node_lookup_map[? string( _inst.x ) + "," + string( _inst.y ) ] = _nodes_count;
	
    _nodes_count += e_node.size;
}

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