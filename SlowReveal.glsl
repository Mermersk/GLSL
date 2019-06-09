#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time; 

void main() {

    vec2 nc = gl_FragCoord.xy/u_resolution;
    
    float alpha = 0.1;
    float invertTime = 1.0;
    
    invertTime += -u_time/5.0;
    alpha += u_time/5.0;
    
    float ss = smoothstep(invertTime, 1.0, nc.x);
    
    vec4 color = ss * vec4(vec3(0.7686, 0.2039, 0.2039), 1.0);

    gl_FragColor = color;
}