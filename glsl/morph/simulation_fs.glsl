
// simulation
 uniform sampler2D textureA;
 uniform sampler2D textureB;
 uniform float timer;

 varying vec2 vUv;
 void main() {

     //origin
     vec3 origin  = texture2D( textureA, vUv ).xyz;

     //destination
     vec3 destination = texture2D( textureB, vUv ).xyz;

     //lerp
     vec3 pos = mix( origin, destination, timer );
     gl_FragColor = vec4( pos,1.0 );

 }