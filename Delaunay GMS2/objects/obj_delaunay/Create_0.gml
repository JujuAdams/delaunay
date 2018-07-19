point_lookup_map = ds_map_create();

//Run over all points in the room and drop their coordinates into an array
var _points_count = 0;
var _size = instance_number( obj_point );
for( var _i = 0; _i < _size; _i++ ) {
    var _inst = instance_find( obj_point, _i );
    
    //The points array stores coordinates sequentially (x1,y1,x2,y2 etc.)
	point_array[ e_point.inst   + _points_count ] = _inst;
    point_array[ e_point.x      + _points_count ] = _inst.x;
    point_array[ e_point.y      + _points_count ] = _inst.y;
	point_array[ e_point.edges  + _points_count ] = array_create( 0 );
	point_array[ e_point.colour + _points_count ] = _inst.image_blend;
    
	point_lookup_map[? string( _inst.x ) + "," + string( _inst.y ) ] = _points_count;
	
    _points_count += e_point.size;
}

//Run the algorithm!
triangle_array = array_create( 0 );
delaunay_bowyer_watson( point_array, triangle_array,   0, 0, room_width, room_height,   true );

//Collect an array of unique edges (and also build a lookup table for them)
edge_array = array_create( 0 );
edge_lookup_map = ds_map_create();
triangulation_find_unique_edges( triangle_array, edge_array, edge_lookup_map );

point_to_edge_map = ds_map_create(); //Will contain nested lists
edges_associate_points( edge_array, point_to_edge_map );
points_assign_edges( point_array, point_to_edge_map );
points_sort_edges( point_array, edge_array, false );

border_array = array_create( 0 );
make_borders( border_array, point_array, edge_array, point_lookup_map );