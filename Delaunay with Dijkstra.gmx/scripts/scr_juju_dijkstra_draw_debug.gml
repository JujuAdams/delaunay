///scr_juju_dijkstra_draw_debug( show distances, show weights, show arrows, show nodes, show node data )
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

var _show_distances   = argument0;
var _show_weights     = argument1;
var _show_arrows      = argument2;
var _show_nodes       = argument3;
var _show_node_data   = argument4;
var _show_connections = argument5;

with( global.juju_dijkstra_instance ) {
    
    for( var _i = 0; _i < dijkstra_arr_nodes_size; _i += e_juju_dijkstra_node.size ) {
        
        var _x1              = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.x ];
        var _y1              = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.y ];
        var _connections     = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.connection_array ];
        var _connection_size = dijkstra_arr_nodes[ _i + e_juju_dijkstra_node.connections ];
        
        draw_set_colour( c_yellow );
        if ( _show_nodes ) draw_circle( _x1, _y1, 4, false );
        draw_set_colour( c_black );
        //if ( _show_node_data ) draw_text( _x1, _y1, string( _i ) + "\" + string( _i * e_juju_dijkstra_node.size ) + "=" + string( _x1 ) + "," + string( _y1 ) );
        if ( _show_node_data ) draw_text( _x1, _y1, string( _i ) );
        draw_set_colour( c_white );
        
        for( var _j = 0; _j < _connection_size; _j += e_juju_dijkstra_connections.size ) {
            
            var _index     = _connections[ _j + e_juju_dijkstra_connections.index ];
            var _type      = _connections[ _j + e_juju_dijkstra_connections.type ];
            var _distance  = _connections[ _j + e_juju_dijkstra_connections.distance ];
            var _weight    = _connections[ _j + e_juju_dijkstra_connections.weight ];
            var _params    = _connections[ _j + e_juju_dijkstra_connections.parameters ];
            
            var _x2 = dijkstra_arr_nodes[ _index + e_juju_dijkstra_node.x ];
            var _y2 = dijkstra_arr_nodes[ _index + e_juju_dijkstra_node.y ];
            var _mx = mean( _x1, _x2 );
            var _my = mean( _y1, _y2 );
            
            switch( _type ) {
                case e_juju_dijkstra_path_type.traverse:
                    draw_set_colour( c_yellow );
                break;
                case e_juju_dijkstra_path_type.jump: 
                    draw_set_colour( c_orange );
                break;
            }
            
            if ( _show_arrows ) draw_arrow( _x1, _y1, _x2, _y2, 8 ) else if ( _show_connections ) draw_line( _x1, _y1, _x2, _y2 );
            
            var _str = "";
            
            if ( _show_distances ) _str  = string( _distance ) + "#";
            if ( _show_weights )   _str += string( _weight );
            
            if ( _str != "" ) and ( _type != e_juju_dijkstra_path_type.jump ) {
                //var _direction = point_direction( _x1, _y1, _x2, _y2 );
                //draw_text_transformed( _mx, _my, _str, 1, 1, _direction - 90 );
                if ( _x2 > _x1 ) {
                    draw_text( _mx, _my - 15, _str );
                } else {
                    draw_text( _mx, _my + 15, _str );
                }
            }
            
        }
        
    }
    
}

draw_set_colour( c_white );

