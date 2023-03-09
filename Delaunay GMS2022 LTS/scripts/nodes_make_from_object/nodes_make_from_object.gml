/// @param node_array
/// @param node_lookup_map
/// @param object
function nodes_make_from_object(argument0, argument1, argument2) {

	var _node_array      = argument0;
	var _node_lookup_map = argument1;
	var _object          = argument2;

	var _nodes_count = 0;
	var _size = instance_number( _object );
	for( var _i = 0; _i < _size; _i++ ) {
	    var _inst = instance_find( _object, _i );
    
		if ( _inst.object_index == obj_perimeter_node ) _inst.image_blend = c_black;
	
	    //The nodes array stores coordinates sequentially (x1,y1,x2,y2 etc.)
		_node_array[@ e_node.inst   + _nodes_count ] = _inst;
	    _node_array[@ e_node.x      + _nodes_count ] = _inst.x;
	    _node_array[@ e_node.y      + _nodes_count ] = _inst.y;
		_node_array[@ e_node.edges  + _nodes_count ] = array_create( 0 );
		_node_array[@ e_node.colour + _nodes_count ] = _inst.image_blend;
    
		_node_lookup_map[? string( _inst.x ) + "," + string( _inst.y ) ] = _nodes_count;
	
	    _nodes_count += e_node.size;
	}


}
