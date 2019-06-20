#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time; 

void main() {

    vec2 nc = gl_FragCoord.xy/u_resolution;

    vec3 baseColor = vec3(0.9882, 0.0, 0.0);
    vec3 blueStripe = vec3(0.0, 0.0, 1.0);
    vec3 whiteStripe = vec3(1.0);

    float whiteHorizontal = step(0.6, nc.y) - step(0.75, nc.y);
    float blueHorizontal = step(0.63, nc.y) - step(0.72, nc.y);

    float whiteVertical = step(0.4, nc.x) - step(0.6, nc.x);
    float blueVertical = step(0.44, nc.x) - step(0.56, nc.x);
    
    //Animation transition beetween colors
    baseColor = mix(baseColor, blueStripe, sin(u_time));
    
    baseColor = mix(baseColor, whiteStripe, whiteHorizontal);
    baseColor = mix(baseColor, whiteStripe, whiteVertical);
    
    //Animation transition between colors
    blueStripe = mix(blueStripe, vec3(1.0, 0.0, 0.0), sin(u_time));

    baseColor = mix(baseColor, blueStripe, blueHorizontal);
    baseColor = mix(baseColor, blueStripe, blueVertical);
    //OBS-Note: Basecolor here in the end is a composiiton of different colors, not just one, one for each pixel though.
    
    /*
    Hmmmmmmmmmmmmm? Code below not really woeking at not blending the
    baseColor = (1.0 - blueHorizontal) * (1.0 - blueVertical) * (1.0 - whiteHorizontal) * (1.0 - whiteVertical) * baseColor +
    whiteHorizontal * whiteStripe + 
    whiteVertical * whiteStripe +
    blueHorizontal * blueStripe +
    blueVertical * blueStripe;
    */
    gl_FragColor = vec4(baseColor, 1.0);


}