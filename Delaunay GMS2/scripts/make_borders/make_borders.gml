/// @param path_array
/// @param point_array
/// @param edge_array
/// @param point_lookup_map

var _path_array       = argument0;
var _point_array      = argument1;
var _edge_array       = argument2;
var _point_lookup_map = argument3;

var _path_count = array_length_1d( _path_array );

//Fill a map with every point we need to visit
var _points_count = array_length_1d( _point_array );
var _unvisited_map = ds_map_create();
for( var _p = 0; _p < _points_count; _p += e_point.size ) _unvisited_map[? _p ] = _p;

//Set up P to be undefined - this forces the algo to pick the first available unvisited node
var _p = undefined;

//Go until we've visited every node
while( !ds_map_empty( _unvisited_map ) )
{
	
	//If P is undefined then we'll need to grab an unvisited node
	if ( _p == undefined )
	{
		var _p = ds_map_find_first( _unvisited_map );
		ds_map_delete( _unvisited_map, _p );
		
		//If this point is a perimeter point, ignore it
		var _inst = _point_array[ _p + e_point.inst ];
		if ( _inst.object_index == obj_perimeter_point )
		{
			_p = undefined;
			continue;
		}
		
		//Select our starting edge as 0
		var _start_e = 0;
		
		//Create a new path and initialise our start point as nowhere, man
		var _path = path_add();
		var _path_first_node = undefined;
		var _path_first_edge = undefined;
	}
	else
	{
		//If P was set in a previous loop, then we'll need to remove that node from our list of unvisited nodes
		ds_map_delete( _unvisited_map, _p );
	}
	
	//Collect data about P
	var _px          = _point_array[ _p + e_point.x      ];
	var _py          = _point_array[ _p + e_point.y      ];
	var _p_colour    = _point_array[ _p + e_point.colour ];
	
	//Iterate over every edge on P (or at least until we need to hop to another node)
	var _point_edges = _point_array[ _p + e_point.edges  ];
	var _point_edges_count = array_length_1d( _point_edges );
	
	//Because we can start at any edge, we need to handle wrapping around P's list of edges
	var _end_e = _start_e + _point_edges_count;
	for( var _offset_e = _start_e; _offset_e <= _end_e; _offset_e++ )
	{
		var _e = _offset_e mod _point_edges_count;
		
		//Find our edge in the global list and extract information about it
		var _edge_id = _point_edges[ _e ];
		var _x1 = _edge_array[ _edge_id + e_edge.x1 ];
		var _y1 = _edge_array[ _edge_id + e_edge.y1 ];
		var _x2 = _edge_array[ _edge_id + e_edge.x2 ];
		var _y2 = _edge_array[ _edge_id + e_edge.y2 ];
		
		//Find the coordinates of the other end of this edge
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
		
		//Set Q as the id of the node at the end other of the edge
		var _q = _point_lookup_map[? string( _qx ) + "," + string( _qy ) ];
		
		var _q_colour = _point_array[ _q + e_point.colour ];
		if ( _q_colour == _p_colour )
		{
			//Q's colour is the same as P's
			
			if ( _path_first_node == undefined ) && ( _path_first_edge == undefined )
			{
				//If we've not yet found our first differentially coloured connection for this border, keep searching
				continue;
			}
			
			//Find out which edge to start from on Q
			_start_e = undefined;
			var _point_edges = _point_array[ _q + e_point.edges ];
			var _point_edges_count = array_length_1d( _point_edges );
			for( var _search_e = 0; _search_e < _point_edges_count; _search_e++ )
			{
				if ( _point_edges[ _search_e ] == _edge_id )
				{
					_start_e = _search_e;
					break;
				}
			}
			
			if ( _start_e == undefined )
			{
				//If we can't find the edge for P in Q, abort and try another point
				show_error( "Hmn.", false );
				path_delete( _path );
				_q = undefined;
			}
			else
			{
				_start_e++;
			}
			
			//"Q is the new P, darling"
			_p = _q;
			
			break;
		}
		else
		{
			//Q's colour is different to P's
			
			//If we've looped back round to where we started, break
			if ( _p == _path_first_node ) && ( _e == _path_first_edge )
			{
				var _smoothed_path = path_create_smoothed( _path, 0.2, 0.01, false );
				path_delete( _path );
				_path_array[@ _path_count + e_border.path   ] = _smoothed_path;
				_path_array[@ _path_count + e_border.colour ] = _p_colour;
				_path_count += e_border.size;
				_p = undefined;
				break;
			}
			
			//Add the midpoint of the edge to the boundary
			path_add_point( _path, lerp( _px, _qx, 0.46 ), lerp( _py, _qy, 0.46 ), 100 );
			
			//If this is the path's first border point, make a note of it so we don't go round in circles
			if ( _path_first_node == undefined ) _path_first_node = _p;
			if ( _path_first_edge == undefined ) _path_first_edge = _e;
		}
	}
}