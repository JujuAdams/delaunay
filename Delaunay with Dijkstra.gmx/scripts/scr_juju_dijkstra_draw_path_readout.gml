///scr_juju_dijkstra_draw_path_readout( path, colour )
/*
var _path   = argument0;
var _colour = argument1;

draw_set_colour( _colour );
draw_text(   5, 80, string( id ) );
draw_text( 105, 80, string( x ) );
draw_text( 205, 80, string( y ) );
draw_text( 305, 80, string( traverse_t ) );
draw_text( 405, 80, string( parabola_t ) );
draw_text( 505, 80, string( parabola ) );

var _size = ds_list_size( _path );
for( var _i = 0; _i < _size; _i += e_juju_dijkstra_path.size ) {
    
    var _start_x = ds_list_find_value( _path, _i + e_juju_dijkstra_path.start_x );
    var _start_y = ds_list_find_value( _path, _i + e_juju_dijkstra_path.start_y );
    var _end_x = ds_list_find_value( _path, _i + e_juju_dijkstra_path.end_x );
    var _end_y = ds_list_find_value( _path, _i + e_juju_dijkstra_path.end_y );
    
    //if ( is_undefined( _start_x ) ) or ( is_undefined( _start_y ) ) or ( is_undefined( _end_x ) ) or ( is_undefined( _end_y ) ) continue;
    
    var _line_y = 100 + _i * 5;
    draw_text(   5, _line_y, string( _start_x ) );
    draw_text( 105, _line_y, string( _start_y ) );
    draw_text( 205, _line_y, "-> " + string( _end_x ) );
    draw_text( 305, _line_y, string( _end_y ) );
    
}
draw_set_colour( c_white );
*/
