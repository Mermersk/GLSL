#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float sinc( float x, float k ){
  float a = 3.1459265359 * k * x - 1.0;
  
  return sin(a)/a;
}

float testf(float coords, float time) {

  float outputs = coords * time;
  return sin(outputs)/outputs - 0.5; 

}

void main() {
  

  vec2 nc = gl_FragCoord.xy/u_resolution;

  float slowTime = u_time/10.0;

  float wave = nc.x * cos(u_time); 
  float ss = testf(nc.x, sin(u_time));

  float testWave = nc.x - sin(u_time)-0.5;
  testWave = sin(testWave)/testWave-0.4;

  float lineUp = smoothstep(nc.y + 0.005, nc.y, testWave);
  float lineDown = smoothstep(nc.y - 0.005, nc.y, testWave);
  vec3 finalColor = lineUp * vec3(0.0824, 0.8863, 0.2824) + lineDown * vec3(0.2118, 0.051, 0.9216);

  gl_FragColor = vec4(finalColor, 1.0);
   
}


  /*
    vec2 nc = gl_FragCoord.xy/u_resolution;
   
    float wave = nc.x * abs(cos(u_time));
    float wave2 = nc.x / abs(cos(u_time));

    float upRight = smoothstep(nc.y + 0.05, nc.y, wave2); // smoothstep(nc.y, nc.y + 0.05, nc.x);
    float downLeft = smoothstep(nc.y, nc.y + 0.05, wave); //+ smoothstep(nc.y, nc.y + 0.05, nc.x);

    float upRightStep = step(0.5, nc.x) + step(0.6, nc.x);

    vec3 color = (upRight * vec3(0.0471, 0.9608, 0.5)) + (downLeft * vec3(0.3765, 0.0, 0.9882));
    vec3 color2 = vec3(1.0);
    //vec3 color2 = vec3(smoothstep(nc.y + 0.01, nc.y, nc.x)
    //+ smoothstep(nc.y, nc.y - 0.01, nc.x)) * vec3(0.1098, 0.502, 0.2275);

    gl_FragColor = vec4(color, 1.0);
  
  vec2 nc = gl_FragCoord.xy/u_resolution;
  float wave = nc.x * abs(cos(u_time));
  float oneDividedByHeight = 1.0 / u_resolution.y;
  vec2 cp = vec2(cos(u_time),sin(u_time));
  float l = sinc(nc.x, cp.x);
  vec3 color = vec3(smoothstep(l, l+oneDividedByHeight, nc.y), asin(u_time), acos(cp.y));
  
  */