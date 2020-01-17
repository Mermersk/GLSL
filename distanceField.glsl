#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

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

    //Making the "distance field"
    //length is the magnitude of the vector. eg: how big is it?
    //from where? As far is I can infer, from the point 0.0
    float df = length(abs(nc) - 0.5);
    //These two function to excatly the same! (the length and distance ones)
    //float df = distance(abs(nc) - 0.5, vec2(0.0, 0.0));
    
    //Here we are using the fract function to visualize the
    //distance field values, this makes it easier to see the
    //pattern it is creating. They repeat over and over again.
    vec4 final = vec4(vec3(fract(df*5.0)), 1.0);

    /*
    Note: Reason that we can achieve 4 images on 1 screen:
    we have made the space be between -1.0 and 1.0, then
    we calculate the the distance field with absolute values - 0.5(to center them)
    finally we visualize with a fract function on the distance field.
    */

    gl_FragColor = final;
}