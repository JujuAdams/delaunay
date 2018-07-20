/// @param border_array
/// @param detail
/// @param tightness

var _border_array = argument0;
var _subdivision  = 1/argument1;
var _tightness    = 1/argument2;

var _borders_count = array_length_1d( _border_array );
for( var _b = 0; _b < _borders_count; _b += e_border.size )
{
	var _point_array = _border_array[ _b + e_border.point_array ];
	var _point_count = array_length_1d( _point_array );
	
	var _new_point_array = array_create( 0 );
	var _new_point_count = 0;
	
	var _x0 = undefined;
	var _y0 = undefined;
	var _x1 = _point_array[ 0 ];
	var _y1 = _point_array[ 1 ];
	var _x2 = _point_array[ 2 ];
	var _y2 = _point_array[ 3 ];
	var _x3 = _point_array[ 4 ];
	var _y3 = _point_array[ 5 ];
	
	for( var _p_offset = 6; _p_offset < _point_count+6; _p_offset += 2 )
	{
		var _p = _p_offset mod _point_count;
		
		_x0 = _x1; _y0 = _y1;
		_x1 = _x2; _y1 = _y2;
		_x2 = _x3; _y2 = _y3;
		
		_x3 = _point_array[ _p   ];
		_y3 = _point_array[ _p+1 ];
		
		for( var _t = 0; _t < 1; _t += _subdivision )
		{
			var _x = spline4( _t, _x0, _x1, _x2, _x3 );
			var _y = spline4( _t, _y0, _y1, _y2, _y3 );
			var _ox = lerp( _x1, _x2, _t );
			var _oy = lerp( _y1, _y2, _t );
			_x = lerp( _x, _ox, _tightness );
			_y = lerp( _y, _oy, _tightness );
			
			_new_point_array[ _new_point_count++ ] = _x;
			_new_point_array[ _new_point_count++ ] = _y;
		}
	}
	
	_border_array[@ _b + e_border.point_array ] = _new_point_array;
}