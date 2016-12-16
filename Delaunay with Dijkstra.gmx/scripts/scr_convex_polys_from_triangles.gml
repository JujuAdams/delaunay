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
    
    var _i = ds_priority_delete_max( _pri );
    if ( !is_undefined( ds_map_find_value( _map, _i ) ) ) continue;
    ds_map_add( _map, _i, true );
    
    var _x1 = triangles[ e_triangle.x1 + _i ];
    var _y1 = triangles[ e_triangle.y1 + _i ];
    var _x2 = triangles[ e_triangle.x2 + _i ];
    var _y2 = triangles[ e_triangle.y2 + _i ];
    var _x3 = triangles[ e_triangle.x3 + _i ];
    var _y3 = triangles[ e_triangle.y3 + _i ];
    
    var _list = ds_list_create();
    ds_list_add( _list, _x1, _y1, _x2, _y2, _x3, _y3 );
    
    for( var _p = 0; _p < ds_list_size( _list ) - e_point.size; _p += e_point.size ) {
        
        var _px1 = ds_list_find_value( _list, _p + e_point.x );
        var _py1 = ds_list_find_value( _list, _p + e_point.y );
        var _px2 = ds_list_find_value( _list, ( _p + e_point.x + e_point.size ) mod ds_list_size( _list ) );
        var _py2 = ds_list_find_value( _list, ( _p + e_point.y + e_point.size ) mod ds_list_size( _list ) );
        
        for( var _t = 0; _t < triangles_count; _t += e_triangle.size ) {
            if ( !is_undefined( ds_map_find_value( _map, _t ) ) ) continue;
            
            var _tx1 = triangles[ e_triangle.x1 + _t ];
            var _ty1 = triangles[ e_triangle.y1 + _t ];
            var _tx2 = triangles[ e_triangle.x2 + _t ];
            var _ty2 = triangles[ e_triangle.y2 + _t ];
            var _tx3 = triangles[ e_triangle.x3 + _t ];
            var _ty3 = triangles[ e_triangle.y3 + _t ];
            
            var _adjacent = scr_line_on_triangle( _px1, _py1, _px2, _py2,   _tx1, _ty1, _tx2, _ty2, _tx3, _ty3 );
            if ( _adjacent ) {
                
                switch( _adjacent ) {
                    case 1: ds_list_insert( _list, _p + e_point.size + e_point.x, _tx3 ); ds_list_insert( _list, _p + e_point.size + e_point.y, _ty3 ); break;
                    case 2: ds_list_insert( _list, _p + e_point.size + e_point.x, _tx1 ); ds_list_insert( _list, _p + e_point.size + e_point.y, _ty1 ); break;
                    case 3: ds_list_insert( _list, _p + e_point.size + e_point.x, _tx2 ); ds_list_insert( _list, _p + e_point.size + e_point.y, _ty2 ); break;
                }
                
                ds_map_add( _map, _t, true );
                break;
                
            }
            
        }
        
    }
    
    polygons[ polygons_count + e_polygon.points   ] = _list;
    polygons[ polygons_count + e_polygon.centre_x ] = mean( _x1, _x2, _x3 );
    polygons[ polygons_count + e_polygon.centre_y ] = mean( _y1, _y2, _y3 );
    
    polygons_count += e_polygon.size;
    
}

ds_priority_destroy( _pri );
ds_map_destroy( _map );
