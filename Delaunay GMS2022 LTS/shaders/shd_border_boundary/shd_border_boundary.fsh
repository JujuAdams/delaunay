varying vec2 v_vTexcoord;

uniform vec4  u_vRGBA;
uniform float u_fRepeats;
uniform float u_fOffset;

void main()
{
    gl_FragColor = u_vRGBA * texture2D( gm_BaseTexture, vec2( u_fRepeats*v_vTexcoord.x - u_fOffset, v_vTexcoord.y ) );
}
