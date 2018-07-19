/// @param  nodes
/// @param  triangles_array_out
/// @param  left
/// @param  top
/// @param  right
/// @param  bottom
/// @param  remove border 

var _nodes        = argument0;
var _out_triangles = argument1;
var _left          = argument2;
var _top           = argument3;
var _right         = argument4;
var _bottom        = argument5;
var _remove_border = argument6;

var _min_x = _left   - 1;
var _min_y = _top    - 1;
var _max_x = _right  + 1;
var _max_y = _bottom + 1;



//Define two starting triangles that cover the rectangle given by the min/max coordinates
var _triangles = undefined;
var _triangles_count = 0;

//Top-left triangle
var _stx1 = _min_x;
var _sty1 = _min_y;
var _stx2 = _max_x;
var _sty2 = _min_y;
var _stx3 = _min_x;
var _sty3 = _max_y;
//The circumcircle of a triangle is the smallest circle that encompasses the triangle
//Our parameters are the circle centre (cx,cy) and the radius (r)
var _cx   = triangle_circumcircle_x( _stx1, _sty1, _stx2, _sty2, _stx3, _sty3 );
var _cy   = triangle_circumcircle_y( _stx1, _sty1, _stx2, _sty2, _stx3, _sty3 );
var _r    = point_distance( _stx1, _sty1, _cx, _cy );
//Stack up our data in a sequential array
_triangles[ e_triangle.x1 + _triangles_count ] = _stx1;
_triangles[ e_triangle.y1 + _triangles_count ] = _sty1;
_triangles[ e_triangle.x2 + _triangles_count ] = _stx2;
_triangles[ e_triangle.y2 + _triangles_count ] = _sty2;
_triangles[ e_triangle.x3 + _triangles_count ] = _stx3;
_triangles[ e_triangle.y3 + _triangles_count ] = _sty3;
_triangles[ e_triangle.cx + _triangles_count ] = _cx;
_triangles[ e_triangle.cy + _triangles_count ] = _cy;
_triangles[ e_triangle.r  + _triangles_count ] = _r;
_triangles_count += e_triangle.size;

//Bottom-right triangle
var _stx1 = _max_x;
var _sty1 = _min_y;
var _stx2 = _min_x;
var _sty2 = _max_y;
var _stx3 = _max_x;
var _sty3 = _max_y;
//The circumcircle of a triangle is the smallest circle that encompasses the triangle
//Our parameters are the circle centre (cx,cy) and the radius (r)
var _cx   = triangle_circumcircle_x( _stx1, _sty1, _stx2, _sty2, _stx3, _sty3 );
var _cy   = triangle_circumcircle_y( _stx1, _sty1, _stx2, _sty2, _stx3, _sty3 );
var _r    = point_distance( _stx1, _sty1, _cx, _cy );
//Stack up our data in a sequential array
_triangles[ e_triangle.x1 + _triangles_count ] = _stx1;
_triangles[ e_triangle.y1 + _triangles_count ] = _sty1;
_triangles[ e_triangle.x2 + _triangles_count ] = _stx2;
_triangles[ e_triangle.y2 + _triangles_count ] = _sty2;
_triangles[ e_triangle.x3 + _triangles_count ] = _stx3;
_triangles[ e_triangle.y3 + _triangles_count ] = _sty3;
_triangles[ e_triangle.cx + _triangles_count ] = _cx;
_triangles[ e_triangle.cy + _triangles_count ] = _cy;
_triangles[ e_triangle.r  + _triangles_count ] = _r;
_triangles_count += e_triangle.size;



