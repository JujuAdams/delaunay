/// @param point_array
/// @param edge_array
/// @param clockwise

var _point_array = argument0;
var _edge_array  = argument1;
var _clockwise   = argument2;

var _list = ds_list_create();

var _points_count = array_length_1d( _point_array );
for( var _p = 0; _p < _points_count; _p += e_point.size )
{
	ds_list_clear( _list );
	
	var _px = _point_array[ _p + e_point.x ];
	var _py = _point_array[ _p + e_point.y ];
	var _point_edge_array = _point_array[ _p + e_point.edges ];
	var _point_edges_count = array_length_1d( _point_edge_array );
	
	for( var _e = 0; _e < _point_edges_count; _e++ )
	{
		var _edge_id = _point_edge_array[ _e ];
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
			show_error( "Err...", false );
			continue;
		}
		
		var _direction = point_direction( _px, _py, _qx, _qy );
		var _direction_big = floor( _direction*10000 ) * 10000;
		var _weight = _edge_id + _direction_big;
		ds_list_add( _list, _weight );
	}
	
	ds_list_sort( _list, !_clockwise );
	
	var _list_size = ds_list_size( _list );
	for( var _e = 0; _e < _list_size; _e++ )
	{
		var _weight = _list[| _e ];
		var _subtractor = floor( _weight / 10000 ) * 10000;
		var _edge_id = _weight - _subtractor;
		_point_edge_array[@ _e ] = _edge_id;
	}
}