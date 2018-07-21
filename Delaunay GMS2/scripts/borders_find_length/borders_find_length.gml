/// @param border_array

var _border_array = argument0;

var _borders_count = array_length_1d( _border_array );
for( var _b = 0; _b < _borders_count; _b += e_border.size )
{
	var _point_array = _border_array[ _b + e_border.point_array ];
	
	var _length = 0;
	var _point_count = array_length_1d( _point_array );
	for( var _p_offset = 0; _p_offset < _point_count; _p_offset += 2 )
	{
		var _p = _p_offset mod _point_count;
		var _q = ( _p + 2 ) mod _point_count;
		_length += point_distance( _point_array[ _p ], _point_array[ _p+1 ],
		                           _point_array[ _q ], _point_array[ _q+1 ] );
	}
	
	_border_array[@ _b + e_border.length ] = _length;
}