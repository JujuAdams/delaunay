attribute vec3 in_Position;
attribute vec4 in_Colour;

void main()
{
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4( in_Position.xyz, 1. );
}
