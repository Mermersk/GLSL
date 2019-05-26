#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time; 

void main() {

    vec2 nc = gl_FragCoord.xy/u_resolution;

    float ss = smoothstep(nc.y + 0.01, nc.y, nc.x)
    - smoothstep(nc.y, nc.y - 0.01, nc.x);


    vec3 color = ss * vec3(1.0); 

    gl_FragColor = vec4(color, 1.0);
}