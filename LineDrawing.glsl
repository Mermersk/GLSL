#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time; 

void main() {

    vec2 nc = gl_FragCoord.xy/u_resolution;
    float c = pow(min(cos(PI * nc.x / 2.0), 1.0 - abs(nc.x)), 0.5);
    //c = c + sin(u_time);
    c = clamp(c, abs(sin(u_time)), abs(cos(u_time)));
    float line = smoothstep(nc.y - 0.02, nc.y, c) - 
    smoothstep(nc.y, nc.y + 0.02, c);
    
    vec3 green = vec3(0.302, 0.9216, 0.3529);
    vec3 red = vec3(0.9, 0.0, 0.0);
    
    //Old, Whole line is just one color, no changes
    //vec3 color = line * vec3(0.302, 0.9216, 0.3529);

    //Old, whole line changes color equally along every pixel
    //vec3 color = line * mix(green, red, abs(tan(u_time)));

    //New with smoothstep so tthat color changes in an gradient way
    vec3 color = line * mix(green, red, smoothstep(0.0, abs(tan(u_time)), nc.x));
   
    gl_FragColor = vec4(color, 1.0);
}