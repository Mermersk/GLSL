#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    
    vec2 nc = gl_FragCoord.xy/u_resolution;
    nc = nc * 3.0;
    nc = fract(nc);
    
    vec4 final = vec4(0.0);
    
    //calculates how far away each pixel is from the center
    float d = distance(nc.xy, vec2(0.5, 0.5));

    //gets me a timer in a cyclical 0.0 to 1.0 range
    float timer = abs(sin(u_time));

    //Normalizing range to 0.0 to 0.33
    float d_timer = timer / 1.4;
    float greenTimer = timer / 2.0;
    float blueTimer = timer / 2.6;
    
    //Creates the circle shape. d is the edge(location)
    //and d_timer is modulating where the "cutoff" point is.
    //float redCircle = step(d, d_timer);
    float redCircle = smoothstep(d, 1.0, d_timer + 0.2);
    float greenCircle = smoothstep(d, 1.0, greenTimer + 0.2);
    float blueCircle = smoothstep(d, 1.0, blueTimer + 0.2);

    vec4 cColor = vec4(1.0, 1.0, 1.0, 0.0); //mix(final, c * vec4(0.5922, 0.0392, 0.9137, 1.0), 1.0);
    cColor = mix(cColor, vec4(1.0, 0.0, 0.0, 1.0), redCircle);
    cColor = mix(cColor, vec4(0.0, 1.0, 0.0, 1.0), greenCircle);
    cColor = mix(cColor, vec4(0.0, 0.0, 1.0, 1.0), blueCircle);
    
    
    gl_FragColor = cColor;

}