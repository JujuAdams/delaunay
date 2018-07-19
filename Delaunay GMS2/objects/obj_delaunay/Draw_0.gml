var _triangles_count = array_length_1d( triangle_array );
var _edges_count     = array_length_1d( edge_array     );
var _points_count    = array_length_1d( point_array    );
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
*/
/*
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
for( var _p = 0; _p < _points_count; _p += e_point.size )
{
	var _inst   = point_array[ _p + e_point.inst   ];
	var _x      = point_array[ _p + e_point.x      ];
	var _y      = point_array[ _p + e_point.y      ];
	var _colour = point_array[ _p + e_point.colour ];
	
	if ( _inst.object_index == obj_perimeter_point ) continue;
	if ( _colour == c_black ) continue;
	draw_set_colour( _colour );
	/*
	if ( point_distance( mouse_x, mouse_y, _x, _y ) < 10 )
	{
		var _point_edge_array = point_array[ _p + e_point.edges ];
		var _point_edges_count = array_length_1d( _point_edge_array );
		for( var _e = 0; _e < _point_edges_count; _e++ )
		{
			var _edge_id = _point_edge_array[ _e ];
		    var _x1 = edge_array[ _edge_id + e_edge.x1 ];
		    var _y1 = edge_array[ _edge_id + e_edge.y1 ];
		    var _x2 = edge_array[ _edge_id + e_edge.x2 ];
		    var _y2 = edge_array[ _edge_id + e_edge.y2 ];
			draw_line( _x1, _y1, _x2, _y2 );
			
			var _mx = 0.5*( _x1 + _x2 );
			var _my = 0.5*( _y1 + _y2 );
			draw_text( _mx, _my-20, string( _e ) + "=" + string( _edge_id ) );
		}
	}
	draw_text( _x + 10, _y - 20, "P" + string( _p ) );
	*/
    draw_circle( _x, _y, 5, false );
	draw_set_colour( c_white );
}

for( var _b = 0; _b < _borders_count; _b += e_border.size )
{
	var _path   = border_array[ _b + e_border.path   ];
	var _colour = border_array[ _b + e_border.colour ];
	
	draw_set_colour( _colour );
	for( var _y = -1; _y <= 1; _y++ ) for( var _x = -1; _x <= 1; _x++ )
	{
		matrix_set( matrix_world, matrix_build( _x, _y, 0,   0, 0, 0,   1, 1, 1 ) );
		draw_path( _path, 0, 0, true );
	}
	matrix_set( matrix_world, matrix_build_identity() );
}

draw_set_colour( c_white );
draw_text( 10, 10, "Delaunay algorithm implementation\n2018/02/04\n\n@jujuadams\n\n"
                 + string( _triangles_count / e_triangle.size ) + " triangles\n"
				 + string( _edges_count / e_edge.size ) + " edges\n"
				 + string( _borders_count / e_border.size ) + " borders" );