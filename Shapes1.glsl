#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


void main() {

    vec2 nc = gl_FragCoord.xy/u_resolution;

    vec3 finalColor = vec3(1.0);

    //Everything under 0.1 will be 0.0, anything over will be 1.0
    //float left = step(0.1, nc.x);
    //float bottom = step(0.1, nc.y);
    float anim = abs(sin(u_time))/2.0;
    //Insteading of doing it in 2 lines(line 19 and 20), we can save lines by doing this below:
    //It is excatly the same as as in the previous 2 lines. bl = bottom and left.
    vec2 bl = smoothstep(vec2(anim + 0.99), vec2(anim), nc);
    //I "flip the page" to get the top and right borders.
    //Or more accurately I am rotating the canvas by 180° degrees and then doing the same procedure
    vec2 tr = smoothstep(vec2(anim + 0.99), vec2(anim), 1.0 - nc);
    //The multiplaction of left*bottom*top*right is similiar to the logical AND.
    float blFloat = bl.x * bl.y * tr.x * tr.y;
    
    // Similiar to saying the final image should be the black/white values of left AND bottom AND right AND top.
    finalColor = vec3(blFloat * vec3(0.3608, 0.9412, 0.0235));


    gl_FragColor = vec4(finalColor, 1.0);
}