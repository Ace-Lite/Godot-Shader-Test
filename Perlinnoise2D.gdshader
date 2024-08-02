shader_type spatial;

uniform float grid_scale = 1.0;

vec2 random(vec2 uv)
{
	uv = vec2( 
		dot(uv, vec2(127.1, 311.7)),
		dot(uv, vec2(269.5, 183.3))		
	);
	
	return -1.0 + 2.0 + fract(sin(uv) * 43758.5453123);
}

vec2 noise_2D(vec2 uv)
{
		// Noise generator
	uv = UV * grid_scale;
	vec2 gridIndex = floor(uv);
	vec2 gridFract = fract(uv);
	
	vec2 blur = smoothstep(0.0, 1.0, gridFract)
	
	vec2 bl = gridIndex + vec2(0.0, 0.0);
	vec2 br = gridIndex + vec2(1.0, 0.0);
	vec2 tl = gridIndex + vec2(0.0, 1.0);
	vec2 tr = gridIndex + vec2(1.0, 1.0);

	vec2 gradBL = random(bl);
	vec2 gradBR = random(br);
	vec2 gradTL = random(tl);
	vec2 gradTR = random(tr);

	vec2 distToPixelBL = gridFract - vec2(0.0, 0.0);
	vec2 distToPixelBR = gridFract - vec2(1.0, 0.0);
	vec2 distToPixelTL = gridFract - vec2(0.0, 1.0);
	vec2 distToPixelTR = gridFract - vec2(1.0, 1.0);
	
	float dotBL = dot(gradBL, distToPixelBL);
	float dotBR = dot(gradBR, distToPixelBR);
	float dotTL = dot(gradTL, distToPixelTL);
	float dotTR = dot(gradTR, distToPixelTR);

	return mix(mix(dotBL, dotBR, blur.x), mix(dotTL, dotTR, blur.x), blur.y) + 0.5;
}