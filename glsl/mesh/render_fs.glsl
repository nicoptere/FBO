uniform vec2 nearFar;
varying float size;
#ifdef USE_LOGDEPTHBUF
	uniform float logDepthBufFC;
	#ifdef USE_LOGDEPTHBUF_EXT
		varying float vFragDepth;
	#endif
#endif
void main()
{

    if( size < 8. )discard;

    #if defined(USE_LOGDEPTHBUF) && defined(USE_LOGDEPTHBUF_EXT)
        gl_FragDepthEXT = log2(vFragDepth) * logDepthBufFC * 0.5;
    #endif

    #ifdef USE_LOGDEPTHBUF_EXT
        float depth = gl_FragDepthEXT / gl_FragCoord.w;
    #else
        float depth = gl_FragCoord.z / gl_FragCoord.w;
    #endif

	float color = 1.0 - smoothstep( nearFar.x, nearFar.y, depth );
	gl_FragColor = vec4( vec3( color ), 1. );

}