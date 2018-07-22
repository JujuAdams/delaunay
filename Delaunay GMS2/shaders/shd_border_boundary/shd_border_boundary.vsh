attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;

uniform float u_vThickness;

void main()
{
	vec3 pos = in_Position + .5*u_vThickness*in_Normal;
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4( pos, 1. );
	v_vTexcoord = in_TextureCoord;
}
