///scr_juju_dijkstra_connect( node a, node b, distance, weight, type, parameters )
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

var _a     = argument0;
var _b     = argument1;
var _d     = argument2;
var _w     = argument3;
var _t     = argument4;
var _param = argument5;

var _copy = _param;

with( global.juju_dijkstra_instance ) {
    
    var _connections = dijkstra_arr_nodes[ _a + e_juju_dijkstra_node.connection_array ];
    var _connections_size = dijkstra_arr_nodes[ _a + e_juju_dijkstra_node.connections ];
    
    _connections[@ _connections_size + e_juju_dijkstra_connections.index ]      = _b;
    _connections[@ _connections_size + e_juju_dijkstra_connections.distance ]   = _d;
    _connections[@ _connections_size + e_juju_dijkstra_connections.weight ]     = _w;
    _connections[@ _connections_size + e_juju_dijkstra_connections.type ]       = _t;
    _connections[@ _connections_size + e_juju_dijkstra_connections.parameters ] = _copy;
    
    dijkstra_arr_nodes[@ _a + e_juju_dijkstra_node.connections ] += e_juju_dijkstra_connections.size;
    
}

