///scr_array_delete( array, index, [number to delete], [array length] )

var _arr   = argument[0];
var _index = argument[1];

if ( argument_count < 3 ) var _length = 1 else var _length = argument[2];
if ( argument_count < 4 ) var _size = array_length_1d( _arr ) else var _size = argument[3];

var _limit = _size - _length;
for( var _i = _index; _i < _limit; _i++ ) _arr[@ _i ] = _arr[@ _i + _length ];
for( var _i = _limit; _i <  _size; _i++ ) _arr[@ _i ] = undefined;

return _limit;
