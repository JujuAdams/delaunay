///scr_juju_dijkstra_path_add_weight( path, weight )

var _path  = argument0;
var _weight = argument1;

var _size = ds_list_size( _path );
for( var _i = 0; _i < _size; _i += e_juju_dijkstra_path.size ) {
    
    var _connection = ds_list_find_value( _path, _i + e_juju_dijkstra_path.connection );
    scr_juju_dijkstra_connection_add_weight( _connection, _weight );
    
}

