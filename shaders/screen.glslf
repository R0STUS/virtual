in vec2 v_coord;
out vec4 f_color;

uniform sampler2D u_texture0;
uniform ivec2 u_screenSize;
uniform float u_timer;
uniform vec3 u_cameraPos;

// Saturation
vec3 apply_saturation(vec3 color) {
    float avg = (color.r+color.g+color.b)/3.0f;
    float t = 1.5f;
    color.r += (f_color.r - avg) * (t - 1.0f);
    color.g += (f_color.g - avg) * (t - 1.0f);
    color.b += (f_color.b - avg) * (t - 1.0f);
    return color;
}

float random(vec2 st){
    return fract(sin(dot(st.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

// Vignette
vec4 apply_vignette(vec4 color) {
    vec2 position = (gl_FragCoord.xy / u_screenSize) - vec2(0.5);
    float dist = length(position);

    float radius = 1.3;
    float softness = 1.0;
    float vignette = smoothstep(radius, radius - softness, dist);

    color.rgb = color.rgb * vignette;

    return color;
}

void main() {
	f_color = texture(u_texture0, v_coord);
	f_color = vec4(smoothstep(0.05, 0.95, f_color.rgb), f_color.a);
	f_color = vec4(apply_saturation(f_color.rgb), f_color.a);
    f_color.rgb += vec3(random(vec2(u_timer + v_coord.x, u_timer + v_coord.y)) * 0.01, random(vec2(u_timer + v_coord.x, v_coord.y)) * 0.05, random(vec2(u_timer + v_coord.y, v_coord.x)) * 0.1 + (u_cameraPos.x * 0.001));
	f_color = apply_vignette(f_color);
}
