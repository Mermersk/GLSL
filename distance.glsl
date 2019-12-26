#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    
    vec2 nc = gl_FragCoord.xy/u_resolution;
    nc = nc * 1.0;
    nc = fract(nc);
    
    vec4 final = vec4(0.0);
    
    //calculates how far away each pixel is from the center
    float d = distance(nc.xy, vec2(0.5, 0.5));

    //gets me a timer in a cyclical 0.0 to 1.0 range
    float timer = abs(sin(u_time));

    //Normalizing range to 0.0 to 0.33
    float d_timer = timer / 3.0;
    
    //Creates the circle shape. d is the edge(location)
    //and d_timer is modulating where the "cutoff" point is.
    float c = step(d, d_timer);

    vec4 cColor = mix(final, c * vec4(0.5922, 0.0392, 0.9137, 1.0), 1.0);

    //vec3 ff = vec3(c, 0.5);
    
    gl_FragColor = cColor;
}