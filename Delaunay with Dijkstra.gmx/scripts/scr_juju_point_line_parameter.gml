///scr_juju_point_line_parameter( px, py, x1, y1, x2, y2 )
//
// Based on http://www.gmlscripts.com/script/lines_intersect by @xotmatrix

gml_pragma( "forceinline" );

var dx = argument4 - argument2;
var dy = argument5 - argument3;
return clamp( ( dx*( argument0 - argument2 ) + dy*( argument1 - argument3 ) ) / ( dx*dx + dy*dy ), 0, 1 );
