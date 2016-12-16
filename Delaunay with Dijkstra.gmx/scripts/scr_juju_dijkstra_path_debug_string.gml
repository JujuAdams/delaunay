///scr_juju_dijkstra_path_debug_string( path )

var _list = argument0;
var _str = "";

var _size = ds_list_size( _list );
for( var _i = 0; _i < _size; _i++ ) {
    if ( _i > 0 ) _str += chr( 13 );
    
    switch( _i mod e_juju_dijkstra_path.size ) {
        case e_juju_dijkstra_path.start_x:            _str += "start_x = ";            break;
        case e_juju_dijkstra_path.start_y:            _str += "start_y = ";            break;
        case e_juju_dijkstra_path.start_node:         _str += "start_node = ";         break;
        case e_juju_dijkstra_path.end_x:              _str += "end_x = ";              break;
        case e_juju_dijkstra_path.end_y:              _str += "end_y = ";              break;
        case e_juju_dijkstra_path.end_node:           _str += "end_node = ";           break;
        case e_juju_dijkstra_path.connection:         _str += "connection = ";         break;
        case e_juju_dijkstra_path.type:               _str += "type = ";               break;
        case e_juju_dijkstra_path.distance_to_origin: _str += "distance_to_origin = "; break;
    }
    
    _str += string( ds_list_find_value( _list, _i ) );
    if ( _i > 0 ) and ( _i mod e_juju_dijkstra_path.size == e_juju_dijkstra_path.size - 1 ) _str += chr( 13 ) + "--------";
    
}

return _str;


