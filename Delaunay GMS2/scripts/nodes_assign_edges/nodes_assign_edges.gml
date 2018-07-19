/// @param node_array
/// @param node_to_edge_map

var _node_array       = argument0;
var _node_to_edge_map = argument1;

var _nodes_count = array_length_1d( _node_array );
for( var _p = 0; _p < _nodes_count; _p += e_node.size )
{
	var _edge_array = array_create( 0 );
	
	var _inst = _node_array[ _p + e_node.inst ];
	if ( _inst.object_index == obj_perimeter_node ) continue;
	
	var _x = _node_array[ _p + e_node.x ];
	var _y = _node_array[ _p + e_node.y ];
	var _key = string( _x ) + "," + string( _y );
	
	var _list = _node_to_edge_map[? _key ];
	if ( _list != undefined )
	{
		var _edges_count = ds_list_size( _list );
		for( var _e = _edges_count-1; _e >= 0; _e-- ) _edge_array[ _e ] = _list[| _e ];
	}
	
	_node_array[@ _p + e_node.edges ] = _edge_array;
}