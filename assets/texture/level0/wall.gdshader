shader_type spatial;
uniform sampler2D wallPaperTex;
uniform sampler2D noiseTex;
uniform vec4 filthColor:source_color = vec4(0.0,0.0,0.0,1.0);

const float TEX_UV_SCALE = 1.0;
const float NOISE_UV_SCALE = 0.1;

varying vec3 MCoord;

void vertex() {
	MCoord = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
	ROUGHNESS = 1.0;
}

void fragment() {
	vec2 customUV = vec2(MCoord.x+MCoord.z,-MCoord.y);
	ALBEDO = mix(texture(wallPaperTex,customUV * TEX_UV_SCALE),filthColor,texture(noiseTex,customUV * NOISE_UV_SCALE).r * filthColor.a).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
