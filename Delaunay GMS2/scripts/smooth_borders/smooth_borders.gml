/// @param border_array

var _border_array = argument0;

var _borders_count = array_length_1d( _border_array );
for( var _b = 0; _b < _borders_count; _b += e_border.size )
{
	var _path = _border_array[ _b + e_border.path ];
	var _smoothed_path = path_create_smoothed( _path, 0.2, 0.01, false );
	path_delete( _path );
	_border_array[@ _b + e_border.path ] = _smoothed_path;
}