///__scr_juju_dijkstra_connection_closest_below_old( x, y, cutoff y, exclude node )

var _x       = argument0;
var _y       = argument1;
var _cy      = argument2;
var _exclude = argument3;

with ( global.juju_dijkstra_instance ) {
    
    var _min_i          = noone;
    var _min_j          = noone;
    var _min_connection = noone;
    var _min_parameter  = noone;
    var _min_px         = noone;
    var _min_py         = noone;
    var _min_dist       = $FFFFFFFF;
    
    for( var _i = 0; _i < dijkstra_arr_nodes_size; _i += e_juju_dijkstra_node.size ) {
        
        var _x1 = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.x ];
        var _y1 = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.y ];
        var _connections = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.connection_array ];
        var _connections_size = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.connections ];
        
        for( var _j = 0; _j < _connections_size; _j += e_juju_dijkstra_connections.size ) {
            
            var _index = _connections[ _j + e_juju_dijkstra_connections.index ];
            var _type  = _connections[ _j + e_juju_dijkstra_connections.type ];
            
            if ( _index <= _i ) or ( _index == _exclude ) or ( _type != e_juju_dijkstra_path_type.traverse ) continue;
                
            var _x2 = dijkstra_arr_nodes[ _index + e_juju_dijkstra_node.x ];
            var _y2 = dijkstra_arr_nodes[ _index + e_juju_dijkstra_node.y ];
            
            if ( _x < min( _x1, _x2 ) ) or ( _x > max( _x1, _x2 ) ) continue;
            
            var _t = ( _x - _x1 ) / ( _x2 - _x1 );
            var _px = _x;
            var _py = _y1 + ( _y2 - _y1 ) * _t;
            
            if ( _cy > _py ) continue; //If the nearest point on the line is above the cutoff y-value, ignore this point
            
            var _dist = _py - _y;
            
            if ( _dist < _min_dist ) {
                _min_i          = _i;
                _min_j          = _index;
                _min_connection = _j;
                _min_parameter  = _t;
                _min_px         = _px;
                _min_py         = _py;
                _min_dist       = _dist;
            }
            
        }
        
    }
    
    var result;
    result[0] = _min_i;          //node 1
    result[1] = _min_j;          //node 2
    result[2] = _min_connection; //connection on node 1
    result[3] = _min_parameter;  //parameter position along connection
    result[4] = _min_px;         //x position of closest point
    result[5] = _min_py;         //y position of closest point
    result[6] = _min_dist;       //distance from point to point
    if ( _min_i == noone ) or ( _min_connection == noone ) { //global node+connection index
        result[7] = noone;
    } else {
        result[7] = _min_connection + _min_i * 10000;
    }
    return result;
    
}

