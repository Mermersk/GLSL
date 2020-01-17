#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define constant 1.0

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

//radius should go from 0.0 to 1.0 (1.0 will fill whole screen)
float circle(vec2 nc, vec2 pos, float radius) {

    float d = distance(nc.xy, vec2(pos.x, pos.y));

    float c = step(d, radius);

    return c;
}

void main(){
    
    vec2 nc = gl_FragCoord.xy/u_resolution;
    //Remapping the space(nc) to be between -1.0 and 1.0. 0.0 Is then the middle. 
    nc = (nc * 2.0) - 1.0;

    //nc = nc * 5.0;
    //nc = fract(nc);


    //Making the "distance field"
    //length is the magnitude of the vector. eg: how big is it?
    //from where? As far is I can infer, we are calculating the position
    //from each pixel to the position vec2(0.5, 0.5) (thats why -0.5 is there).
    //abs is just there so that We can do this in all 4 quadrants!
    float df = length(min(abs(nc) - 0.4, 0.3));
    //These two function to excatly the same! (the length and distance ones)
    //float df = distance(abs(nc) - 0.5, vec2(0.0, 0.0));
    
    //Here we are using the fract function to visualize the
    //distance field values, this makes it easier to see the
    //pattern it is creating. They repeat over and over again.
    vec4 final = vec4(vec3(1.0 - step(0.31, df)), 1.0);
    final = final * vec4(vec3(0.5, 0.99, 0.7), 1.0);

    gl_FragColor = final;
}