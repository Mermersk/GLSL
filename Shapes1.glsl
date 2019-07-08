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
    float left = step(0.1, nc.x);
    float bottom = step(0.1, nc.y);

    //Insteading of doing it in 2 lines(line 19 and 20), we can save lines by doinf this below:
    //It is excatly the same as as in the previous 2 lines.
    vec2 borders = step(vec2(0.1), nc);
    float bordersFloat = borders.x * borders.y;

    //The multiplaction of left*bottom is similiar to the logical AND.
    // Similiar to saying the final image should be the black/white values of left AND bottom.
    finalColor = vec3(bordersFloat);


    gl_FragColor = vec4(finalColor, 1.0);
}