///scr_juju_dijkstra_node_add( x, y )
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
    
    var array;
    array[0] = noone;
    
    dijkstra_arr_nodes[ dijkstra_arr_nodes_size + e_juju_dijkstra_node.x ]                   = argument0;
    dijkstra_arr_nodes[ dijkstra_arr_nodes_size + e_juju_dijkstra_node.y ]                   = argument1;
    dijkstra_arr_nodes[ dijkstra_arr_nodes_size + e_juju_dijkstra_node.connection_array ]    = array;
    dijkstra_arr_nodes[ dijkstra_arr_nodes_size + e_juju_dijkstra_node.connections ]         = 0;
    dijkstra_arr_nodes[ dijkstra_arr_nodes_size + e_juju_dijkstra_node.distance_to_origin ]  = $FFFFFFFF;
    dijkstra_arr_nodes[ dijkstra_arr_nodes_size + e_juju_dijkstra_node.previous_node ]       = noone;
    dijkstra_arr_nodes[ dijkstra_arr_nodes_size + e_juju_dijkstra_node.previous_type ]       = e_juju_dijkstra_path_type.traverse;
    dijkstra_arr_nodes[ dijkstra_arr_nodes_size + e_juju_dijkstra_node.previous_connection ] = noone;
    dijkstra_arr_nodes[ dijkstra_arr_nodes_size + e_juju_dijkstra_node.visited ]             = false;
    
    dijkstra_arr_nodes_size += e_juju_dijkstra_node.size;
    
    return dijkstra_arr_nodes_size - e_juju_dijkstra_node.size;
    
}

