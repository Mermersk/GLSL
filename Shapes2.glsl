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

/*
Makes an outline of a box.
Position: value range: 0.0 to 0.49. Determines how far from edge of canvas the box should be. 0.0 will be on the edge while higher values go more towards middle
and therefore makes also a smaller box.
thickness: determines how thick the outline of the box is. value range: 0.0 to 0.49
*/
float makeOutlineBox(vec2 nc, float position, float thickness) {
    
    //float anim = abs(sin(u_time))/1.0;
    float anim = u_time/10.0;
    //float thickness = 0.01;
    //Position value range: 0.0 to 1.0. Position determines how far from the edge of the screen outlineBoc should start.
    //float position = 0.1;
    float positionInvert = 1.0 - position;
    position += anim;
    positionInvert -= anim;

    //The last step in b: 1.0 - nc.x "rotates" the canvas 180 degrees
    float b = step(position, nc.y) - step(position + thickness, nc.y) - step(positionInvert, nc.x) - step(positionInvert, 1.0 - nc.x);
    float t = step(positionInvert - thickness, nc.y) - step(positionInvert, nc.y) - step(positionInvert, nc.x) - step(positionInvert, 1.0 - nc.x);
    float r = step(positionInvert - thickness, nc.x) - step(positionInvert, nc.x) - step(positionInvert, nc.y) - step(positionInvert, 1.0 - nc.y);
    float l = step(position, nc.x) - step(position + thickness, nc.x) - step(positionInvert, nc.y) - step(positionInvert, 1.0 - nc.y);

    return b+t+r+l;

}


void main() {

    vec2 nc = gl_FragCoord.xy/u_resolution;

    vec4 finalColor = vec4(0.0, 0.0, 0.0, 0.0);

    //Everything under 0.1 will be 0.0, anything over will be 1.0
    //float left = step(0.1, nc.x);
    //float bottom = step(0.1, nc.y);
    //float anim = abs(sin(u_time));

    //float oBox = makeOutlineBox(nc, 0.0, 0.01);
    //float oBox2 = makeOutlineBox(nc, 0.1, 0.01);

    float inc = 0.0;
    const int maximum = 30;
    //inc += 0.1;

    float boxBuffer[10];
    
    for (int i = 0; i < maximum; i++) {
       
        float ooo = makeOutlineBox(nc, inc, 0.01);
        //boxBuffer[i] = ooo;
        inc -= 0.1;
        finalColor = mix(finalColor, vec4(0.149, 0.0, 1.0, 1.0), ooo);
            
    }


    //while (u_time < 10.0) {
        //float ooo = makeOutlineBox(nc, inc, 0.01);
        //inc += 0.1;
        //finalColor = mix(finalColor, vec3(0.149, 0.0, 1.0), ooo);

    //}

    //blFloat += makeOutlineBox(nc, 0.0, 0.01);
    //finalColor += blFloat; //* vec3(0.149, 0.0, 1.0);
    
    //finalColor =  oBox * vec3(0.149, 0.0, 1.0);
    //finalColor = mix(finalColor, vec3(0.149, 0.0, 1.0), oBox2);

    gl_FragColor = finalColor;
}