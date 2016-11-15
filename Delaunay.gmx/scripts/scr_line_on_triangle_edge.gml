///scr_line_on_triangle_edge( x1, y1, x2, y2, px1, py1, px2, py2, px3, py3 )

var _x1 = argument0;
var _y1 = argument1;
var _x2 = argument2;
var _y2 = argument3;

var _px1 = argument4;
var _py1 = argument5;
var _px2 = argument6;
var _py2 = argument7;
var _px3 = argument8;
var _py3 = argument9;

if ( _x1 == _px1 ) and ( _y1 == _py1 ) {
    if ( _x2 == _px2 ) and ( _y2 == _py2 ) {
        return true;
    } else if ( _x2 == _px3 ) and ( _y2 == _py3 ) {
        return true;
    }
} else if ( _x1 == _px2 ) and ( _y1 == _py2 ) {
    if ( _x2 == _px1 ) and ( _y2 == _py1 ) {
        return true;
    } else if ( _x2 == _px3 ) and ( _y2 == _py3 ) {
        return true;
    }
} else if ( _x1 == _px3 ) and ( _y1 == _py3 ) {
    if ( _x2 == _px1 ) and ( _y2 == _py1 ) {
        return true;
    } else if ( _x2 == _px3 ) and ( _y2 == _py3 ) {
        return true;
    }
}

return false;
