/// @param triangles_array
/// @param edges_array_out
function triangulation_find_unique_edges(argument0, argument1, argument2) {

	var _triangles       = argument0;
	var _edges_out        = argument1;
	var _edges_lookup_map = argument2;

	var _edges_count = array_length_1d( _edges_out );

	var _triangles_count = array_length_1d( _triangles );
	for( var _t = 0; _t < _triangles_count; _t += e_triangle.size )
	{
		var _x1 = _triangles[ _t + e_triangle.x1 ];
		var _y1 = _triangles[ _t + e_triangle.y1 ];
		var _x2 = _triangles[ _t + e_triangle.x2 ];
		var _y2 = _triangles[ _t + e_triangle.y2 ];
		var _x3 = _triangles[ _t + e_triangle.x3 ];
		var _y3 = _triangles[ _t + e_triangle.y3 ];
	
		var _key     = string( _x1 ) + "," + string( _y1 ) + "->" + string( _x2 ) + "," + string( _y2 );
		var _alt_key = string( _x2 ) + "," + string( _y2 ) + "->" + string( _x1 ) + "," + string( _y1 );
		if ( !ds_map_exists( _edges_lookup_map, _key ) && !ds_map_exists( _edges_lookup_map, _alt_key ) )
		{
			_edges_out[@ _edges_count + e_edge.x1 ] = _x1;
			_edges_out[@ _edges_count + e_edge.y1 ] = _y1;
			_edges_out[@ _edges_count + e_edge.x2 ] = _x2;
			_edges_out[@ _edges_count + e_edge.y2 ] = _y2;
			_edges_lookup_map[? _key ] = _edges_count;
			_edges_count += e_edge.size;
		}
	
		var _key     = string( _x2 ) + "," + string( _y2 ) + "->" + string( _x3 ) + "," + string( _y3 );
		var _alt_key = string( _x3 ) + "," + string( _y3 ) + "->" + string( _x2 ) + "," + string( _y2 );
		if ( !ds_map_exists( _edges_lookup_map, _key ) && !ds_map_exists( _edges_lookup_map, _alt_key ) )
		{
			_edges_out[@ _edges_count + e_edge.x1 ] = _x2;
			_edges_out[@ _edges_count + e_edge.y1 ] = _y2;
			_edges_out[@ _edges_count + e_edge.x2 ] = _x3;
			_edges_out[@ _edges_count + e_edge.y2 ] = _y3;
			_edges_lookup_map[? _key ] = _edges_count;
			_edges_count += e_edge.size;
		}
	
		var _key     = string( _x3 ) + "," + string( _y3 ) + "->" + string( _x1 ) + "," + string( _y1 );
		var _alt_key = string( _x1 ) + "," + string( _y1 ) + "->" + string( _x3 ) + "," + string( _y3 );
		if ( !ds_map_exists( _edges_lookup_map, _key ) && !ds_map_exists( _edges_lookup_map, _alt_key ) )
		{
			_edges_out[@ _edges_count + e_edge.x1 ] = _x3;
			_edges_out[@ _edges_count + e_edge.y1 ] = _y3;
			_edges_out[@ _edges_count + e_edge.x2 ] = _x1;
			_edges_out[@ _edges_count + e_edge.y2 ] = _y1;
			_edges_lookup_map[? _key ] = _edges_count;
			_edges_count += e_edge.size;
		}
	
	}


}
