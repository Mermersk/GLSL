#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time; 

float ease(float inputs) {
    float outputs = 1.0 - pow(max(0.0, abs(inputs) * 2.0 - 1.0), 1.0);
    return outputs;
}

void main() {

    vec2 nc = gl_FragCoord.xy/u_resolution;

    vec3 yellow, magenta, green;

    // Making Yellow
    yellow.rg = vec2(1.0);  // Assigning 1. to red and green channels
    yellow[2] = 0.0;        // Assigning 0. to blue channel

    // Making Magenta
    magenta = yellow.rbg;   // Assign the channels with green and blue swapped

    // Making Green
    green.rgb = yellow.bgb; // Assign the blue channel of Yellow (0) to red and blue channels 
    
    vec3 color = mix(yellow, magenta, ease(abs(sin(u_time))));

    gl_FragColor = vec4(color, 1.0);
}

