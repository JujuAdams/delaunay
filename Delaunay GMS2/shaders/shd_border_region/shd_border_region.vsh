attribute vec3 in_Position;
attribute vec4 in_Colour;

varying vec2 v_vTexcoord;

void main()
{
	v_vTexcoord = in_Position.xy / 1023.;
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4( in_Position.xyz, 1. );
}
