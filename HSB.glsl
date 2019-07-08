#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time; 

vec3 rgb2hsb( in vec3 c ){
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz),
                 vec4(c.gb, K.xy),
                 step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r),
                 vec4(c.r, p.yzx),
                 step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)),
                d / (q.x + e),
                q.x);
}

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

//A shaping function
float ease(float inputs) {
    float outputs = 0.5 - pow(max(0.0, abs(inputs) * 2.0 - 1.0), 1.0) - 0.1;
    return outputs;
}

void main() {

    vec2 nc = gl_FragCoord.xy/u_resolution;
    //hsb2rgb simply translates HSB color values to RGB.
    //HSB = Hue, saturation, brightness
    vec3 baseColor = vec3(1.0);

    //Using polar coordinates instead of cartesian
    //Moves image to the middle. f. ex: 0.0 will be moved to 0.5-middle
    vec2 toCenter = vec2(0.5) - nc;
    //vec2 toCenter = nc / vec2(0.5);
    
    //Will return a value between -PI and PI(-3.14 to 3.14)
    //Divide by TWO_pi to get values between -.5 and 0.5 and then 
    //add 0.5 to get us in the range 0.0 to 1.0
    float angle = atan(toCenter.y, toCenter.x);
    angle = angle + sin(u_time)*10.0;

    //The radius will return a maximum of 0.5, because we are calculating distance fomr middle of canvas.
    //So we multiply by two to get a maximum of 1.0(to get the range to be from 0.0 to 1.0)
    float radius = length(toCenter) * 3.0;

    baseColor = hsb2rgb(vec3(angle/TWO_PI, sin(radius), 1.0));


    gl_FragColor = vec4(baseColor, 1.0);

    
}