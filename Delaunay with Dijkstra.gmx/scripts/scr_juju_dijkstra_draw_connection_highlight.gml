///scr_juju_dijkstra_draw_connection_highlight( a, b )

var _a = argument0;
var _b = argument1;

var _x1 = scr_juju_dijkstra_node_get_x( _a );
var _y1 = scr_juju_dijkstra_node_get_y( _a );
var _x2 = scr_juju_dijkstra_node_get_x( _b );
var _y2 = scr_juju_dijkstra_node_get_y( _b );

draw_line( _x1, _y1 + 4, _x2, _y2 + 4 );
draw_line( _x1, _y1 + 5, _x2, _y2 + 5 );
draw_line( _x1, _y1 - 5, _x2, _y2 - 5 );
draw_line( _x1, _y1 - 6, _x2, _y2 - 6 );

