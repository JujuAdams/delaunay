///scr_point_in_circumcircle( px, py, x1, y1, x2, y2, x3, y3 )

var _px = argument0;
var _py = argument1;
var _x1 = argument2;
var _y1 = argument3;
var _x2 = argument4;
var _y2 = argument5;
var _x3 = argument6;
var _y3 = argument7;

var _a = _x1*_x1 + _y1*_y1;
var _b = _x2*_x2 + _y2*_y2;
var _c = _x3*_x3 + _y3*_y3;

var _cx = _a*( _y3 - _y2 ) + _b*( _y1 - _y3 ) + _c*( _y2 - _y1 );
_cx /= _x1*( _y3 - _y2 ) + _x2*( _y1 - _y3 ) + _x3*( _y2 - _y1 );
_cx *= 0.5;

var _cy = _a*( _x3 - _x2 ) + _b*( _x1 - _x3 ) + _c*( _x2 - _x1 );
_cy /= _y1*( _x3 - _x2 ) + _y2*( _x1 - _x3 ) + _y3*( _x2 - _x1 );
_cy *= 0.5;

var _cdx = _x1 - _cx;
var _cdy = _y1 - _cy;
var _pdx = _px - _cx;
var _pdy = _py - _cy;

return ( _cdx*_cdx + _cdy*_cdy ) > ( _pdx*_pdx + _pdy*_pdy );





/*
float ab = (p1.x * p1.x) + (p1.y * p1.y);
float cd = (p2.x * p2.x) + (p2.y * p2.y);
float ef = (p3.x * p3.x) + (p3.y * p3.y);

float circum_x = (ab * (p3.y - p2.y) + cd * (p1.y - p3.y) + ef * (p2.y - p1.y)) / (p1.x * (p3.y - p2.y) + p2.x * (p1.y - p3.y) + p3.x * (p2.y - p1.y)) / 2.f;
float circum_y = (ab * (p3.x - p2.x) + cd * (p1.x - p3.x) + ef * (p2.x - p1.x)) / (p1.y * (p3.x - p2.x) + p2.y * (p1.x - p3.x) + p3.y * (p2.x - p1.x)) / 2.f;
float circum_radius = ((p1.x - circum_x) * (p1.x - circum_x)) + ((p1.y - circum_y) * (p1.y - circum_y));

float dist = ((v.x - circum_x) * (v.x - circum_x)) + ((v.y - circum_y) * (v.y - circum_y));
return dist <= circum_radius;
*/
