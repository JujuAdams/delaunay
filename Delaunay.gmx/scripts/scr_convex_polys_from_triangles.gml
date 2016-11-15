///scr_convex_polys_from_triangles( triangles )

var _pri = ds_priority_create();
var _map = ds_map_create();

for( var _t = 0; _t < triangles_count; _t += e_triangle.size ) {
    
    var _x1 = triangles[ e_triangle.x1 + _t ];
    var _y1 = triangles[ e_triangle.y1 + _t ];
    var _x2 = triangles[ e_triangle.x2 + _t ];
    var _y2 = triangles[ e_triangle.y2 + _t ];
    var _x3 = triangles[ e_triangle.x3 + _t ];
    var _y3 = triangles[ e_triangle.y3 + _t ];
    
    var _len_a = point_distance( _x1, _y1, _x2, _y2 );
    var _len_b = point_distance( _x2, _y2, _x3, _y3 );
    var _len_c = point_distance( _x3, _y3, _x1, _y1 );
    
    var _perimeter = ( _len_a + _len_b + _len_c ) / 2;
    var _area_sqr = _perimeter * ( _perimeter - _len_a ) * ( _perimeter - _len_b ) * ( _perimeter - _len_c );
    
    ds_priority_add( _pri, _t, _area_sqr );
    
}

polygons[] = undefined;
polygons_count = 0;

var _points;
while( !ds_priority_empty( _pri ) ) {
    
    var _t = ds_priority_delete_max( _pri );
    if ( !is_undefined( ds_map_find_value( _map, _t ) ) ) continue;
    ds_map_add( _map, _t, _t );
    
    _points = 0;
    var _points_count = 0;
    
    _points[ _points_count + e_point.x ] = triangles[ e_triangle.x1 + _t ];
    _points[ _points_count + e_point.y ] = triangles[ e_triangle.y1 + _t ];
    _points_count += e_point.size;
    
    _points[ _points_count + e_point.x ] = triangles[ e_triangle.x2 + _t ];
    _points[ _points_count + e_point.y ] = triangles[ e_triangle.y2 + _t ];
    _points_count += e_point.size;
    
    _points[ _points_count + e_point.x ] = triangles[ e_triangle.x3 + _t ];
    _points[ _points_count + e_point.y ] = triangles[ e_triangle.y3 + _t ];
    _points_count += e_point.size;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    polygons[ polygons_count + e_polygon.points ] = _points;
    polygons[ polygons_count + e_polygon.points_count ] = _points_count;
    polygons_count += e_polygon.size;
    
}

ds_priority_destroy( _pri );
ds_map_destroy( _map );
