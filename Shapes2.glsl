#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

/*
Function for making an box. nc: normalized coordinates.
howBig: specifies how big the box should be. 
A bigger value equals a smaller box, while smaller value equals bigger box. 
Value range(sirka): 0.0 to 0.5
howmuddy: Is for specifying how much "space"-smoothstep should be on the border of the box
A value of 0.0 will give a straight line-that is to say no gradient.
value range: 0.0 to 1.0 (depends on size of box if tis visible or not)
*/

float makeFilledBox(vec2 nc, float howBig, float howMuddy) {

    vec2 bl = smoothstep(vec2(howBig), vec2(howBig + howMuddy), nc);
   
    vec2 tr = smoothstep(vec2(howBig), vec2(howBig + howMuddy), 1.0 - nc);
    
    return bl.x * bl.y * tr.x * tr.y;

}

float makeOutlineBox(vec2 nc) {

    float b = step(0.1, nc.y) - step(0.2, nc.y) + step(0.1, nc.x) - step(0.9, nc.x);
    //float a = b.x * b.y;

    return b;

}


void main() {

    vec2 nc = gl_FragCoord.xy/u_resolution;

    vec3 finalColor = vec3(1.0);

    //Everything under 0.1 will be 0.0, anything over will be 1.0
    //float left = step(0.1, nc.x);
    //float bottom = step(0.1, nc.y);
    float anim = abs(sin(u_time));

    //vec2 bl = smoothstep(vec2(0.1), vec2(0.2), nc);
   
    //vec2 tr = smoothstep(vec2(0.1), vec2(0.2), 1.0 - nc);
    
    float blFloat = makeOutlineBox(nc);

    finalColor = vec3(blFloat); //* vec3(0.3608, 0.9412, 0.0235));


    gl_FragColor = vec4(finalColor, 1.0);
}