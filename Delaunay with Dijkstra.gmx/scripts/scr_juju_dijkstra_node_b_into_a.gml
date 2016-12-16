///scr_juju_dijkstra_node_b_into_a( node a, node b )
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

var _a = argument0;
var _b = argument1;

with( global.juju_dijkstra_instance ) {
    
    var _connections1 = dijkstra_arr_nodes[ _a + e_juju_dijkstra_node.connection_array ];
    var _connections1_size = dijkstra_arr_nodes[ _a + e_juju_dijkstra_node.connections ];
    
    var _connections2 = dijkstra_arr_nodes[ _b + e_juju_dijkstra_node.connection_array ];
    var _connections2_size = dijkstra_arr_nodes[ _b + e_juju_dijkstra_node.connections ];
    
    //For all connections in _b
    for( var _i = 0; _i < _connections2_size; _i += e_juju_dijkstra_connections.size ) {
        
        var _found = false;
        
        var _index = _connections2[ _i + e_juju_dijkstra_connections.index ];
        
        //Check if the destination node is in _a
        for( var _j = 0; _j < _connections1_size; _j += e_juju_dijkstra_connections.size ) {
            
            if ( _index == _connections1[ _j + e_juju_dijkstra_connections.index ] ) {
                _found = true;
                break;
            }
            
        }
        
        //If it's not in _a, add it
        if ( !_found ) {
            
            _connections1[@ _connections1_size + e_juju_dijkstra_connections.index ] = _index;
            
            for( var _j = 0; _j < e_juju_dijkstra_connections.size; _j++ ) {
                if ( _j == e_juju_dijkstra_connections.index ) continue;
                _connections1[@ _connections1_size + _j ] = _connections2[ _i + _j ];
            }
            
            /*
            _connections1[@ _connections1_size + e_juju_dijkstra_connections.index ]      = _index;
            _connections1[@ _connections1_size + e_juju_dijkstra_connections.distance ]   = _connections2[ _i + e_juju_dijkstra_connections.distance ];
            _connections1[@ _connections1_size + e_juju_dijkstra_connections.weight ]     = _connections2[ _i + e_juju_dijkstra_connections.weight ];
            _connections1[@ _connections1_size + e_juju_dijkstra_connections.type ]       = _connections2[ _i + e_juju_dijkstra_connections.type ];
            _connections1[@ _connections1_size + e_juju_dijkstra_connections.parameters ] = _connections2[ _i + e_juju_dijkstra_connections.parameters ];
            */
            
            _connections1_size += e_juju_dijkstra_connections.size;
            dijkstra_arr_nodes[@ _a + e_juju_dijkstra_node.connections ] = _connections1_size;
            
        }
        
    }
    
    //Replace all mentions of _b with _a in connections
    for( var _i = 0; _i < dijkstra_arr_nodes_size; _i += e_juju_dijkstra_node.size ) {
        
        var _connections = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.connection_array ];
        var _connections_size = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.connections ];
        
        for( var _j = 0; _j < _connections_size; _j += e_juju_dijkstra_connections.size ) {
            if ( _connections[ _j + e_juju_dijkstra_connections.index ] == _b ) {
                _connections[@ _j + e_juju_dijkstra_connections.index ] = _a;
            }
        }
        
    }
    
    //Remove _b
    scr_juju_dijkstra_node_delete( _b );
    
}

