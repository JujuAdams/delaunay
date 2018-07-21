draw_set_font( fnt_default );

var _triangles_count = array_length_1d( triangle_array );
var _edges_count     = array_length_1d( edge_array     );
var _nodes_count     = array_length_1d( node_array     );
var _borders_count   = array_length_1d( border_array   );
/*
draw_set_colour( c_white );
draw_set_alpha( 0.4 );
for( var _t = 0; _t < _triangles_count; _t += e_triangle.size )
{
    draw_triangle( triangle_array[ e_triangle.x1 + _t ], triangle_array[ e_triangle.y1 + _t ],
                   triangle_array[ e_triangle.x2 + _t ], triangle_array[ e_triangle.y2 + _t ],
                   triangle_array[ e_triangle.x3 + _t ], triangle_array[ e_triangle.y3 + _t ], false );
}
draw_set_alpha( 1 );

draw_set_colour( c_white );
for( var _e = 0; _e < _edges_count; _e += e_edge.size )
{
	var _x1 = edge_array[ _e + e_edge.x1 ];
	var _y1 = edge_array[ _e + e_edge.y1 ];
	var _x2 = edge_array[ _e + e_edge.x2 ];
	var _y2 = edge_array[ _e + e_edge.y2 ];
	draw_line( _x1, _y1, _x2, _y2 );
	
	var _mx = 0.5*( _x1 + _x2 );
	var _my = 0.5*( _y1 + _y2 );
	draw_text( _mx, _my, "E" + string( _e ) );
}
*/
draw_set_colour( c_gray );
for( var _p = 0; _p < _nodes_count; _p += e_node.size )
{
	var _inst   = node_array[ _p + e_node.inst   ];
	var _x      = node_array[ _p + e_node.x      ];
	var _y      = node_array[ _p + e_node.y      ];
	var _colour = node_array[ _p + e_node.colour ];
	var _vbuff  = node_array[ _p + e_node.vbuff  ];
	
	if ( _inst.object_index == obj_perimeter_node ) continue;
	draw_set_colour( _colour );
	
	if ( _vbuff != undefined )
	{
		shader_set( shd_force_rgba );
		shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vRGBA" ),
			                    colour_get_red(   _colour )/255,
								colour_get_green( _colour )/255,
								colour_get_blue(  _colour )/255,
								0.3 );
		vertex_submit( _vbuff, pr_trianglelist, -1 );
		shader_reset();
	}
	
	if ( point_distance( mouse_x, mouse_y, _x, _y ) < 50 )
	{
		/*
		var _node_edge_array = node_array[ _p + e_node.edges ];
		var _node_edges_count = array_length_1d( _node_edge_array );
		for( var _e = 0; _e < _node_edges_count; _e++ )
		{
			var _edge_id = _node_edge_array[ _e ];
		    var _x1 = edge_array[ _edge_id + e_edge.x1 ];
		    var _y1 = edge_array[ _edge_id + e_edge.y1 ];
		    var _x2 = edge_array[ _edge_id + e_edge.x2 ];
		    var _y2 = edge_array[ _edge_id + e_edge.y2 ];
			draw_line( _x1, _y1, _x2, _y2 );
			
			var _mx = 0.5*( _x1 + _x2 );
			var _my = 0.5*( _y1 + _y2 );
			draw_text( _mx, _my-20, string( _e ) + "=" + string( _edge_id ) );
		}
		*/
	}
	//draw_text( _x + 10, _y - 20, "P" + string( _p ) );
    draw_circle( _x, _y, 20, false );
	draw_set_colour( c_white );
}

for( var _b = 0; _b < _borders_count; _b += e_border.size )
{
	var _colour         = border_array[ _b + e_border.colour         ];
	var _boundary_vbuff = border_array[ _b + e_border.boundary_vbuff ];
	var _region_vbuff   = border_array[ _b + e_border.region_vbuff   ];
	var _point_array    = border_array[ _b + e_border.point_array    ];
	
	if ( _region_vbuff != undefined )
	{
		shader_set( shd_region );
		shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vRGBA" ),
		                      colour_get_red(   _colour )/255,
							  colour_get_green( _colour )/255,
							  colour_get_blue(  _colour )/255,
							  lerp( 0.2, 0.25, 0.5+0.5*dsin( _b*40 + current_time/9 ) ) );
		vertex_submit( _region_vbuff, pr_trianglelist, -1 );
		shader_reset();
	}
	
	if ( _boundary_vbuff != undefined ) && ( !keyboard_check( vk_shift ) )
	{
		gpu_set_tex_repeat( true );
		shader_set( shd_boundary );
		shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vRGBA" ),
		                      colour_get_red(   _colour )/255,
							  colour_get_green( _colour )/255,
							  colour_get_blue(  _colour )/255,
							  1 );
		shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vThickness" ),
		                      lerp( 2, 6, 0.5+0.5*dsin( current_time/10 ) ) );
		vertex_submit( _boundary_vbuff, pr_trianglelist, sprite_get_texture( spr_boundary_texture, 0 ) );
		shader_reset();
		gpu_set_tex_repeat( false );
	}
	
	//draw_set_colour( _colour );
	/*
	var _path_nodes_count = array_length_1d( _point_array );
	for( var _p = 0; _p < _path_nodes_count; _p += 2 )
	{
		var _p_next = (_p+2) mod _path_nodes_count;
		var _x1 = _point_array[ _p          ];
		var _y1 = _point_array[ _p + 1      ];
		var _x2 = _point_array[ _p_next     ];
		var _y2 = _point_array[ _p_next + 1 ];
		//draw_text( _x1, _y1, _p );
		//draw_line_width( _x1, _y1, _x2, _y2, 5 );
	}
	*/
}

draw_set_colour( c_white );
draw_text( 10, 10, "Delaunay algorithm implementation + Region maker\n2018/07/20\n\n@jujuadams\n\n"
                 + string( _triangles_count / e_triangle.size ) + " triangles\n"
				 + string( _edges_count / e_edge.size ) + " edges\n"
				 + string( _borders_count / e_border.size ) + " borders" );