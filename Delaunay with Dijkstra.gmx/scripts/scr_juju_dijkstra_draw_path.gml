///scr_juju_dijkstra_draw_path( path, colour, show nodes )

var _path       = argument0;
var _colour     = argument1;
var _show_nodes = argument2;

draw_set_colour( _colour );

var _size = ds_list_size( _path );
for( var _i = 0; _i < _size; _i += e_juju_dijkstra_path.size ) {
    
    var _start_x = ds_list_find_value( _path, _i + e_juju_dijkstra_path.start_x );
    var _start_y = ds_list_find_value( _path, _i + e_juju_dijkstra_path.start_y );
    var _end_x = ds_list_find_value( _path, _i + e_juju_dijkstra_path.end_x );
    var _end_y = ds_list_find_value( _path, _i + e_juju_dijkstra_path.end_y );
    
    if ( _show_nodes ) {
        draw_circle( _start_x, _start_y, 4, false );
        draw_circle( _end_x, _end_y, 4, false );
    }
    
    draw_line_width( _start_x, _start_y, _end_x, _end_y, 4 );
    
}

draw_set_colour( c_white );

