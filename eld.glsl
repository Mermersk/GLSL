#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    
    vec2 nc = gl_FragCoord.xy/u_resolution;
    //nc = nc * 1.0;
    //nc = fract(nc);

    nc.x = nc.x - 0.5;
    vec4 final = vec4(0.0);
    //float tt = (abs(sin(u_time)) + 0.9) * 1.1;
    float distanceEpicenter = 1.0;
    //calculates how far away each pixel is from the center
    float d = distance(nc.y, distanceEpicenter);
    //d = clamp(d, 1.0, 2.0);
    nc.y = nc.y - (u_time/2.0);
    
    float wavy = nc.y - u_time;
    wavy =  (sin(wavy)/8.0) / (d+0.5);//((abs(sin(wavy)) / 6.0));
    //float middle = 0.5;
    float light = smoothstep(nc.x - 0.2, nc.x, wavy) - smoothstep(nc.x, nc.x + 0.2, wavy);
    
    //final = mix(final, vec4(1.0, 1.0, 1.0, 1.0), vertical * d);
    final = vec4((light * d) * 4.0, (light * d) * 2.0, (light * d), (light * d) + 1.0);
    //final.r = final.r * 4.0;
    //final.g = final.g * 2.0;
    //final.a = final.a + 2.0;

    gl_FragColor = final;

}