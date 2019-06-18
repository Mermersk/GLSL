#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}


void main() {
    
    vec2 nc = gl_FragCoord.xy/u_resolution;
    vec3 orange = vec3(0.8784, 0.5725, 0.1686);
    vec3 red = vec3(0.6863, 0.0314, 0.0314);
    vec3 green = vec3(0.251, 0.8314, 0.0706);
    vec3 violet = vec3(0.5059, 0.0863, 0.8471);
    vec3 blue = vec3(0.0706, 0.4588, 0.9059);
    vec3 mixColor; //= vec3(nc.x);

    float violetBox = smoothstep(-0.2, 0.2, nc.y);
    float blueBox = smoothstep(0.2, 0.4, nc.y);
    float greenBox = smoothstep(0.4, 0.6, nc.y);
    float orangeBox = smoothstep(0.6, 0.8, nc.y);
    float redBox = smoothstep(0.8, 1.0, nc.y);
    
    mixColor = mix(mixColor, violet, violetBox);
    mixColor = mix(mixColor, blue, blueBox);
    mixColor = mix(mixColor, green, greenBox);
    mixColor = mix(mixColor, orange, orangeBox);
    mixColor = mix(mixColor, red, redBox);
    //mixColor = mix(mixColor, violet, nc.y);
    //mixColor = mix(mixColor, orange, orangeBox);

    
    vec3 hsbColor = vec3(nc.y, 1.0, abs(sin(u_time)));
    hsbColor = hsb2rgb(hsbColor);

    //Does not change background-other shapes too! (:
    //mixColor = mix(mixColor, violet, violetBox);
    //mixColor = mix(mixColor, blue, blueBox);

    //Changes Backround-other shapes too! ):
    //mixColor = redBox * red;

    /*
    Does not change Background-other shapes too! (:
    The trick here is too do: (1.0 - the shape) and multiply this with the "old" mixColor,
    in order to gain a new mixColor where other parts of the image
    are not effected. Step(0.8, nc.y): everything under 0.8 will become 0.0 so 1.0 - 0.0 restores everything that was set to black by step back
    to its previous drawing, here it is an gradient.
    */
    //mixColor = (1.0 - redBox) * mixColor + redBox*red;

    
    gl_FragColor = vec4(mixColor, 1.0);

   

}