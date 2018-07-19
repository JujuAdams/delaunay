/// @param edges_array
/// @param node_to_edge_map

var _edge_array        = argument0;
var _node_to_edge_map = argument1;

var _edges_count = array_length_1d( _edge_array );
for( var _e = 0; _e < _edges_count; _e += e_edge.size )
{
	var _x1 = _edge_array[ e_edge.x1 + _e ];
	var _y1 = _edge_array[ e_edge.y1 + _e ];
	var _x2 = _edge_array[ e_edge.x2 + _e ];
	var _y2 = _edge_array[ e_edge.y2 + _e ];
	
	var _key = string( _x1 ) + "," + string( _y1 );
	var _list = _node_to_edge_map[? _key ];
	if ( _list == undefined )
	{
		_list = ds_list_create();
		ds_map_add_list( _node_to_edge_map, _key, _list );
	}
	ds_list_add( _list, _e );
	
	var _key = string( _x2 ) + "," + string( _y2 );
	var _list = _node_to_edge_map[? _key ];
	if ( _list == undefined )
	{
		_list = ds_list_create();
		ds_map_add_list( _node_to_edge_map, _key, _list );
	}
	ds_list_add( _list, _e );
}