//Check for triangles that have nodes inside of them - we obviously don't want them!
var _nodes_count = array_length_1d( _nodes );
for( var _p = 0; _p < _nodes_count; _p += e_node.size ) {
    
    //Grab node data from the array
    var _px = _nodes[ e_node.x + _p ];
    var _py = _nodes[ e_node.y + _p ];
    
    //Make a new variable to store the "bad triangles"
    var _bad_triangles = undefined;
    var _bad_triangles_count = 0;
    
    //Iterate over all the triangles...
    for( var _t = 0; _t < _triangles_count; _t += e_triangle.size ) {
        //If the distance from the circle to the node, the node is inside the circle
        if ( point_distance( _px, _py, _triangles[ e_triangle.cx + _t ], _triangles[ e_triangle.cy + _t ] ) <= _triangles[ e_triangle.r + _t ] ) {
            //...and if so, add this triangle to our "bad triangles" array
            _bad_triangles[ _bad_triangles_count ] = _t;
            _bad_triangles_count++;
        }
    }
    
    //Make a new variable to store edges
    var _edge = undefined;
    var _edge_count = 0;
    
    //Iterate over every bad triangle (A) and work out if it shares a side with another bad triangle (B)
    for( var _a = 0; _a < _bad_triangles_count; _a++ ) {
        
        //Grab triangle data for A
        var _bad_tri_a = _bad_triangles[ _a ];
        var _ax1 = _triangles[ e_triangle.x1 + _bad_tri_a ];
        var _ay1 = _triangles[ e_triangle.y1 + _bad_tri_a ];
        var _ax2 = _triangles[ e_triangle.x2 + _bad_tri_a ];
        var _ay2 = _triangles[ e_triangle.y2 + _bad_tri_a ];
        var _ax3 = _triangles[ e_triangle.x3 + _bad_tri_a ];
        var _ay3 = _triangles[ e_triangle.y3 + _bad_tri_a ];
        
        //Let's assume each side of triangle A *isn't* shared by another bad triangle
        var _external1 = true;
        var _external2 = true;
        var _external3 = true;
        
        //And iterate over the bad triangles again
        for( var _b = 0; _b < _bad_triangles_count; _b++ ) {
            
            //If A==B then skip over this B
            if ( _a == _b ) continue;
            
            //Grab triangle data for B
            var _bad_tri_b = _bad_triangles[ _b ];
            var _bx1 = _triangles[ e_triangle.x1 + _bad_tri_b ];
            var _by1 = _triangles[ e_triangle.y1 + _bad_tri_b ];
            var _bx2 = _triangles[ e_triangle.x2 + _bad_tri_b ];
            var _by2 = _triangles[ e_triangle.y2 + _bad_tri_b ];
            var _bx3 = _triangles[ e_triangle.x3 + _bad_tri_b ];
            var _by3 = _triangles[ e_triangle.y3 + _bad_tri_b ];
            
            //Work out if A and B share a side
            if ( _external1 ) and ( edge_on_triangle( _ax1, _ay1, _ax2, _ay2,   _bx1, _by1, _bx2, _by2, _bx3, _by3 ) ) _external1 = false;
            if ( _external2 ) and ( edge_on_triangle( _ax2, _ay2, _ax3, _ay3,   _bx1, _by1, _bx2, _by2, _bx3, _by3 ) ) _external2 = false;
            if ( _external3 ) and ( edge_on_triangle( _ax3, _ay3, _ax1, _ay1,   _bx1, _by1, _bx2, _by2, _bx3, _by3 ) ) _external3 = false;
            
        }
        
        //If side 1->2 is not shared by another triangle, add it to the edge list
        if ( _external1 ) {
            _edge[ e_edge.x1 + _edge_count ] = _ax1;
            _edge[ e_edge.y1 + _edge_count ] = _ay1;
            _edge[ e_edge.x2 + _edge_count ] = _ax2;
            _edge[ e_edge.y2 + _edge_count ] = _ay2;
            _edge_count += e_edge.size;
        }
        
        //If side 2->3 is not shared by another triangle, add it to the edge list
        if ( _external2 ) {
            _edge[ e_edge.x1 + _edge_count ] = _ax2;
            _edge[ e_edge.y1 + _edge_count ] = _ay2;
            _edge[ e_edge.x2 + _edge_count ] = _ax3;
            _edge[ e_edge.y2 + _edge_count ] = _ay3;
            _edge_count += e_edge.size;
        }
        
        //If side 3->1 is not shared by another triangle, add it to the edge list
        if ( _external3 ) {
            _edge[ e_edge.x1 + _edge_count ] = _ax3;
            _edge[ e_edge.y1 + _edge_count ] = _ay3;
            _edge[ e_edge.x2 + _edge_count ] = _ax1;
            _edge[ e_edge.y2 + _edge_count ] = _ay1;
            _edge_count += e_edge.size;
        }
        
    }
    
    //Delete bad triangles
    for( var _b = _bad_triangles_count - 1; _b >= 0; _b-- ) {
        array_delete( _triangles, _bad_triangles[ _b ], e_triangle.size, _triangles_count );
        _triangles_count -= e_triangle.size;
    }
    
    for( var _t = 0; _t < _edge_count; _t += e_edge.size ) {
        
        //Build a new triangle from the node we're examining and a edge that's *not* shared by any two bad triangles
        var _tx1 = _px;
        var _ty1 = _py;
        var _tx2 = _edge[ e_edge.x1 + _t ];
        var _ty2 = _edge[ e_edge.y1 + _t ];
        var _tx3 = _edge[ e_edge.x2 + _t ];
        var _ty3 = _edge[ e_edge.y2 + _t ];
        //The circumcircle of a triangle is the smallest circle that encompasses the triangle
        //Our parameters are the circle centre (cx,cy) and the radius (r)
        var _cx  = triangle_circumcircle_x( _tx1, _ty1, _tx2, _ty2, _tx3, _ty3 );
        var _cy  = triangle_circumcircle_y( _tx1, _ty1, _tx2, _ty2, _tx3, _ty3 );
        var _r   = point_distance( _tx1, _ty1, _cx, _cy );
        //Stack up our data in a sequential array
        _triangles[ e_triangle.x1 + _triangles_count ] = _tx1;
        _triangles[ e_triangle.y1 + _triangles_count ] = _ty1;
        _triangles[ e_triangle.x2 + _triangles_count ] = _tx2;
        _triangles[ e_triangle.y2 + _triangles_count ] = _ty2;
        _triangles[ e_triangle.x3 + _triangles_count ] = _tx3;
        _triangles[ e_triangle.y3 + _triangles_count ] = _ty3;
        _triangles[ e_triangle.cx + _triangles_count ] = _cx;
        _triangles[ e_triangle.cy + _triangles_count ] = _cy;
        _triangles[ e_triangle.r  + _triangles_count ] = _r;
        
        _triangles_count += e_triangle.size;
    }
    
}

