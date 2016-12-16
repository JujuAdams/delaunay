///scr_juju_dijkstra_connection_closest_below( x, y, cutoff y, exclude node )
/*
var _x       = argument0;
var _y       = argument1;
var _cy      = argument2;
var _exclude = argument3;

with ( global.juju_dijkstra_instance ) {
    
    var _min_i          = noone;
    var _min_j          = noone;
    var _min_connection = noone;
    var _min_parameter  = noone;
    var _min_px         = noone;
    var _min_py         = noone;
    var _min_dist       = $FFFFFFFF;
    
    with( par_platform ) {
        
        if ( _x < x0 ) or ( _x > x1 ) continue;
        
        var _t = ( _x - x0 ) / ( x1 - x0 );
        var _px = _x;
        var _py = y0 + ( y1 - y0 ) * _t;
        
        if ( _cy > _py ) continue; //If the nearest point on the line is above the cutoff y-value, ignore this point
        
        var _dist = abs( _py - _y );
        
        if ( _dist < _min_dist ) {
            _min_i          = true;
            _min_parameter  = _t;
            _min_px         = _px;
            _min_py         = _py;
            _min_dist       = _dist;
        }
        
    }
    
    var result;
    result[0] = _min_i;          //node 1
    result[1] = _min_j;          //unused
    result[2] = _min_connection; //unused
    result[3] = _min_parameter;  //parameter position along connection
    result[4] = _min_px;         //x position of closest point
    result[5] = _min_py;         //y position of closest point
    result[6] = _min_dist;       //distance from point to point
    if ( _min_i == noone ) or ( _min_connection == noone ) { //global node+connection index
        result[7] = noone;
    } else {
        result[7] = _min_connection + _min_i * 10000;
    }
    return result;
    
}
*/
