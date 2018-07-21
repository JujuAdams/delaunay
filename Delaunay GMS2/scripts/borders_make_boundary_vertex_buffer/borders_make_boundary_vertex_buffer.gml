/// @param border_array

var _border_array = argument0;

var _border_count = array_length_1d( _border_array );
for( var _b = 0; _b < _border_count; _b += e_border.size )
{
	var _points_array = _border_array[ _b + e_border.point_array ];
	var _total_length = _border_array[ _b + e_border.length      ];
	
	var _vbuff = vertex_create_buffer();
	vertex_begin( _vbuff, global.vft_2d_boundary );
	
	var _last_o_nx = undefined; var _last_o_ny = undefined;
	var _last_i_nx = undefined; var _last_i_ny = undefined;
	var _last_u = 0;
	var _this_u = 0;
	
	var _path_nodes_count = array_length_1d( _points_array );
	for( var _p_offset = 0; _p_offset <= _path_nodes_count; _p_offset += 2 )
	{
		var _p = _p_offset mod _path_nodes_count;
		var _q = (_p+2) mod _path_nodes_count;
		var _r = (_p+4) mod _path_nodes_count;
		
		var _x1 = _points_array[ _p ]; var _y1 = _points_array[ _p+1 ];
		var _x2 = _points_array[ _q ]; var _y2 = _points_array[ _q+1 ];
		var _x3 = _points_array[ _r ]; var _y3 = _points_array[ _r+1 ];
		
		var _dx12 = _x2 - _x1; var _dy12 = _y2 - _y1;
		var _dx23 = _x3 - _x2; var _dy23 = _y3 - _y2;
		
		var _d12 = sqrt( _dx12*_dx12 + _dy12*_dy12 );
		var _norm_dx12 = _dx12 / _d12; var _norm_dy12 = _dy12 / _d12;
		
		var _d23 = sqrt( _dx23*_dx23 + _dy23*_dy23 );
		var _norm_dx23 = _dx23 / _d23; var _norm_dy23 = _dy23 / _d23;
		
		var _rx12 = _norm_dy12; var _ry12 = -_norm_dx12;
		var _rx23 = _norm_dy23; var _ry23 = -_norm_dx23;
		
		var _o_x1_12 = _x1 - _rx12; var _o_y1_12 = _y1 - _ry12;
		var _o_x2_12 = _x2 - _rx12; var _o_y2_12 = _y2 - _ry12;
		var _o_x2_23 = _x2 - _rx23; var _o_y2_23 = _y2 - _ry23;
		var _o_x3_23 = _x3 - _rx23; var _o_y3_23 = _y3 - _ry23;
		
		var _outer_t = lines_intersect( _o_x1_12, _o_y1_12, _o_x2_12, _o_y2_12,
		                                _o_x2_23, _o_y2_23, _o_x3_23, _o_y3_23 );
		
		var _i_x1_12 = _x1 + _rx12; var _i_y1_12 = _y1 + _ry12;
		var _i_x2_12 = _x2 + _rx12; var _i_y2_12 = _y2 + _ry12;
		var _i_x2_23 = _x2 + _rx23; var _i_y2_23 = _y2 + _ry23;
		var _i_x3_23 = _x3 + _rx23; var _i_y3_23 = _y3 + _ry23;
		
		var _inner_t = lines_intersect( _i_x1_12, _i_y1_12, _i_x2_12, _i_y2_12,
		                                _i_x2_23, _i_y2_23, _i_x3_23, _i_y3_23 );
		
		var _o_x2 = _o_x1_12 + _outer_t*_dx12; var _o_y2 = _o_y1_12 + _outer_t*_dy12;
		var _i_x2 = _i_x1_12 + _inner_t*_dx12; var _i_y2 = _i_y1_12 + _inner_t*_dy12;
		
		var _o_nx = _o_x2 - _x2; var _o_ny = _o_y2 - _y2;
		var _i_nx = _i_x2 - _x2; var _i_ny = _i_y2 - _y2;
		
		if ( _last_o_nx != undefined )		
		{
			show_debug_message( string( _last_u ) + " -> " + string( _this_u ) );
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_o_nx, _last_o_ny, 0 ); vertex_colour( _vbuff, make_colour_rgb( _last_u*255,   0, 0 ), 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _o_nx,      _o_ny, 0 ); vertex_colour( _vbuff, make_colour_rgb( _this_u*255,   0, 0 ), 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _i_nx,      _i_ny, 0 ); vertex_colour( _vbuff, make_colour_rgb( _this_u*255, 255, 0 ), 1 );
			
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_o_nx, _last_o_ny, 0 ); vertex_colour( _vbuff, make_colour_rgb( _last_u*255,   0, 0 ), 1 );
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_i_nx, _last_i_ny, 0 ); vertex_colour( _vbuff, make_colour_rgb( _last_u*255, 255, 0 ), 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _i_nx,      _i_ny, 0 ); vertex_colour( _vbuff, make_colour_rgb( _this_u*255, 255, 0 ), 1 );
			/*
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_o_nx, _last_o_ny, 0 ); vertex_colour( _vbuff, merge_color( c_black, c_red   , _last_u ), 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _o_nx,      _o_ny, 0 ); vertex_colour( _vbuff, merge_color( c_black, c_red   , _this_u ), 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _i_nx,      _i_ny, 0 ); vertex_colour( _vbuff, merge_color( c_lime , c_yellow, _this_u ), 1 );
			
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_o_nx, _last_o_ny, 0 ); vertex_colour( _vbuff, merge_color( c_black, c_red   , _last_u ), 1 );
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_i_nx, _last_i_ny, 0 ); vertex_colour( _vbuff, merge_color( c_lime , c_yellow, _last_u ), 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _i_nx,      _i_ny, 0 ); vertex_colour( _vbuff, merge_color( c_lime , c_yellow, _this_u ), 1 );
			*/
			/*
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_o_nx, _last_o_ny, 0 ); vertex_colour( _vbuff, merge_color( c_black, c_red   , (_p+0) / (_path_nodes_count) ), 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _o_nx,      _o_ny, 0 ); vertex_colour( _vbuff, merge_color( c_black, c_red   , (_p+2) / (_path_nodes_count) ), 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _i_nx,      _i_ny, 0 ); vertex_colour( _vbuff, merge_color( c_lime , c_yellow, (_p+2) / (_path_nodes_count) ), 1 );
			
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_o_nx, _last_o_ny, 0 ); vertex_colour( _vbuff, merge_color( c_black, c_red   , (_p+0) / (_path_nodes_count) ), 1 );
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_i_nx, _last_i_ny, 0 ); vertex_colour( _vbuff, merge_color( c_lime , c_yellow, (_p+0) / (_path_nodes_count) ), 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _i_nx,      _i_ny, 0 ); vertex_colour( _vbuff, merge_color( c_lime , c_yellow, (_p+2) / (_path_nodes_count) ), 1 );
			*/
			/*
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_o_nx, _last_o_ny, 0 ); vertex_colour( _vbuff, merge_color( c_white, c_red,  _p_offset    / _path_nodes_count_plus_2 ), 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _o_nx,      _o_ny, 0 ); vertex_colour( _vbuff, merge_color( c_white, c_red, (_p_offset+2) / _path_nodes_count_plus_2 ), 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _i_nx,      _i_ny, 0 ); vertex_colour( _vbuff, merge_color( c_lime , c_red, (_p_offset+2) / _path_nodes_count_plus_2 ), 1 );
			
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_o_nx, _last_o_ny, 0 ); vertex_colour( _vbuff, merge_color( c_white, c_red,  _p_offset    / _path_nodes_count_plus_2 ), 1 );
			vertex_position( _vbuff, _x1, _y1 ); vertex_normal( _vbuff, _last_i_nx, _last_i_ny, 0 ); vertex_colour( _vbuff, merge_color( c_lime , c_red,  _p_offset    / _path_nodes_count_plus_2 ), 1 );
			vertex_position( _vbuff, _x2, _y2 ); vertex_normal( _vbuff,      _i_nx,      _i_ny, 0 ); vertex_colour( _vbuff, merge_color( c_lime , c_red, (_p_offset+2) / _path_nodes_count_plus_2 ), 1 );
			*/
		}
		
		_last_o_nx = _o_nx; _last_o_ny = _o_ny;
		_last_i_nx = _i_nx; _last_i_ny = _i_ny;
		
		show_debug_message( string( point_distance( _x1, _y1, _x2, _y2 ) ) + " / " + string( _total_length ) + " == " + string( point_distance( _x1, _y1, _x2, _y2 )/_total_length ) );
		_last_u = _this_u;
		_this_u += point_distance( _x1, _y1, _x2, _y2 )/_total_length;
	}
	
	vertex_end( _vbuff );
	vertex_freeze( _vbuff );
	
	_border_array[@ _b + e_border.boundary_vbuff ] = _vbuff;
}