/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param x3
/// @param y3
/// @param x4
/// @param y4
function rays_intersect(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7) {

	var ua, ub, ud, ux, uy, vx, vy, wx, wy;
	ua = 0;
	ux = argument2 - argument0;
	uy = argument3 - argument1;
	vx = argument6 - argument4;
	vy = argument7 - argument5;
	wx = argument0 - argument4;
	wy = argument1 - argument5;
	ud = vy * ux - vx * uy;
	if (ud != 0) 
	{
	    ua = (vx * wy - vy * wx) / ud;
	    ub = (ux * wy - uy * wx) / ud;
	    if (ua < 0 || ua >= 1 || ub < 0 || ub >= 1) ua = 0;
	}
	return ua;


}
