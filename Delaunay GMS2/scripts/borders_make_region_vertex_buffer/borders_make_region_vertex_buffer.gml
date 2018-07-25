/// @param border_array

var _border_array = argument0;
var _debug = false;
	
//Create a list to use as a stack of points yet to be clipped
var _list = ds_list_create();

//Iterate over all borders
var _border_count = array_length_1d( _border_array );
for( var _b = 0; _b < _border_count; _b += e_border.size )
{
	if ( _debug ) show_debug_message( "Border " + string( _b ) );
	
	//Iterate over all points in the border's path and add them to the list
	var _points_array = _border_array[ _b + e_border.point_array ];
	var _points_count = array_length_1d( _points_array );
	ds_list_clear( _list );
	for( var _p = 0; _p < _points_count; _p += 2 ) ds_list_add( _list, _p );
	
	//Make an array that'll store the coordinates of our triangle
	var _triangle_array = array_create( 0 );
	var _triangle_count = 0;
	
	//_i is used as an incrementer to move through the point stack
	//If a triangle cannot be clipped, we increment _i and test another triangle
	var _i = -1;
	
	//Keep going until we've only got two points left (e.g. the final triangle has been defined)
	while( ds_list_size( _list ) > 2 )
	{
		var _list_size = ds_list_size( _list );
		_i++;
		
		while( ds_list_size( _list ) > 2 )
		{
			//Grab this point, and the two points after it. We call these P & Q & R
			var _list_size = ds_list_size( _list );
			var _i = _i mod _list_size;
			var _j = ( _i + 1 ) mod _list_size;
			var _k = ( _i + 2 ) mod _list_size;
			var _p = _list[| _i ];
			var _q = _list[| _j ];
			var _r = _list[| _k ];
			
			//Find the worldspace coordinates for P & Q & R
			var _px = _points_array[ _p   ];
			var _py = _points_array[ _p+1 ];
			var _qx = _points_array[ _q   ];
			var _qy = _points_array[ _q+1 ];
			var _rx = _points_array[ _r   ];
			var _ry = _points_array[ _r+1 ];
			
			//Find D, a number that tells us what side of the P->R line Q is on
			//If D is greater than 0, D is inside the triangle making the angle PQR a reflex angle (and therefore the path is concave at that point and cannot be earclipped)
			var _d = (_qx - _px)*(_ry - _py) - (_qy - _py)*(_rx - _px );
			if ( _debug ) show_debug_message( "    " + string( _p ) + "->" + string( _q ) + "->" + string( _r ) + " = " + string( _d ) );
			if ( _d <= 0 )
			{
				
				//We now check if there are any points inside the triangle PQR
				//If there are, we cannot earclip
				var _inside = false;
				for( var _s_list = 0; _s_list < _list_size; _s_list++ )
				{
					var _s = _list[| _s_list ];
					if ( _s == _p ) || ( _s == _q ) || ( _s == _r ) continue;
					
					var _sx = _points_array[ _s   ];
					var _sy = _points_array[ _s+1 ];
					if ( point_in_triangle( _sx, _sy, _px, _py, _qx, _qy, _rx, _ry ) )
					{
						_inside = true;
						break;
					}
				}
				
				if ( _inside )
				{
					if ( _debug ) show_debug_message( "        Refused due to point being inside triangle (" + string( _s ) + ")" );
					break;
				}
				
				//And finally we check if any edges the intersect with PQR
				var _intersection = false;
				for( var _m_list = 0; _m_list < _list_size; _m_list++ )
				{
					var _n_list = ( _m_list + 1 ) mod _list_size;
					var _m = _list[| _m_list ];
					var _n = _list[| _n_list ];
				
					var _mx = _points_array[ _m   ];
					var _my = _points_array[ _m+1 ];
					var _nx = _points_array[ _n   ];
					var _ny = _points_array[ _n+1 ];
					if ( rays_intersect( _px, _py, _rx, _ry,   _mx, _my, _nx, _ny ) > 0 )
					{
						_intersection = true;
						break;
					}
				}
			
				if ( _intersection ) {
					if ( _debug ) show_debug_message( "        Refused due to ray intersection (" + string( _m ) + "->" + string( _n ) + ")" );
					break;
				}
				else
				{
					//Once we're happy we can clip the triangle, we add data to the triangle array...
					if ( _debug ) show_debug_message( "        Clipping " + string( _q ) );
					_triangle_array[ _triangle_count + e_triangle.x1 ] = _px;
					_triangle_array[ _triangle_count + e_triangle.y1 ] = _py;
					_triangle_array[ _triangle_count + e_triangle.x2 ] = _qx;
					_triangle_array[ _triangle_count + e_triangle.y2 ] = _qy;
					_triangle_array[ _triangle_count + e_triangle.x3 ] = _rx;
					_triangle_array[ _triangle_count + e_triangle.y3 ] = _ry;
					_triangle_count += e_triangle.size;
					
					//...and delete Q from from the unclipped list
					ds_list_delete( _list, _j );
				}
			}
			else
			{
				break;
			}
		}
	}
	
	//Once we're finished triangulating, but the triangle array into the border array
	_border_array[@ _b + e_border.triangle_array ] = _triangle_array;
	
	//If we've actually been able to triangulate something, then build a vertex buffer from what we found
	if ( _triangle_count > 0 )
	{
		var _vbuff = vertex_create_buffer();
		vertex_begin( _vbuff, global.vft_2d_region );
		for( var _t = 0; _t < _triangle_count; _t += e_triangle.size )
		{
		    var _x1 = _triangle_array[ e_triangle.x1 + _t ];
			var _y1 = _triangle_array[ e_triangle.y1 + _t ];
		    var _x2 = _triangle_array[ e_triangle.x2 + _t ];
			var _y2 = _triangle_array[ e_triangle.y2 + _t ];
		    var _x3 = _triangle_array[ e_triangle.x3 + _t ];
			var _y3 = _triangle_array[ e_triangle.y3 + _t ];
		
			vertex_position( _vbuff, _x1, _y1 ); vertex_colour( _vbuff, c_white, 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_colour( _vbuff, c_white, 1 );
			vertex_position( _vbuff, _x3, _y3 ); vertex_colour( _vbuff, c_white, 1 );
		}
		vertex_end( _vbuff );
		vertex_freeze( _vbuff );
		_border_array[@ _b + e_border.region_vbuff ] = _vbuff;
	}
}