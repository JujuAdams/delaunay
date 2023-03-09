/// @param border_index
/// @param colour
/// @param alpha
/// @param sprite
/// @param image
/// @param x_offset
/// @param y_offset
function border_draw_region(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {

	var _border  = argument0;
	var _colour  = argument1;
	var _alpha   = argument2;
	var _sprite  = argument3;
	var _image   = argument4;
	var _xoffset = argument5;
	var _yoffset = argument6;

	if ( _colour == undefined ) || ( _colour < 0 ) _colour = border_array[ _border + e_border.colour ];
	var _region_vbuff = border_array[ _border + e_border.region_vbuff ];

	if ( _region_vbuff == undefined ) || ( _alpha <= 0 ) exit;

	var _old_tex_repeat = gpu_get_tex_repeat();
	gpu_set_tex_repeat( true );
	shader_set( shd_border_region );

	shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vOffset" ),
	                      _xoffset, _yoffset );

	shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vTextureSize" ),
	                      sprite_get_width( _sprite ), sprite_get_height( _sprite ) );
					  
	shader_set_uniform_f( shader_get_uniform( shader_current(), "u_vRGBA" ),
			              colour_get_red(   _colour )/255,
						  colour_get_green( _colour )/255,
						  colour_get_blue(  _colour )/255,
						  _alpha );
					  
	vertex_submit( _region_vbuff, pr_trianglelist, sprite_get_texture( _sprite, _image ) );
	shader_reset();
	gpu_set_tex_repeat( _old_tex_repeat );


}
