#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
#define PI 3.14159265359

#define gl.depthFunc(gl.NEVER);
// Plot a line on Y using a value between 0.0-1.0
float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}

void main() {
  //nc = normalized coordinates, divides each XY coords with resolution so that
  //all values lie beetween 0.0 and 1.0
  
	vec2 nc = gl_FragCoord.xy/u_resolution;
  
  //We need 4 boxes with red, 2 lines with white and 2 lines of blue.
  //Defining line
  float verticalWhiteLine = step(0.4, nc.x) - step(0.6, nc.x);
  float horizontalWhiteLine = step(0.5, nc.y) - step(0.65, nc.y);
 
  vec3 verticalWhiteLineColor = verticalWhiteLine * vec3(0.9216, 0.0824, 0.6706);
  vec3 horizontalWhiteLineColor = horizontalWhiteLine * vec3(0.0627, 0.6, 0.9608);
  vec3 final = mix(verticalWhiteLineColor, horizontalWhiteLineColor, 0.9);
  
	gl_FragColor = vec4(final, 1.0);
}