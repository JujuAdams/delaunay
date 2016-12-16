///scr_juju_dijkstra_connection_jump_parameters( connection )

var _connection = argument0;

if ( _connection >= 0 ) {
    with( global.juju_dijkstra_instance ) {
        
        var _node = _connection div 10000;
        _connection -= _node * 10000;
        var _connections = dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.connection_array ];
        return _connections[ _connection + e_juju_dijkstra_connections.parameters ];
    
    }
}

return undefined;

