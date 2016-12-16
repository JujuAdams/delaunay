///delaunary_to_dijkstra()

var _dijkstra_lookup = ds_map_create();

for( var _i = 0; _i < points_count _i += e_point.size ) {
    var _x = points[ _i + e_point.x ];
    var _y = points[ _i + e_point.y ];
    ds_map_add( _dijkstra_lookup, string( _x ) + "," + string( _y ), dijkstra_arr_nodes_size );
    scr_juju_dijkstra_node_add( _x, _y );
}

for( var _d = 0; _d < dijkstra_arr_nodes_size; _d += e_juju_dijkstra_node.size ) {
    
    var _x = scr_juju_dijkstra_node_get_x( _d );
    var _y = scr_juju_dijkstra_node_get_y( _d );
    
    for( var _t = 0; _t < triangles_count; _t += e_triangle.size ) {
        
        var _x1 = triangles[ _t + e_triangle.x1 ];
        var _y1 = triangles[ _t + e_triangle.y1 ];
        var _node1 = ds_map_find_value( _dijkstra_lookup, string( _x1 ) + "," + string( _y1 ) );
        var _x2 = triangles[ _t + e_triangle.x2 ];
        var _y2 = triangles[ _t + e_triangle.y2 ];
        var _node2 = ds_map_find_value( _dijkstra_lookup, string( _x2 ) + "," + string( _y2 ) );
        var _x3 = triangles[ _t + e_triangle.x3 ];
        var _y3 = triangles[ _t + e_triangle.y3 ];
        var _node3 = ds_map_find_value( _dijkstra_lookup, string( _x3 ) + "," + string( _y3 ) );
        
        if ( _x == _x1 ) and ( _y == _y1 ) {
            scr_juju_dijkstra_connect( _d, _node2, scr_juju_dijkstra_node_node_distance( _d, _node2 ), 0, e_juju_dijkstra_path_type.traverse, undefined );
            scr_juju_dijkstra_connect( _d, _node3, scr_juju_dijkstra_node_node_distance( _d, _node3 ), 0, e_juju_dijkstra_path_type.traverse, undefined );
        }
        
        if ( _x == _x2 ) and ( _y == _y2 ) {
            scr_juju_dijkstra_connect( _d, _node3, scr_juju_dijkstra_node_node_distance( _d, _node3 ), 0, e_juju_dijkstra_path_type.traverse, undefined );
            scr_juju_dijkstra_connect( _d, _node1, scr_juju_dijkstra_node_node_distance( _d, _node1 ), 0, e_juju_dijkstra_path_type.traverse, undefined );
        }
        
        if ( _x == _x3 ) and ( _y == _y3 ) {
            scr_juju_dijkstra_connect( _d, _node1, scr_juju_dijkstra_node_node_distance( _d, _node1 ), 0, e_juju_dijkstra_path_type.traverse, undefined );
            scr_juju_dijkstra_connect( _d, _node2, scr_juju_dijkstra_node_node_distance( _d, _node2 ), 0, e_juju_dijkstra_path_type.traverse, undefined );
        }
        
    }
    
}

ds_map_destroy( _dijkstra_lookup );
