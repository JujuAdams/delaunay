///scr_juju_dijkstra_path_find( start node, end node, include weights, debug )
// 
// 15th June 2016
// @jujuadams
// /u/JujuAdam
// 
// Copyright (c) 2015 Julian T. Adams
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
// modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
// is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

var _origin      = argument0;
var _target      = argument1;
var _inc_weights = argument2;
var _ext         = argument3;

with( global.juju_dijkstra_instance ) {
    
    if ( _ext ) cout( "trigger" );
    
    var _path = ds_list_create();
    
    if ( _origin == _target ) {
        scr_juju_dijkstra_path_add( _path, scr_juju_dijkstra_node_get_x( _origin ), scr_juju_dijkstra_node_get_y( _origin ), _origin,
                                           scr_juju_dijkstra_node_get_x( _origin ), scr_juju_dijkstra_node_get_y( _origin ), _origin,
                                           undefined, e_juju_dijkstra_path_type.traverse, 1 );
        scr_juju_dijkstra_path_add( _path, scr_juju_dijkstra_node_get_x( _origin ), scr_juju_dijkstra_node_get_y( _origin ), _origin,
                                           scr_juju_dijkstra_node_get_x( _origin ), scr_juju_dijkstra_node_get_y( _origin ), _origin,
                                           undefined, e_juju_dijkstra_path_type.traverse, 1 );
        return _target;
    }
    
    var _priority = ds_priority_create();
    
    if ( _ext ) cout( dijkstra_arr_nodes_size );
    
    //Reset node values
    for( var _i = 0; _i < dijkstra_arr_nodes_size; _i += e_juju_dijkstra_node.size ) {
        dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.distance_to_origin ] = 999999;
        dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.previous_node ]      = noone;
        dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.visited ]            = false;
        ds_priority_add( _priority, _i, 999999 );
    }
    
    //Set data for origin node
    if ( _ext ) cout( "origin", _origin );
    dijkstra_arr_nodes[ _origin + e_juju_dijkstra_node.distance_to_origin ] = 0;
    dijkstra_arr_nodes[ _origin + e_juju_dijkstra_node.previous_node ]      = noone;
    dijkstra_arr_nodes[ _origin + e_juju_dijkstra_node.visited ]            = true;
    ds_priority_delete_value( _priority, _origin );
    
    var _node = _origin;
    do {
        
        if ( _ext ) cout( "node", _node );
        
        //Set this node to visited
        dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.visited ] = true;
        
        var _distance_to_origin = dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.distance_to_origin ];
        var _connections        = dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.connection_array ];
        var _connections_size   = dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.connections ];
        
        for( var _i = 0; _i < _connections_size; _i += e_juju_dijkstra_connections.size ) {
            
            var _other_node = _connections[ _i + e_juju_dijkstra_connections.index ];
            
            if ( _ext ) cout( "    checking connection to node", _other_node );
            
            if ( dijkstra_arr_nodes[ _other_node + e_juju_dijkstra_node.visited ] ) {
                if ( _ext ) cout( "        rejected" );
                continue;
            }
            
            var _old_distance = dijkstra_arr_nodes[ _other_node + e_juju_dijkstra_node.distance_to_origin ];
            
            var                 _new_distance  = _distance_to_origin;
                                _new_distance += _connections[ _i + e_juju_dijkstra_connections.distance ];
            if ( _inc_weights ) _new_distance += _connections[ _i + e_juju_dijkstra_connections.weight ];
            
            if ( _ext ) cout( "        new distance", _new_distance, "old", _old_distance );
            
            if ( _new_distance < _old_distance ) {
                if ( _ext ) cout( "        accepted" );
                dijkstra_arr_nodes[ _other_node + e_juju_dijkstra_node.previous_node ]       = _node;
                dijkstra_arr_nodes[ _other_node + e_juju_dijkstra_node.previous_connection ] = _node * 10000 + _i;
                dijkstra_arr_nodes[ _other_node + e_juju_dijkstra_node.previous_type ]       = _connections[ _i + e_juju_dijkstra_connections.type ];
                dijkstra_arr_nodes[ _other_node + e_juju_dijkstra_node.distance_to_origin ]  = _new_distance;
                ds_priority_change_priority( _priority, _other_node, _new_distance );
            }
            
        }
        
        _node = ds_priority_delete_min( _priority );
        
    } until ds_priority_empty( _priority );
    
    if ( dijkstra_arr_nodes[ _target + e_juju_dijkstra_node.distance_to_origin ] == 999999 ) {
        show_debug_message( "(" + string( current_time ) + ") scr_juju_dijkstra_path_find: Error! No path found! " + string( _origin ) + " -> " + string( _target ) );
        ds_list_destroy( _path );
        return noone;
    }
    
    if ( _ext ) cout( "---" );
    
    _node = _target;
    do {
        if ( _ext ) cout( _node );
        var _prev_node = dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.previous_node ];
        if ( _prev_node < 0 ) _prev_node = _node;
        scr_juju_dijkstra_path_insert( _path, 0,
                                       dijkstra_arr_nodes[ _prev_node + e_juju_dijkstra_node.x ],
                                       dijkstra_arr_nodes[ _prev_node + e_juju_dijkstra_node.y ],
                                       _prev_node,
                                       dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.x ],
                                       dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.y ],
                                       _node,
                                       dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.previous_connection ],
                                       dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.previous_type ],
                                       dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.distance_to_origin ] );
        _node = dijkstra_arr_nodes[ _node + e_juju_dijkstra_node.previous_node ];
    } until ( _node < 0 );                     
    
    if ( _ext ) cout( "---" );
    
    ds_priority_destroy( _priority );
    return _path;

}

return noone;

