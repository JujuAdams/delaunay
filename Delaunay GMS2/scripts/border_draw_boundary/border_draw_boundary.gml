/// @param border_index
/// @param colour
/// @param alpha
/// @param thickness
/// @param sprite
/// @oaram image
/// @param offset

var _border    = argument0;
var _colour    = argument1;
var _alpha     = argument2;
var _thickness = argument3;
var _sprite    = argument4;
var _image     = argument5;
var _offset    = argument6;

if ( _colour == undefined ) || ( _colour < 0 ) _colour = border_array[ _border + e_border.colour ];
var _boundary_vbuff = border_array[ _border + e_border.boundary_vbuff ];
var _length         = border_array[ _border + e_border.length         ];

if ( _boundary_vbuff == undefined ) || ( _length <= 0 ) || ( _alpha <= 0 ) exit;

var _old_tex_repeat = gpu_get_tex_repeat();
gpu_set_tex_repeat( true );
shader_set( shd_border_boundary );
shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vRGBA" ),
		                colour_get_red(   _colour )/255,
						colour_get_green( _colour )/255,
						colour_get_blue(  _colour )/255,
						_alpha );
shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vThickness" ),
		                _thickness );
shader_set_uniform_f( shader_get_uniform( shader_current(), "u_fRepeats" ),
		                floor( _length / sprite_get_width( _sprite ) ) );
shader_set_uniform_f( shader_get_uniform( shader_current(), "u_fOffset" ),
		                _offset );
vertex_submit( _boundary_vbuff, pr_trianglelist, sprite_get_texture( _sprite, _image ) );
shader_reset();
gpu_set_tex_repeat( _old_tex_repeat );