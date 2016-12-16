///scr_juju_dijkstra_node_delete( node )

var _node = argument0;

with( global.juju_dijkstra_instance ) {
    
    scr_array_delete( dijkstra_arr_nodes, _node, e_juju_dijkstra_node.size, dijkstra_arr_nodes_size, true );
    dijkstra_arr_nodes_size -= e_juju_dijkstra_node.size;
    
    for( var _i = 0; _i < dijkstra_arr_nodes_size; _i += e_juju_dijkstra_node.size ) {
        
        var _connections = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.connection_array ];
        var _connections_size = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.connections ];
        
        for( var _j = _connections_size - e_juju_dijkstra_connections.size; _j >= 0; _j -= e_juju_dijkstra_connections.size ) {
            
            if ( _connections[ _j + e_juju_dijkstra_connections.index ] == _node ) {
                
                _connections_size = scr_array_delete( _connections, _j, e_juju_dijkstra_connections.size, _connections_size, true );
                dijkstra_arr_nodes[@ _i + e_juju_dijkstra_node.connections ] = _connections_size;
                
            } else if ( _connections[ _j + e_juju_dijkstra_connections.index ] > _node ) {
                
                _connections[@ _j + e_juju_dijkstra_connections.index ] -= e_juju_dijkstra_node.size;
                
            }
            
        }
        
    }

}

