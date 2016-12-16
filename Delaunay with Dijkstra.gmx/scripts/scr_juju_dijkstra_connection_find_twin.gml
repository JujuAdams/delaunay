///scr_juju_dijkstra_connection_find_twin( connection )

var _a_connection = argument0;

if ( _a_connection < 0 ) return noone;

with( global.juju_dijkstra_instance ) {
    
    var _a = _a_connection div 10000;
    _a_connection -= _a * 10000;
    
    var _a_connections = dijkstra_arr_nodes[ _a + e_juju_dijkstra_node.connection_array ];
    var _b = _a_connections[@ _a_connection + e_juju_dijkstra_connections.index ];
    
    var _size = dijkstra_arr_nodes[ _b + e_juju_dijkstra_node.size ];
    var _b_connections = dijkstra_arr_nodes[ _b + e_juju_dijkstra_node.connection_array ];
    
    for( var _i = 0; _i < _size; _i += e_juju_dijkstra_connections.size ) {
        var _b_index = _b_connections[@ _i + e_juju_dijkstra_connections.index ];
        if ( _b_index == _a ) return _i + _b * 10000;
    }

}

return noone;

