/// @param point_array
/// @param point_to_edge_map

var _point_array       = argument0;
var _point_to_edge_map = argument1;

var _points_count = array_length_1d( _point_array );
for( var _p = 0; _p < _points_count; _p += e_point.size )
{
	var _edge_array = array_create( 0 );
	
	var _inst = _point_array[ _p + e_point.inst ];
	if ( _inst.object_index == obj_perimeter_point ) continue;
	
	var _x = _point_array[ _p + e_point.x ];
	var _y = _point_array[ _p + e_point.y ];
	var _key = string( _x ) + "," + string( _y );
	
	var _list = _point_to_edge_map[? _key ];
	if ( _list != undefined )
	{
		var _edges_count = ds_list_size( _list );
		for( var _e = _edges_count-1; _e >= 0; _e-- ) _edge_array[ _e ] = _list[| _e ];
	}
	
	_point_array[@ _p + e_point.edges ] = _edge_array;
}