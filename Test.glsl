#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float gain(float x, float k) {
  float a = 0.5*pow(2.0*((x<0.5)?x:1.0-x), k);
  return (x<0.5)?a:1.0-a;
}

void main() {
    
    vec2 nc = gl_FragCoord.xy/u_resolution;
    float ss = step(0.5, nc.x) - step(0.5, nc.y);
    vec3 color = ss * vec3(0.1, 0.9451, 0.3137);
    gl_FragColor = vec4(color, 1.0);

   

}