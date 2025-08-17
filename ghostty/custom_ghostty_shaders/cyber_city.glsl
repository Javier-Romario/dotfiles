// Cyber City
// by Hazel Quantock 2018
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. http://creativecommons.org/licenses/by-nc-sa/4.0/

void mainImage( out vec4 fragColour, in vec2 fragCoord )
{
#if ( GRUNGE )    
    // tracking glitch
    fragCoord += .2*tan(-.5*(iTime+1.4*sin(iTime/1.2+.05))+.3*fragCoord.y/iResolution.y);
#endif
    
    vec3 bloom = GaussianBlur( iChannel3, ivec2(fragCoord), ivec2(0,1), BLUR_RADIUS.y );
    
#if ( GRUNGE )    
    // chromatic aberation
    vec2 uv = fragCoord/iResolution.xy - .5;
//    uv *= 1. - .1*dot(bloom,vec3(.1,.7,.2)); // CRT distortion around bright areas
//    uv *= mix(1.,pow(length(uv)/.7,5.),.1); // curve <- better to do this in source render!
	fragColour.r  = texture( iChannel0, 0.996*uv+.5 ).r;
	fragColour.ga = texture( iChannel0, 1.000*uv+.5 ).ga;
	fragColour.b  = texture( iChannel0, 1.010*uv+.5 ).b;
#else
	fragColour = texelFetch( iChannel0, ivec2(fragCoord), 0 );
#endif
    
	fragColour.rgb = mix(
        fragColour.rgb,
        bloom,
        fragColour.a );
    
    
#if ( GRUNGE )    
    // add some grungey effects
    vec3 grunge = texture( iChannel1, fragCoord/iChannelResolution[1].xy + vec2(.7549,.5698)*float(iFrame) ).rgb;
    fragColour.rgb = mix( fragColour.rgb*mix( vec3(1), grunge, .2 ), grunge*vec3(.3,1,.6), .02 );
    fragColour.rgb *= 1.+.4*sin(6.283185*fragCoord.y*.5*.618+iTime);
    
    // adjust exposure periodically
    fragColour.rgb *= mix( 1., 2.5, smoothstep(.0,.3,cos(iTime/7.)) );
    
    // contrast stretch, to make it a bit more filmic
    fragColour.rgb = max(vec3(0),fragColour.rgb-.02);
#endif

    fragColour.rgb = pow( fragColour.rgb, vec3(1./2.2) );
    fragColour.a = 1.;

    vec4 terminalColor = texture(iChannel0, q);
    fragColour = mix(fragColour, terminalColor, step(length(terminalColor.rgb)));
}
