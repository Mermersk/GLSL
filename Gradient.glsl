#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


void main() {
    
    vec2 nc = gl_FragCoord.xy/u_resolution;
    vec3 orange = vec3(0.8784, 0.5725, 0.1686);
    vec3 blue = vec3(0.0706, 0.4588, 0.9059);
    vec3 mixColor = vec3(1.0);
    mixColor = mix(mixColor, orange, smoothstep(0.0, 1.0, nc.x));
    mixColor = mix(mixColor, blue, smoothstep(1.0, 0.0, nc.x));
    //mix(mixColor, blue, smoothstep(0.3, 0.45, nc.y));
    //mixColor = mix(mixColor, blue, smoothstep(0.3, 0.45, nc.y));





    gl_FragColor = vec4(mixColor, 1.0);

   

}