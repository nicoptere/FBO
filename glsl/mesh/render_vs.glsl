

//float texture containing the positions of each particle
uniform sampler2D positions;

//size
uniform vec2 nearFar;
uniform float pointSize;
varying float size;

#define EPSILON 1e-6
#ifdef USE_LOGDEPTHBUF
	#ifdef USE_LOGDEPTHBUF_EXT
		varying float vFragDepth;
	#endif
	uniform float logDepthBufFC;
#endif
void main() {

    //the mesh is a nomrliazed square so the uvs = the xy positions of the vertices
    vec3 pos = texture2D( positions, position.xy ).xyz;

    //pos now contains the position of a point in space taht can be transformed
    gl_Position = projectionMatrix * modelViewMatrix * vec4( pos, 1.0 );

    #ifdef USE_LOGDEPTHBUF
        gl_Position.z = log2(max( EPSILON, gl_Position.w + 1.0 )) * logDepthBufFC;

        #ifdef USE_LOGDEPTHBUF_EXT
            vFragDepth = 1.0 + gl_Position.w;
        #else
            gl_Position.z = (gl_Position.z - 1.0) * gl_Position.w;
        #endif
    #endif


    float depth = 1.0 - smoothstep( nearFar.x, nearFar.y, gl_Position.z / gl_Position.w );
    gl_PointSize = size = depth * pointSize;


}