#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
#define PI 3.14159265359

void main() {
  //nc = normalized coordinates, divides each XY coords with resolution so that
  //all values lie beetween 0.0 and 1.0
  
  	vec2 nc = gl_FragCoord.xy/u_resolution;

    float sintime = (sin(u_time)) /2.0) + 0.5;
    float sintimed = (sin(u_time+2.0) /2.0) + 0.5;
    
    float costime = abs(cos(u_time));

    float upAndDown = smoothstep(sintime - 0.02, sintime, nc.y) - 
    smoothstep(sintime, sintime + 0.02, nc.y);

    float rightAndLeft = smoothstep(sintimed - 0.02, sintimed, nc.x) - 
    smoothstep(sintimed, sintimed + 0.02, nc.x);

    vec3 color = (vec3(upAndDown) * vec3(1.0, 0.5, 0.2)) + (vec3(rightAndLeft) * vec3(0.2, 0.7, 0.9));

    gl_FragColor = vec4(color, 1.0);
}