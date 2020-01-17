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
    //nc = nc * 1.0;
    //nc = fract(nc);
    
    vec4 final = vec4(0.0);
    //Cos is the X-axis and Sin is the Y-axis
    nc.x = nc.x + (cos(u_time*2.0)/5.0);
    nc.y = nc.y + (sin(u_time*2.0)/5.0);

    //nc = nc * 20.0;
    //nc.xy = fract(nc.xy);

    //float miniCircle = circle(nc, 0.10);

    //This is the way to make arrays in glsl:
    /*
    float circles[4];

    nc = nc - 0.5;

    for (int i = 0; i < 12; i++) {

        float index = float(i);

        index = index / 2.0;

        vec2 pos = vec2(cos(index) / 5.0, sin(index) / 5.0);
        float circle = circle(nc, pos, 0.05);

        vec4 cColor = mix(final, circle * vec4(0.0275, 0.6314, 0.1804, 1.0), circle);

        final = mix(final, cColor, cColor);

    }

    */

    vec2 pos = vec2(0.5, 0.5);
    float circle = circle(nc, pos, 0.20);

    //circle = circle * 8.0;
    //circle = fract(circle);

    //vec3 combined = (circle * vec3(1.0)) + (miniCircle * vec3(0.0745, 0.9137, 0.2157));
    //vec3 combined = mix(circle * vec3(1.0), miniCircle * vec3(0.0), miniCircle);

    //float distanceCenter = nc.y;
    //float bDistance = distance(distanceCenter, circle);

    vec4 cColor = mix(final, circle * vec4(0.0275, 0.6314, 0.1804, 1.0), 1.0);
    
    gl_FragColor = cColor;
}