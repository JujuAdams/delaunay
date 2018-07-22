/// @param border_array

var _border_array = argument0;

//We need to find the border length before we can figure out the texture U-coordinate
borders_find_length( border_array );

//Iterate over all borders
var _border_count = array_length_1d( _border_array );
for( var _b = 0; _b < _border_count; _b += e_border.size )
{
	var _points_array = _border_array[ _b + e_border.point_array ];
	var _total_length = _border_array[ _b + e_border.length      ]; //We use the total length to figure out the U-coordinate for the texture
	
	//Start making a vertex buffer
	var _vbuff = vertex_create_buffer();
	vertex_begin( _vbuff, global.vft_2d_boundary );
	
	//We cache the last path point's data (we set these values later)
	var _last_o_nx = undefined; var _last_o_ny = undefined;
	var _last_i_nx = undefined; var _last_i_ny = undefined;
	var _last_u = 0;
	var _this_u = 0;
	
	//Iterate over every point in the border's path
	var _path_nodes_count = array_length_1d( _points_array );
	for( var _p_offset = 0; _p_offset <= _path_nodes_count; _p_offset += 2 )
	{
		//Grab this point, and the two points after it. We call these P & Q & R
		var _p = _p_offset mod _path_nodes_count;
		var _q = (_p+2) mod _path_nodes_count;
		var _r = (_q+2) mod _path_nodes_count;
		
		//Find the worldspace coordinates for P & Q & R
		var _x1 = _points_array[ _p ]; var _y1 = _points_array[ _p+1 ];
		var _x2 = _points_array[ _q ]; var _y2 = _points_array[ _q+1 ];
		var _x3 = _points_array[ _r ]; var _y3 = _points_array[ _r+1 ];
		
		//Find the direction vectors P->Q & Q->R (calculated as Q-P and R-Q respectively)
		var _dx12 = _x2 - _x1; var _dy12 = _y2 - _y1;
		var _dx23 = _x3 - _x2; var _dy23 = _y3 - _y2;
		
		//Normalise the direction vectors
		var _d12 = sqrt( _dx12*_dx12 + _dy12*_dy12 );
		var _norm_dx12 = _dx12 / _d12; var _norm_dy12 = _dy12 / _d12;
		var _d23 = sqrt( _dx23*_dx23 + _dy23*_dy23 );
		var _norm_dx23 = _dx23 / _d23; var _norm_dy23 = _dy23 / _d23;
		
		//Rotate the direction vectors by 90 degrees so that they're perpendicular to the source edges
		var _rx12 = _norm_dy12; var _ry12 = -_norm_dx12;
		var _rx23 = _norm_dy23; var _ry23 = -_norm_dx23;
		
		//Find the coordinates of the outer edge for P & Q & R by applying the perpendicular direction vectors
		var _o_x1_12 = _x1 - _rx12; var _o_y1_12 = _y1 - _ry12;
		var _o_x2_12 = _x2 - _rx12; var _o_y2_12 = _y2 - _ry12;
		var _o_x2_23 = _x2 - _rx23; var _o_y2_23 = _y2 - _ry23;
		var _o_x3_23 = _x3 - _rx23; var _o_y3_23 = _y3 - _ry23;
		
		//Find where the outer edge of P->Q meets the outer edge of Q->R
		//This function returns the parameter "t" for the equation: Intersection = P + t(Q-P)
		var _outer_t = lines_intersect( _o_x1_12, _o_y1_12, _o_x2_12, _o_y2_12,
		                                _o_x2_23, _o_y2_23, _o_x3_23, _o_y3_23 );
		
		var _i_x1_12 = _x1 + _rx12; var _i_y1_12 = _y1 + _ry12;
		var _i_x2_12 = _x2 + _rx12; var _i_y2_12 = _y2 + _ry12;
		var _i_x2_23 = _x2 + _rx23; var _i_y2_23 = _y2 + _ry23;
		var _i_x3_23 = _x3 + _rx23; var _i_y3_23 = _y3 + _ry23;
		
		//Find where the inner edge of P->Q meets the inner edge of Q->R
		//This function returns the parameter "t" for the equation: Intersection = P + t(Q-P)
		var _inner_t = lines_intersect( _i_x1_12, _i_y1_12, _i_x2_12, _i_y2_12,
		                                _i_x2_23, _i_y2_23, _i_x3_23, _i_y3_23 );
		
		//Find the outer and inner points of intersection
		var _o_x2 = _o_x1_12 + _outer_t*_dx12; var _o_y2 = _o_y1_12 + _outer_t*_dy12;
		var _i_x2 = _i_x1_12 + _inner_t*_dx12; var _i_y2 = _i_y1_12 + _inner_t*_dy12;
		
		//Find the two vectors (the "normal") from Q to the outer and inner points of intersection
		var _o_nx = _o_x2 - _x2; var _o_ny = _o_y2 - _y2;
		var _i_nx = _i_x2 - _x2; var _i_ny = _i_y2 - _y2;
		
		if ( _last_o_nx != undefined )		
		{
			//Only add a quad if we've cached data from the last iteration
			//Effectively this means that the first iteration doesn't draw anything, but subsequent iterations do
			show_debug_message( string( _last_u ) + " -> " + string( _this_u ) );
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_o_nx, _last_o_ny, 0 ); vertex_texcoord( _vbuff, _last_u, 0 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _o_nx,      _o_ny, 0 ); vertex_texcoord( _vbuff, _this_u, 0 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _i_nx,      _i_ny, 0 ); vertex_texcoord( _vbuff, _this_u, 1 );
			
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_o_nx, _last_o_ny, 0 ); vertex_texcoord( _vbuff, _last_u, 0 );
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_i_nx, _last_i_ny, 0 ); vertex_texcoord( _vbuff, _last_u, 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _i_nx,      _i_ny, 0 ); vertex_texcoord( _vbuff, _this_u, 1 );
		}
		
		//Cache the two normal vectors for use in the next iteration
		_last_o_nx = _o_nx; _last_o_ny = _o_ny;
		_last_i_nx = _i_nx; _last_i_ny = _i_ny;
		
		show_debug_message( string( point_distance( _x1, _y1, _x2, _y2 ) ) + " / " + string( _total_length ) + " == " + string( point_distance( _x1, _y1, _x2, _y2 )/_total_length ) );
		//Cache the U-coordinate of this iteration, and calculate the U-coordinate for the next iteration
		_last_u = _this_u;
		_this_u += point_distance( _x1, _y1, _x2, _y2 )/_total_length;
	}
	
	//End and freeze the vertex buffer, and store it in the border data array
	vertex_end( _vbuff );
	vertex_freeze( _vbuff );
	_border_array[@ _b + e_border.boundary_vbuff ] = _vbuff;
}