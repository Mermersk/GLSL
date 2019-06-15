#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time; 

float ease(float inputs) {
    float outputs = 0.5 - pow(max(0.0, abs(inputs) * 2.0 - 1.0), 1.0) - 0.1;
    return outputs;
}

float plotLine(float Xaxis, float Yaxis) {
    float outputValue = smoothstep(Xaxis - 0.01, Xaxis, Yaxis) -
    smoothstep(Xaxis, Xaxis + 0.01, Yaxis);
    return outputValue;

}

void main() {

    vec2 nc = gl_FragCoord.xy/u_resolution;
    vec3 finalColor = vec3(0.0);
    float line = plotLine(nc.x, nc.y);

    vec3 Xcoords = vec3(nc.x);
    Xcoords.r = smoothstep(0.0, 1.0, nc.x);
    Xcoords.g = sin(nc.x * PI);
    Xcoords.b = pow(nc.x, 0.5);

    //Demonstrating swizzling with color channels
    vec3 yellow, magenta, green;
    // Making Yellow
    yellow.rg = vec2(1.0);  // Assigning 1. to red and green channels
    yellow[2] = 0.0;        // Assigning 0. to blue channel
    // Making Magenta - Here swizzling is used
    magenta = yellow.rbg;   // Assign the channels with green and blue swapped
    // Making Green
    green.rgb = yellow.bgb; // Assign the blue channel of Yellow (0) to red and blue channels 
    
    //Linecolor is just for changing the color of "line" over time with sine
    vec3 lineColor = mix(green, magenta, abs(sin(u_time)));
    //Straight line with color varying after sine curve
    finalColor = mix(finalColor, lineColor, line);

    //A smoothstep line utilizing the red channel
    finalColor = mix(finalColor, vec3(1.0, 0.0, 0.0), plotLine(Xcoords.r, nc.y));
    //An Sine curve utilizing the green channel
    finalColor = mix(finalColor, vec3(0.0, 1.0, 0.0), plotLine(Xcoords.g, nc.y));
    //An line in the power of 0.5
    finalColor = mix(finalColor, vec3(0.0, 0.0, 1.0), plotLine(Xcoords.b, nc.y));
    gl_FragColor = vec4(finalColor, 1.0);
}
