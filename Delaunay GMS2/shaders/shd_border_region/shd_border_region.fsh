varying vec2 v_vTexcoord;

uniform vec4 u_vRGBA;

void main()
{
    gl_FragColor = u_vRGBA * texture2D( gm_BaseTexture, v_vTexcoord );
}
