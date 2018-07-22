/// @param border_index
/// @param colour
/// @param alpha

var _border = argument0;
var _colour = argument1;
var _alpha  = argument2;

if ( _colour == undefined ) || ( _colour < 0 ) _colour = border_array[ _border + e_border.colour ];
var _region_vbuff = border_array[ _border + e_border.region_vbuff ];

if ( _region_vbuff == undefined ) || ( _alpha <= 0 ) exit;

shader_set( shd_border_region );
shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vRGBA" ),
		                colour_get_red(   _colour )/255,
						colour_get_green( _colour )/255,
						colour_get_blue(  _colour )/255,
						_alpha );
vertex_submit( _region_vbuff, pr_trianglelist, -1 );
shader_reset();