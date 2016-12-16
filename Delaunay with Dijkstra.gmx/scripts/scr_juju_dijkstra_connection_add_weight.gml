///scr_juju_dijkstra_connection_add_weight( connection, weight )

var _connection = argument0;
var _weight     = argument1;

if ( is_undefined( _connection ) ) or ( _connection < 0 ) exit;

with( global.juju_dijkstra_instance ) {
    
    var _node = _connection div 10000;
    if ( _node >= dijkstra_arr_nodes_size ) exit;
    _connection -= _node * 10000;
    
    var _connections = dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.connections ];
    if ( _connection >= _connections ) exit;
    
    var _connection_array = dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.connection_array ];
    var _found_weight = _connection_array[ _connection + e_juju_dijkstra_connections.weight ];
    
    if ( !is_undefined( _found_weight ) ) _connection_array[@ _connection + e_juju_dijkstra_connections.weight ] = _found_weight + _weight;

}

