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
    float ss = smoothstep(nc.y + 0.01, nc.y, nc.x)
    + smoothstep(nc.y, nc.y - 0.01, nc.x);

    float upRight = smoothstep(nc.y + 0.05, nc.y, nc.x) + smoothstep(nc.y, nc.y - 0.05, nc.x);
    float downLeft = smoothstep(nc.y - 0.05, nc.y, nc.x) + smoothstep(nc.y, nc.y + 0.05, nc.x);

    float upRightStep = step(0.5, nc.x) + step(0.6, nc.x);

    vec3 color = (upRight * vec3(0.0471, 0.9608, 0.1098)) + (downLeft * vec3(0.3765, 0.0, 0.9882));

    //vec3 color2 = vec3(smoothstep(nc.y + 0.01, nc.y, nc.x)
    //+ smoothstep(nc.y, nc.y - 0.01, nc.x)) * vec3(0.1098, 0.502, 0.2275);

    gl_FragColor = vec4(color, 1.0);

    /*
  vec2 point = gl_FragCoord.xy / u_resolution.xy;
  float px = 1.0 / u_resolution.y;
  vec2 cp = vec2(cos(u_time),sin(u_time));
  float l = gain(point.x, cp.x);
  vec3 color = vec3(smoothstep(l, l+px, point.y), cos(u_time), cos(cp.y));
    
  gl_FragColor = vec4(color, 1.0);
  */

}