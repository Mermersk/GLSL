#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
#define PI 3.14159265359

float sf(float inn) {

    float outputs = 1.0 - pow(max(0.0, abs(inn) * 2.0 - 1.0), 0.5);
    return outputs;
}

float straight(float inn) {
    float outputs = pow(min(cos(PI * inn / 2.0), 1.0 - abs(inn)), 1.0);
    return outputs;
}


void main() {
  //nc = normalized coordinates, divides each XY coords with resolution so that
  //all values lie beetween 0.0 and 1.0
    
    vec3 yellow, magenta, green;

  	vec2 nc = gl_FragCoord.xy/u_resolution;
    float sintime = abs(sin(u_time));

    yellow.rg = vec2(1.0);
    yellow[2] = 0.0;

    magenta = yellow.rbg;
    green.rgb = yellow.bgb;
    vec3 color = mix(magenta, green, straight(sintime));
   
    gl_FragColor = vec4(color, 1.0);
}