///scr_juju_dijkstra_node_closest( x, y, exclude node )

var _px      = argument0;
var _py      = argument1;
var _exclude = argument2;
    
var _min_i          = noone;
var _min_dist       = 99999999;

with ( global.juju_dijkstra_instance ) {
    
    for( var _i = 0; _i < dijkstra_arr_nodes_size; _i += e_juju_dijkstra_node.size ) {
        
        if ( _i == _exclude ) continue;
        
        var _x = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.x ];
        var _y = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.y ];
        
        var _dist = point_distance( _x, _y, _px, _py );
        
        if ( _dist < _min_dist ) {
            _min_i          = _i;
            _min_dist       = _dist;
        }
        
    }
    
}
    
return _min_i;

