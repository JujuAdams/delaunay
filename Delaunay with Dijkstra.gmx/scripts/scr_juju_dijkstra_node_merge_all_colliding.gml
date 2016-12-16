///scr_juju_dijkstra_node_merge_all_colliding()
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


with( global.juju_dijkstra_instance ) {
    
    do {
        
        var _merged = false;
        
        for( var _i = dijkstra_arr_nodes_size - e_juju_dijkstra_node.size; _i >= e_juju_dijkstra_node.size; _i -= e_juju_dijkstra_node.size ) {
            
            var _x1 = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.x ];
            var _y1 = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.y ];
            
            for( var _j = _i - e_juju_dijkstra_node.size; _j >= 0; _j -= e_juju_dijkstra_node.size ) {
                
                var _x2 = dijkstra_arr_nodes[ _j + e_juju_dijkstra_node.x ];
                var _y2 = dijkstra_arr_nodes[ _j + e_juju_dijkstra_node.y ];
                
                if ( point_distance( _x1, _y1, _x2, _y2 ) < 1.5 ) {
                    scr_juju_dijkstra_node_b_into_a( _j, _i );
                    _merged = true;
                    break;
                }
                
            }
            
        }
        
    } until ( !_merged );
    
}

