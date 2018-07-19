/// @description edge_on_triangle( x1, y1, x2, y2, px1, py1, px2, py2, px3, py3 )
/// @param  x1
/// @param  y1
/// @param  x2
/// @param  y2
/// @param  px1
/// @param  py1
/// @param  px2
/// @param  py2
/// @param  px3
/// @param  py3 

var _x1 = argument0;
var _y1 = argument1;
var _x2 = argument2;
var _y2 = argument3;

var _tx1 = argument4;
var _ty1 = argument5;
var _tx2 = argument6;
var _ty2 = argument7;
var _tx3 = argument8;
var _ty3 = argument9;

if ( _x1 == _tx1 ) and ( _y1 == _ty1 ) {
    if ( _x2 == _tx2 ) and ( _y2 == _ty2 ) {
        return 1;
    } else if ( _x2 == _tx3 ) and ( _y2 == _ty3 ) {
        return 3;
    }
} else if ( _x1 == _tx2 ) and ( _y1 == _ty2 ) {
    if ( _x2 == _tx1 ) and ( _y2 == _ty1 ) {
        return 1;
    } else if ( _x2 == _tx3 ) and ( _y2 == _ty3 ) {
        return 2;
    }
} else if ( _x1 == _tx3 ) and ( _y1 == _ty3 ) {
    if ( _x2 == _tx1 ) and ( _y2 == _ty1 ) {
        return 3;
    } else if ( _x2 == _tx2 ) and ( _y2 == _ty2 ) {
        return 2;
    }
}

return 0;
