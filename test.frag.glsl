#version 330
in FS_IN {
	vec3 normal;
	vec2 uv;
	vec3 pos;
	vec4 tangent;
} fs_in;
out vec4 color;

uniform sampler2D diffuse_texture @Material@;
uniform sampler2D normal_texture @Material@;
uniform bool bump @Material@;
uniform float bump_depth @Material@;

uniform float ambient_light @Lighting@;
uniform float light_angle_a @Lighting@;
uniform float light_angle_b @Lighting@;
uniform float light_intensity @Lighting@;
uniform vec3 light_color @Lighting@;

vec4 shade(vec3 normal, vec3 tangent, vec3 bitangent, vec3 light_color, vec3 light_dir, float light_intensity)
{
	float diffuse_intensity = max(dot(normal, light_dir),0);
	vec3 diffuse_color = texture(diffuse_texture, vec2(fs_in.uv.x, -fs_in.uv.y)).xyz;
	return vec4(diffuse_color *
		light_color *
		light_intensity * 2 *
		mix(diffuse_intensity, 1, ambient_light), 1);
}

void main()
{
	vec3 normal = normalize(fs_in.normal);
	vec3 tangent = normalize(fs_in.tangent.xyz);
	vec3 bitangent = cross(tangent, normal) * fs_in.tangent.w;

	float angle_a = (light_angle_a) * 2 * 3.1415;
	float angle_b = (light_angle_b) * 2 * 3.1415;
	vec3 light_dir = vec3(cos(angle_b) * sin(angle_a), cos(angle_b) * cos(angle_a), sin(angle_b));

	vec3 snorm = texture(normal_texture, vec2(fs_in.uv.x, -fs_in.uv.y)).xyz;
	snorm -= vec3(0.5);
	snorm *= vec3(8 * bump_depth, 8 * bump_depth, 2);
	if (bump) {
		normal += (snorm.z * normal) + (snorm.y * tangent) + (snorm.x * bitangent);
	}
	normal = normalize(normal);

	color = shade(normal, tangent, bitangent, light_color, light_dir, light_intensity);
}
