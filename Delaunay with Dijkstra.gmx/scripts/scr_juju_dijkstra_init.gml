///scr_juju_dijkstra_init()
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

global.juju_dijkstra_instance = id;

persistent = true;

enum e_juju_dijkstra_node { x, y, connection_array, connections, distance_to_origin,
                            previous_node, previous_connection, previous_type, visited,
                            size };

enum e_juju_dijkstra_connections { index, distance, weight, type, parameters, size }; //Don't forget to update scr_juju_dijkstra_merge_b_into_a()!

enum e_juju_dijkstra_path { start_x, start_y, start_node,
                            end_x, end_y, end_node,
                            connection, type, distance_to_origin, size };

enum e_juju_dijkstra_path_type { traverse, jump };

dijkstra_arr_nodes_size = 0;
dijkstra_arr_nodes[0] = noone;

