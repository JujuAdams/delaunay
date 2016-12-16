///scr_juju_dijkstra_connection_segment( a, b, t, type )

var _a    = argument0;
var _b    = argument1;
var _t    = argument2;
var _type = argument3;

var _x = lerp( scr_juju_dijkstra_node_get_x( _a ), scr_juju_dijkstra_node_get_x( _b ), _t );
var _y = lerp( scr_juju_dijkstra_node_get_y( _a ), scr_juju_dijkstra_node_get_y( _b ), _t );
var _n = scr_juju_dijkstra_node_add( _x, _y );

scr_juju_dijkstra_connect_twin( _n, _a, scr_juju_dijkstra_node_node_distance( _n, _a ), 0, _type, undefined );
scr_juju_dijkstra_connect_twin( _n, _b, scr_juju_dijkstra_node_node_distance( _n, _b ), 0, _type, undefined );

return _n;

