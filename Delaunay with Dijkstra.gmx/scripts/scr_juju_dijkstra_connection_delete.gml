///scr_juju_dijkstra_connection_delete( a, b )

var _a = argument0;
var _b = argument1;

with( global.juju_dijkstra_instance ) {
    
    var _connections = dijkstra_arr_nodes[ _a + e_juju_dijkstra_node.connection_array ];
    var _connections_size = dijkstra_arr_nodes[ _a + e_juju_dijkstra_node.connections ];
    
    for( var _i = 0; _i < _connections_size; _i += e_juju_dijkstra_connections.size ) {
        
        if ( _connections[ _i + e_juju_dijkstra_connections.index ] == _b ) {
            
            _connections_size = scr_array_delete( _connections, _i, e_juju_dijkstra_connections.size, _connections_size, true );
            dijkstra_arr_nodes[@ _a + e_juju_dijkstra_node.connections ] = _connections_size;
            break;
            
        }
        
    }
    
    var _connections = dijkstra_arr_nodes[ _b + e_juju_dijkstra_node.connection_array ];
    var _connections_size = dijkstra_arr_nodes[ _b + e_juju_dijkstra_node.connections ];
    
    for( var _i = 0; _i < _connections_size; _i += e_juju_dijkstra_connections.size ) {
        
        if ( _connections[ _i + e_juju_dijkstra_connections.index ] == _a ) {
            
            _connections_size = scr_array_delete( _connections, _i, e_juju_dijkstra_connections.size, _connections_size, true );
            dijkstra_arr_nodes[@ _b + e_juju_dijkstra_node.connections ] = _connections_size;
            break;
            
        }
        
    }

}

