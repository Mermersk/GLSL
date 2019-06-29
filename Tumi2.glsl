#ifdef GL_FRAGMENT_PRECISION_MEDIUM
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

void main(void) {
  vec2 uv = gl_FragCoord.xy / u_resolution.xy;
  vec2 middle = u_resolution.xy/2.0;

  float x = gl_FragCoord.x;
  float y = gl_FragCoord.y;
  float dx = abs(middle.x - x);
  float dy = abs(middle.y - y);

  float distance = sqrt(pow(dx, 2.0) +
    pow(dy, 2.0));

  vec3 rgb = hsb2rgb(vec3(
    pow(distance * 0.01, abs(tan(u_time))),
    0.9,
    0.9-distance*0.001));

  gl_FragColor = vec4(rgb, 1.0);
}