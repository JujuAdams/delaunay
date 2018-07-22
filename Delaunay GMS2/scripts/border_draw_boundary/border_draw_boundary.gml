/// @param border_index
/// @param colour
/// @param alpha
/// @param thickness

var _border    = argument0;
var _colour    = argument1;
var _alpha     = argument2;
var _thickness = argument3;

if ( _colour == undefined ) || ( _colour < 0 ) _colour = border_array[ _border + e_border.colour ];
var _boundary_vbuff = border_array[ _border + e_border.boundary_vbuff ];
var _length         = border_array[ _border + e_border.length         ];

if ( _boundary_vbuff == undefined ) || ( _length <= 0 ) || ( _alpha <= 0 ) exit;

shader_set( shd_boundary );
shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vRGBA" ),
		                colour_get_red(   _colour )/255,
						colour_get_green( _colour )/255,
						colour_get_blue(  _colour )/255,
						_alpha );
shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vThickness" ),
		                _thickness );
vertex_submit( _boundary_vbuff, pr_trianglelist, -1 );
shader_reset();

/*
//Code that doesn't work yet :(
gpu_set_tex_repeat( true );
shader_set( shd_boundary );
shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vRGBA" ),
		                colour_get_red(   _colour )/255,
						colour_get_green( _colour )/255,
						colour_get_blue(  _colour )/255,
						_alpha );
shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vThickness" ),
		                _thickness );
shader_set_uniform_f( shader_get_uniform( shader_current(), "u_fRepeats" ),
		                1 );
		                //floor( _length / 64 ) );
shader_set_uniform_f( shader_get_uniform( shader_current(), "u_fOffset" ),
		                1 );
		                //current_time/1000 );
vertex_submit( _boundary_vbuff, pr_trianglelist, sprite_get_texture( spr_boundary_texture, 0 ) );
shader_reset();
gpu_set_tex_repeat( false );
*/