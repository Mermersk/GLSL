#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define constant 1.0

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// Plot a line on Y using a value between 0.0-1.0
float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}

//ss, cubicPulse and ff are shaping functions.

float ss(float x) {
    return 1.0 - pow(abs(x), 1.0);
}

float cubicPulse( float c, float w, float x ){
    x = abs(x - c);
    if( x>w ) return 0.0;
    x /= w;
    return 1.0 - x*x*(3.0-2.0*x);
}

float ff(float x) {
    float ret = pow(min(cos(PI * x / 2.0), 1.0 - abs(x)), pow(min(cos(PI * x / 2.0), 1.0 - abs(x)), 3.0));
    return ret;
}


void main(){
    
    vec2 nc = gl_FragCoord.xy/u_resolution;
    //Makes the space be in the range: -0.5 to 0.5
    nc = vec2(0.5) - nc;
    //nc.y = nc.y - sin(u_time);
    //Remapping the space(nc) to be between -1.0 and 1.0. 0.0 Is then the middle. 
    //nc = (nc * 2.0) - 1.0;

    //nc = nc * 5.0;
    //nc = fract(nc);


    //Making the "distance field"
    float radius = length(nc) * 3.0;
    float angle = atan(nc.x, nc.y);

    //float shape = cos(angle * 2.0);
    float shape = ff(angle * 1.0);
    //Here we are using the fract function to visualize the
    //distance field values, this makes it easier to see the
    //pattern it is creating. They repeat over and over again.
    vec4 final = vec4(vec3(1.0 - smoothstep(shape, shape+0.01, radius)), 1.0);
    final = final + (plot(nc, shape) * vec4(vec3(0.5, 0.99, 0.7), 1.0));

    gl_FragColor = final;
}