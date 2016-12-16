///scr_juju_dijkstra_path_string( path )

var _path = argument0;

var _str = "";

var _size = ds_list_size( _path );
for( var _i = 0; _i < _size; _i += e_juju_dijkstra_path.size ) {
    
    var _start_x = ds_list_find_value( _path, _i + e_juju_dijkstra_path.start_x );
    var _start_y = ds_list_find_value( _path, _i + e_juju_dijkstra_path.start_y );
    var _end_x = ds_list_find_value( _path, _i + e_juju_dijkstra_path.end_x );
    var _end_y = ds_list_find_value( _path, _i + e_juju_dijkstra_path.end_y );
    
    if ( is_undefined( _start_x ) ) or ( is_undefined( _start_y ) ) or ( is_undefined( _end_x ) ) or ( is_undefined( _end_y ) ) continue;
    
    _str += chr(13) + string( _start_x ) + "," + string( _start_y ) + " -> " + string( _end_x ) + "," + string( _end_y );
    
}

return _str;

