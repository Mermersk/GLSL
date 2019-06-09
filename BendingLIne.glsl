#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time; 

float plot(vec2 st, float pct){
  return  smoothstep( 0.5, pct, st.y) -
          smoothstep( pct, 0.4, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;
    float c = pow(st.x, abs(sin(u_time/2.0)));
    float line = smoothstep(c-0.05, c, st.y) - smoothstep(c, c+0.05, st.y);
  
    vec4 color = vec4(line) * vec4(1.0, 0.0, 0.0, 1.0);

    //float pct = plot(st,y);
    //color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

    gl_FragColor = vec4(color);
}