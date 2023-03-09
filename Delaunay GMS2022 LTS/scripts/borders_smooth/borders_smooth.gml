/// @param border_array
/// @param subdivisions
/// @param roundness
function borders_smooth(argument0, argument1, argument2) {
	//
	//  subdivisions is a whole number greater than 0
	//  roundness is a number from 0 to 1

	var _border_array = argument0;
	var _subdivisions = argument1;
	var _roundness    = argument2;

	_subdivisions = max( round( _subdivisions ), 0 );
	var _subdivision_increment = 1/(_subdivisions+1);
	_roundness = clamp( _roundness, 0, 1 );

	//Catch silliness
	if ( _roundness == 0 ) exit;

	//Iterate over all borders
	var _borders_count = array_length_1d( _border_array );
	for( var _b = 0; _b < _borders_count; _b += e_border.size )
	{
		var _point_array = _border_array[ _b + e_border.point_array ];
		var _point_count = array_length_1d( _point_array );
	
		//This rounding method only works with paths that have at least 4 points
		if ( _point_count < 4*2 ) continue;
	
		//Create a new array that'll hold our new rounded path
		var _new_point_array = array_create( 0 );
		var _new_point_count = 0;
	
		//We hold a big cache of previous path points positions to reduce the number of array lookups
		var _x0 = undefined;
		var _y0 = undefined;
		var _x1 = _point_array[ 0 ];
		var _y1 = _point_array[ 1 ];
		var _x2 = _point_array[ 2 ];
		var _y2 = _point_array[ 3 ];
		var _x3 = _point_array[ 4 ];
		var _y3 = _point_array[ 5 ];
	
		//Iterate over all points in the border's path
		for( var _p_offset = 6; _p_offset < _point_count+6; _p_offset += 2 )
		{
			var _p = _p_offset mod _point_count;
		
			//Push the coordinate cache back a step...
			_x0 = _x1; _y0 = _y1;
			_x1 = _x2; _y1 = _y2;
			_x2 = _x3; _y2 = _y3;
		
			//...and fill the top slot with our new point
			_x3 = _point_array[ _p   ];
			_y3 = _point_array[ _p+1 ];
		
			//Use the parameter "t" to interpolate from x1,y1 to x2,y2
			for( var _t = 0; _t < 1; _t += _subdivision_increment )
			{
				//Find our new curvy point by using a 4-spline
				var _new_x = spline4( _t, _x0, _x1, _x2, _x3 );
				var _new_y = spline4( _t, _y0, _y1, _y2, _y3 );
			
				//Find our old point by using straight-up linear interpolation
				var _old_x = lerp( _x1, _x2, _t );
				var _old_y = lerp( _y1, _y2, _t );
			
				//Mix from the old position to the new position to give us some control over roundedness
				_new_x = lerp( _old_x, _new_x, _roundness );
				_new_y = lerp( _old_y, _new_y, _roundness );
			
				//Then add this new point to the new path
				_new_point_array[ _new_point_count++ ] = lerp( _old_x, _new_x, _roundness );
				_new_point_array[ _new_point_count++ ] = lerp( _old_y, _new_y, _roundness );
			}
		}
	
		//Once we're done iterating over the entire path, overwrite the old path with the new path
		_border_array[@ _b + e_border.point_array ] = _new_point_array;
	}


}
