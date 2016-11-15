///scr_delaunay_bowyer_watson( points, left, top, right, bottom )

var _points = argument0;
var _left   = argument1;
var _top    = argument2;
var _right  = argument3;
var _bottom = argument4;

/*
var _min_x =  999999;
var _min_y =  999999;
var _max_x = -999999;
var _max_y = -999999;

for( var _p = 0; _p < points_count; _p += e_point.size ) {
    
    var _x = _points[ e_point.x + _p ];
    var _y = _points[ e_point.y + _p ];
    
    _min_x = min( _min_x, _x );
    _min_y = min( _min_y, _y );
    _max_x = max( _max_x, _x );
    _max_y = max( _max_y, _y );
    
}

_min_x -= 1;
_min_y -= 1;
_max_x += 1;
_max_y += 1;

var _width  = _max_x - _min_x;
var _height = _max_y - _min_y;

cout( _min_x, _min_y, _max_x, _max_y );
*/

var _min_x = _left - 1;
var _min_y = _top - 1;
var _max_x = _right + 1;
var _max_y = _bottom + 1;

//Define starting triangle
triangles_count = 0;

var _stx1 = _min_x;
var _sty1 = _min_y;
var _stx2 = _max_x;
var _sty2 = _min_y;
var _stx3 = _min_x;
var _sty3 = _max_y;
var _cx   = scr_triangle_circumcircle_x( _stx1, _sty1, _stx2, _sty2, _stx3, _sty3 );
var _cy   = scr_triangle_circumcircle_y( _stx1, _sty1, _stx2, _sty2, _stx3, _sty3 );
var _r    = point_distance( _stx1, _sty1, _cx, _cy );

triangles[ e_triangle.x1 + triangles_count ] = _stx1;
triangles[ e_triangle.y1 + triangles_count ] = _sty1;
triangles[ e_triangle.x2 + triangles_count ] = _stx2;
triangles[ e_triangle.y2 + triangles_count ] = _sty2;
triangles[ e_triangle.x3 + triangles_count ] = _stx3;
triangles[ e_triangle.y3 + triangles_count ] = _sty3;
triangles[ e_triangle.cx + triangles_count ] = _cx;
triangles[ e_triangle.cy + triangles_count ] = _cy;
triangles[ e_triangle.r  + triangles_count ] = _r;

triangles_count += e_triangle.size;

var _stx1 = _max_x;
var _sty1 = _min_y;
var _stx2 = _min_x;
var _sty2 = _max_y;
var _stx3 = _max_x;
var _sty3 = _max_y;
var _cx   = scr_triangle_circumcircle_x( _stx1, _sty1, _stx2, _sty2, _stx3, _sty3 );
var _cy   = scr_triangle_circumcircle_y( _stx1, _sty1, _stx2, _sty2, _stx3, _sty3 );
var _r    = point_distance( _stx1, _sty1, _cx, _cy );

triangles[ e_triangle.x1 + triangles_count ] = _stx1;
triangles[ e_triangle.y1 + triangles_count ] = _sty1;
triangles[ e_triangle.x2 + triangles_count ] = _stx2;
triangles[ e_triangle.y2 + triangles_count ] = _sty2;
triangles[ e_triangle.x3 + triangles_count ] = _stx3;
triangles[ e_triangle.y3 + triangles_count ] = _sty3;
triangles[ e_triangle.cx + triangles_count ] = _cx;
triangles[ e_triangle.cy + triangles_count ] = _cy;
triangles[ e_triangle.r  + triangles_count ] = _r;

triangles_count += e_triangle.size;



