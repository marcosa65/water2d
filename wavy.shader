shader_type canvas_item;
render_mode unshaded;

uniform float SPD_OF_FOG = 1.0;

float rand(vec2 coord) {
return fract(sin(dot(coord,vec2(12.9898, 78.233)))* 43758.5453123);
}

float noise(vec2 coord) {
vec2 i = floor(coord);
vec2 f = fract(coord);

float a = rand(i);
float b = rand(i + vec2(1.0, 0.0));
float c = rand(i + vec2(0.0, 1.0));
float d = rand(i + vec2(1.0, 1.0));

vec2 cubic = f * f * (3.0 - 2.0 * f);

return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0 - cubic.x) + (d - b) * cubic.x * cubic.y;
}

void fragment() {

// Wavy Shader
vec2 sprite_scale = vec2(textureSize(TEXTURE, 0));

float jagged_scale = 30.0;
vec2 noisecoord1 = UV * sprite_scale / jagged_scale;
vec2 noisecoord2 = UV * sprite_scale / jagged_scale + 4.0;

vec2 motion1 = vec2(TIME * SPD_OF_FOG, TIME * -0.4); // vec2(TIME * 0.3, TIME * -0.4)
vec2 motion2 = vec2(TIME * 0.1, TIME * SPD_OF_FOG); // vec2(TIME * 0.1, TIME * 0.5);

vec2 distort1 = vec2(noise(noisecoord1 + motion1), noise(noisecoord2 + motion1)) - vec2(0.5);
vec2 distort2 = vec2(noise(noisecoord1 + motion2), noise(noisecoord2 + motion2)) - vec2(0.5);

float powerOfDistort = 80.0; //Higher = Less Distort 
vec2 distort_sum = (distort1 + distort2) / powerOfDistort;

vec4 color = textureLod(TEXTURE, UV + distort_sum, 0.0);
color.rgb = mix(vec3(0.0), color.rgb,4.0 );
color *= textureLod(SCREEN_TEXTURE,SCREEN_UV + distort_sum,0.0);
COLOR = color;
}