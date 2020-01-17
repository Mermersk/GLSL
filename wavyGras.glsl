#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

//x should be in the range -0.5 to 0.5, -0.5 is rightmost, 0.5 is leftmost
vec4 singleGras(float distanceEpicenter, float x, float curveOffset, float u_time, vec2 nc) {

    vec4 final = vec4(0.0);

    //Function to greate deterministic randomnes
    float coRand = fract(sin(curveOffset) * 13040.0);

    float de = distanceEpicenter;
    //calculates how far away each pixel is from the center
    float d = distance(nc.y, de);

    nc.y = nc.y - (u_time/2.0);

    float wavy = (nc.y - u_time);

    //original was: sin((wavy)/8.0)
    wavy =  (sin(wavy+coRand)/8.0) / (d+0.5);

    float light = smoothstep((nc.x - 0.01) + x, (nc.x) + x, wavy) - smoothstep((nc.x) + x, (nc.x + 0.01) + x, wavy);

    final = vec4((light * d) * 0.0, (light * d) * 5.0, (light * d) * 0.0, (light * d) + 1.0);

    return final;
}

void main(){
    
    vec2 nc = gl_FragCoord.xy/u_resolution;
    //nc = nc * 1.0;
    //nc = fract(nc);

    nc.x = nc.x - 0.5;

    //vec4 final = vec4(0.0);
    //float tt = (abs(sin(u_time)) + 0.9) * 1.1;
    //float distanceEpicenter = 1.0;
    //calculates how far away each pixel is from the center
    //float d = distance(nc.y, distanceEpicenter);
    //d = clamp(d, 1.0, 2.0);
    //nc.y = nc.y - (u_time/2.0);
    
    //float wavy = nc.y - u_time;
    //wavy =  (sin(wavy)/8.0) / (d+0.5);//((abs(sin(wavy)) / 6.0));
    //float middle = 0.5;
    //float light = smoothstep(nc.x - 0.01, nc.x, wavy) - smoothstep(nc.x, nc.x + 0.01, wavy);
    //final = mix(final, vec4(1.0, 1.0, 1.0, 1.0), vertical * d);
    //final = vec4((light * d) * 2.0, (light * d) * 5.0, (light * d) * 0.5, (light * d) + 1.0);

    vec4 fin = vec4(0.0);

    for (int i = 0; i < 30; i++) {
        //converting to float
        float index = float(i);
        //setting where on x-axis each straw is
        float x_range = ((index/28.0) - 0.5);
        //generating each straw.
        vec4 sg = singleGras(1.0, x_range, float(i), u_time, nc);
        fin = mix(fin, sg, sg);
    }

    gl_FragColor = fin;

}