if ( _remove_border ) {
    
    //Remove triangles that lie around the edge
    for( var _t = _triangles_count - e_triangle.size; _t >= 0; _t -= e_triangle.size ) {
        
        var _x1 = _triangles[ e_triangle.x1 + _t ];
        var _y1 = _triangles[ e_triangle.y1 + _t ];
        var _x2 = _triangles[ e_triangle.x2 + _t ];
        var _y2 = _triangles[ e_triangle.y2 + _t ];
        var _x3 = _triangles[ e_triangle.x3 + _t ];
        var _y3 = _triangles[ e_triangle.y3 + _t ];
        
        if ( _x1 <= _min_x ) or ( _y1 <= _min_y ) or ( _x1 >= _max_x ) or ( _y1 >= _max_y )
        or ( _x2 <= _min_x ) or ( _y2 <= _min_y ) or ( _x2 >= _max_x ) or ( _y2 >= _max_y )
        or ( _x3 <= _min_x ) or ( _y3 <= _min_y ) or ( _x3 >= _max_x ) or ( _y3 >= _max_y ) {
            
            array_delete( _triangles, _t, e_triangle.size, _triangles_count );
            _triangles_count -= e_triangle.size;
            
        }
        
    }
    
}

//Make a final array that contains only the triangles we want
for( var _t = _triangles_count-1; _t >= 0; _t-- ) _out_triangles[@ _t ] = _triangles[ _t ];

return true;

/*
function BowyerWatson (nodeList)
      // nodeList is a set of coordinates defining the nodes to be triangulated
      triangulation := empty triangle mesh data structure
      add super-triangle to triangulation // must be large enough to completely contain all the nodes in nodeList
      for each node in nodeList do // add all the nodes one at a time to the triangulation
         badTriangles := empty set
         for each triangle in triangulation do // first find all the triangles that are no longer valid due to the insertion
            if node is inside circumcircle of triangle
               add triangle to badTriangles
         polygon := empty set
         for each triangle in badTriangles do // find the boundary of the polygonal hole
            for each edge in triangle do
               if edge is not shared by any other triangles in badTriangles
                  add edge to polygon
         for each triangle in badTriangles do // remove them from the data structure
            remove triangle from triangulation
         for each edge in polygon do // re-triangulate the polygonal hole
            newTri := form a triangle from edge to node
            add newTri to triangulation
      for each triangle in triangulation // done inserting nodes, now clean up
         if triangle contains a vertex from original super-triangle
            remove triangle from triangulation
      return triangulation
*/
