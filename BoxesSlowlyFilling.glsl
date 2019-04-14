#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
#define PI 3.14159265359


void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;

    bool change = false;
    float slowTime = u_time/20.0;
    float stepIncrease = 0.5 + slowTime;
    float stepDecrease = 0.5 - slowTime;
    float movement;

    //Does absolutely nothing as of now
    if (stepIncrease > 0.8) {
      slowTime = -abs(slowTime);
    } 
    
    movement = step(stepDecrease, st.x) - step(stepIncrease, st.x) +
    step(stepDecrease, st.y) - step(stepIncrease, st.y);
    
    
    
  //Its possible to assing color by multiplying desired color with the "movement" vector.
    vec3 color = vec3(movement) *vec3(0.9451, 0.0745, 0.7569);

    // Plot a line
    //float pct = plot(st,y);
    //color = (1.0-pct)*color+pct*vec3(0.9529, 0.0863, 0.9098);

	gl_FragColor = vec4(color, 1.0);
}