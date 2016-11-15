///cout( message, [message]... )

var str = "<" + string( current_time ) + ">   ";
for( var _i = 0; _i < argument_count; _i++ ) str += "<" + string( argument[_i] ) + ">   ";
show_debug_message( str );

