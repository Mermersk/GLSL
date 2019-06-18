#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float shape(float inputs) {
    float outputs;
    outputs = 1.0 - pow(max(0.0, abs(inputs) * 2.0 - 1.0), 1.5);
    return outputs;

}

void main() {
    
    vec2 nc = gl_FragCoord.xy/u_resolution;
    vec3 orange = vec3(0.8784, 0.5725, 0.1686);
    vec3 blue = vec3(0.0706, 0.4588, 0.9059);
    vec3 mixColor = vec3(nc.x);

    float slowtime = u_time/2.0;
    
    float ss = smoothstep(0.0, shape(abs(sin(u_time))), nc.y);
    mixColor = mix(orange, blue, ss);
    

    gl_FragColor = vec4(mixColor, 1.0);

   

}