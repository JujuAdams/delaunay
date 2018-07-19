///path_create_smoothed( path, detail, tightness )
//  
//  Creates a new path based on an existing path, smoothed using Catmull-Rom interpolation.
//  
//  !!! Dependent on the script spline4(), available here: http://www.gmlscripts.com/script/spline4
//  
//  argument0: Basis path.
//  argument1: How detailed the output smoothed path is. Lower values are smoother.
//  argument2: How closely the new path follows the old path.
//             A value of 1 will return a path the follows the original with tight corners, a value of 0 will return a path with gentler corners.
//  
//  return   : If successful, the ID of the new path (return >= 0). If unsuccessful, returns "noone" (return = -4).

var path, detail, tightness, newClosed, closed, nodes, limit;
var x0, x1, x2, x3, y0, y1, y2, y3, i, iLoop;
var t, xx, yy, Ox, Oy;

path = argument0;
detail = argument1;
tightness = argument2;
newClosed = argument3;

nodes = path_get_number( path );

if ( nodes < 3 ) {
    show_debug_message( "path_create_smoothed: too few nodes (" + string( nodes ) + ")! path=" + string( path ) );
    return noone;
}

closed = path_get_closed( path );

var newPath = path_add();

if ( detail <= 0 ) detail = 0.1;
detail = min( 1, detail );
tightness = clamp( tightness, 0, 1 );

if ( closed ) {
    
    x1 = path_get_point_x( path, 0 );
    y1 = path_get_point_y( path, 0 );
    x2 = path_get_point_x( path, 1 );
    y2 = path_get_point_y( path, 1 );
    x3 = path_get_point_x( path, 2 );
    y3 = path_get_point_y( path, 2 );
    
    for( i = 0; i < nodes; i++ ) {
        iLoop = ( i + 3 ) mod nodes;
        
        x0 = x1; y0 = y1;
        x1 = x2; y1 = y2;
        x2 = x3; y2 = y3;
        x3 = path_get_point_x( path, iLoop );
        y3 = path_get_point_y( path, iLoop );
        
        for( t = 0; t < 1; t += detail ) {
            xx = spline4( t, x0, x1, x2, x3 );
            yy = spline4( t, y0, y1, y2, y3 );
            Ox = lerp( x1, x2, t );
            Oy = lerp( y1, y2, t );
            xx = lerp( xx, Ox, tightness );
            yy = lerp( yy, Oy, tightness );
            path_add_point( newPath, xx, yy, lerp( path_get_point_speed( path, i ), path_get_point_speed( path, ( i + 1 ) mod nodes ), t ) );
        }
        
    }
    
    path_set_closed( newPath, true );
    
} else {
    
    x1 = path_get_point_x( path, 0 );
    y1 = path_get_point_y( path, 0 );
    x2 = path_get_point_x( path, 0 );
    y2 = path_get_point_y( path, 0 );
    x3 = path_get_point_x( path, 1 );
    y3 = path_get_point_y( path, 1 );
    
    for( i = 0; i < nodes - 1; i++ ) {
        iLoop = min( nodes - 1, i + 2 );
        
        x0 = x1; y0 = y1;
        x1 = x2; y1 = y2;
        x2 = x3; y2 = y3;
        x3 = path_get_point_x( path, iLoop );
        y3 = path_get_point_y( path, iLoop );
        
        for( t = 0; t < 1; t += detail ) {
            xx = spline4( t, x0, x1, x2, x3 );
            yy = spline4( t, y0, y1, y2, y3 );
            Ox = lerp( x1, x2, t );
            Oy = lerp( y1, y2, t );
            xx = lerp( xx, Ox, tightness );
            yy = lerp( yy, Oy, tightness );
            path_add_point( newPath, xx, yy, lerp( path_get_point_speed( path, i ), path_get_point_speed( path, i + 1 ), t ) );
        }
        
    }
    
    path_add_point( newPath, path_get_point_x( path, nodes - 1 ), path_get_point_y( path, nodes - 1 ), path_get_point_speed( path, nodes - 1 ) );
    path_set_closed( newPath, false );
    
}

return newPath;
