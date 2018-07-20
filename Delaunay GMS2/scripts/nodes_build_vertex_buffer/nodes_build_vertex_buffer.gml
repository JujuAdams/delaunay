/// @param node_array
/// @param edge_array
/// @param node_lookup_map

var _node_array      = argument0;
var _edge_array      = argument1;
var _node_lookup_map = argument2;

var _nodes_count = array_length_1d( _node_array );
for( var _p = 0; _p < _nodes_count; _p += e_node.size )
{
	var _inst = _node_array[ _p + e_node.inst ];
	if ( _inst.object_index == obj_perimeter_node ) continue;
	
	var _px = _node_array[ _p + e_node.x ];
	var _py = _node_array[ _p + e_node.y ];
	
	var _node_edges = _node_array[ _p + e_node.edges  ];
	var _node_edges_count = array_length_1d( _node_edges );
	
	if ( _node_edges_count < 3 )
	{
		show_debug_message( "Skipping node " + string( _p ) + " as it has less than 3 edges (" + string( _node_edges_count ) + ")" );
		continue;
	}
	
	var _vbuff = vertex_create_buffer();
	vertex_begin( _vbuff, global.vft_2d_untextured );
	
	var _qx = _px;
	var _qy = _py;
	for( var _offset_e = 0; _offset_e <= _node_edges_count; _offset_e++ )
	{
		var _last_qx = _qx;
		var _last_qy = _qy;
		
		var _e = _offset_e mod _node_edges_count;
		
		var _edge_id = _node_edges[ _e ];
		var _x1 = _edge_array[ _edge_id + e_edge.x1 ];
		var _y1 = _edge_array[ _edge_id + e_edge.y1 ];
		var _x2 = _edge_array[ _edge_id + e_edge.x2 ];
		var _y2 = _edge_array[ _edge_id + e_edge.y2 ];
		
		if ( _px == _x1 ) && ( _py == _y1 )
		{
			var _qx = _x2;
			var _qy = _y2;
		}
		else if ( _px == _x2 ) && ( _py == _y2 )
		{
			var _qx = _x1;
			var _qy = _y1;
		}
		else
		{
			show_error( "Cannot find P on edge. Skipping this boundary", false );
			break;
		}
		
		_qx = lerp( _px, _qx, 0.5 );
		_qy = lerp( _py, _qy, 0.5 );
		
		if ( _offset_e != 0 )
		{
			vertex_position( _vbuff, _px, _py           ); vertex_colour( _vbuff, c_white, 1 );
			vertex_position( _vbuff, _last_qx, _last_qy ); vertex_colour( _vbuff, c_white, 1 );
			vertex_position( _vbuff, _qx, _qy           ); vertex_colour( _vbuff, c_white, 1 );
		}
	}
	
	vertex_end( _vbuff );
	vertex_freeze( _vbuff );
	_node_array[@ _p + e_node.vbuff ] = _vbuff;
}