//For each point
for( var _p = 0; _p < points_count; _p += e_point.size ) {
    
    var _px = _points[ e_point.x + _p ];
    var _py = _points[ e_point.y + _p ];
    
    //Find triangles where the point is inside the circumcircle
    var _bad_triangles = undefined;
    var _bad_triangles_count = 0;
    for( var _t = 0; _t < triangles_count; _t += e_triangle.size ) {
        
        if ( point_distance( _px, _py, triangles[ e_triangle.cx + _t ], triangles[ e_triangle.cy + _t ] ) <= triangles[ e_triangle.r + _t ] ) {
            _bad_triangles[ _bad_triangles_count ] = _t;
            _bad_triangles_count++;
        }
        
    }
    
    //For all bad triangles
    var _line = undefined;
    var _line_count = 0;
    for( var _a = 0; _a < _bad_triangles_count; _a++ ) {
        var _bad_tri_a = _bad_triangles[ _a ];
        
        var _ax1 = triangles[ e_triangle.x1 + _bad_tri_a ];
        var _ay1 = triangles[ e_triangle.y1 + _bad_tri_a ];
        var _ax2 = triangles[ e_triangle.x2 + _bad_tri_a ];
        var _ay2 = triangles[ e_triangle.y2 + _bad_tri_a ];
        var _ax3 = triangles[ e_triangle.x3 + _bad_tri_a ];
        var _ay3 = triangles[ e_triangle.y3 + _bad_tri_a ];
        
        var _external1 = true;
        var _external2 = true;
        var _external3 = true;
        
        for( var _b = 0; _b < _bad_triangles_count; _b++ ) {
            if ( _a == _b ) continue;
            
            var _bad_tri_b = _bad_triangles[ _b ];
            
            var _bx1 = triangles[ e_triangle.x1 + _bad_tri_b ];
            var _by1 = triangles[ e_triangle.y1 + _bad_tri_b ];
            var _bx2 = triangles[ e_triangle.x2 + _bad_tri_b ];
            var _by2 = triangles[ e_triangle.y2 + _bad_tri_b ];
            var _bx3 = triangles[ e_triangle.x3 + _bad_tri_b ];
            var _by3 = triangles[ e_triangle.y3 + _bad_tri_b ];
            
            if ( _external1 ) and ( scr_line_on_triangle( _ax1, _ay1, _ax2, _ay2,   _bx1, _by1, _bx2, _by2, _bx3, _by3 ) ) _external1 = false;
            if ( _external2 ) and ( scr_line_on_triangle( _ax2, _ay2, _ax3, _ay3,   _bx1, _by1, _bx2, _by2, _bx3, _by3 ) ) _external2 = false;
            if ( _external3 ) and ( scr_line_on_triangle( _ax3, _ay3, _ax1, _ay1,   _bx1, _by1, _bx2, _by2, _bx3, _by3 ) ) _external3 = false;
            
        }
        
        if ( _external1 ) {
            _line[ e_line.x1 + _line_count ] = _ax1;
            _line[ e_line.y1 + _line_count ] = _ay1;
            _line[ e_line.x2 + _line_count ] = _ax2;
            _line[ e_line.y2 + _line_count ] = _ay2;
            _line_count += e_line.size;
        }
        
        if ( _external2 ) {
            _line[ e_line.x1 + _line_count ] = _ax2;
            _line[ e_line.y1 + _line_count ] = _ay2;
            _line[ e_line.x2 + _line_count ] = _ax3;
            _line[ e_line.y2 + _line_count ] = _ay3;
            _line_count += e_line.size;
        }
        
        if ( _external3 ) {
            _line[ e_line.x1 + _line_count ] = _ax3;
            _line[ e_line.y1 + _line_count ] = _ay3;
            _line[ e_line.x2 + _line_count ] = _ax1;
            _line[ e_line.y2 + _line_count ] = _ay1;
            _line_count += e_line.size;
        }
        
    }
    
    //Delete bad triangles
    for( var _b = _bad_triangles_count - 1; _b >= 0; _b-- ) {
        scr_array_delete( triangles, _bad_triangles[ _b ], e_triangle.size, triangles_count );
        triangles_count -= e_triangle.size;
    }
    
    //Go through the polygon and add new triangles
    for( var _t = 0; _t < _line_count; _t += e_line.size ) {
        
        var _tx1 = _px;
        var _ty1 = _py;
        var _tx2 = _line[ e_line.x1 + _t ];
        var _ty2 = _line[ e_line.y1 + _t ];
        var _tx3 = _line[ e_line.x2 + _t ];
        var _ty3 = _line[ e_line.y2 + _t ];
        var _cx  = scr_triangle_circumcircle_x( _tx1, _ty1, _tx2, _ty2, _tx3, _ty3 );
        var _cy  = scr_triangle_circumcircle_y( _tx1, _ty1, _tx2, _ty2, _tx3, _ty3 );
        var _r   = point_distance( _tx1, _ty1, _cx, _cy );
        
        triangles[ e_triangle.x1 + triangles_count ] = _tx1;
        triangles[ e_triangle.y1 + triangles_count ] = _ty1;
        triangles[ e_triangle.x2 + triangles_count ] = _tx2;
        triangles[ e_triangle.y2 + triangles_count ] = _ty2;
        triangles[ e_triangle.x3 + triangles_count ] = _tx3;
        triangles[ e_triangle.y3 + triangles_count ] = _ty3;
        triangles[ e_triangle.cx + triangles_count ] = _cx;
        triangles[ e_triangle.cy + triangles_count ] = _cy;
        triangles[ e_triangle.r  + triangles_count ] = _r;
        
        triangles_count += e_triangle.size;
        
    }
    
}

/*
//Remove triangles that link to the starting triangle
for( var _t = triangles_count - e_triangle.size; _t >= 0; _t -= e_triangle.size ) {
    
    var _x1 = triangles[ e_triangle.x1 + _t ];
    var _y1 = triangles[ e_triangle.y1 + _t ];
    var _x2 = triangles[ e_triangle.x2 + _t ];
    var _y2 = triangles[ e_triangle.y2 + _t ];
    var _x3 = triangles[ e_triangle.x3 + _t ];
    var _y3 = triangles[ e_triangle.y3 + _t ];
    
    if ( ( _x1 == _stx1 ) and ( _y1 == _sty1 ) ) or ( ( _x1 == _stx2 ) and ( _y1 == _sty2 ) ) or ( ( _x1 == _stx3 ) and ( _y1 == _sty3 ) )
    or ( ( _x2 == _stx1 ) and ( _y2 == _sty1 ) ) or ( ( _x2 == _stx2 ) and ( _y2 == _sty2 ) ) or ( ( _x2 == _stx3 ) and ( _y2 == _sty3 ) )
    or ( ( _x3 == _stx1 ) and ( _y3 == _sty1 ) ) or ( ( _x3 == _stx2 ) and ( _y3 == _sty2 ) ) or ( ( _x3 == _stx3 ) and ( _y3 == _sty3 ) ) {
        
        scr_array_delete( triangles, _t, e_triangle.size, triangles_count );
        triangles_count -= e_triangle.size;
        
    }
    
}
*/
