shader_type sky;

vec3 hsl2rgb( in vec3 c )
{
    vec3 rgb = clamp( abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),6.0)-3.0)-1.0, 0.0, 1.0 );

    return c.z + c.y * (rgb-0.5)*(1.0-abs(2.0*c.z-1.0));
}

void sky() {
	vec3 sourcec_color = hsl2rgb(vec3(0.527, 0.592, 0.486));
	vec3 targetc_color = hsl2rgb(vec3(0.527, 0.513, 0.970));
	
	COLOR = mix(sourcec_color, targetc_color, abs(SCREEN_UV.y));
	// Called for every vertex the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
