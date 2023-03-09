attribute vec3 in_Position;
attribute vec4 in_Colour;

varying vec2 v_vTexcoord;

uniform vec2 u_vOffset;
uniform vec2 u_vTextureSize;

void main()
{
	v_vTexcoord = (in_Position.xy - u_vOffset) / (u_vTextureSize - 1.);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4( in_Position.xyz, 1. );
}
