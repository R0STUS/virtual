in vec4 a_color;
in vec2 a_texCoord;
in float a_distance;
in vec3 a_dir;
out vec4 f_color;
in vec3 ve_position;
in float ve_light;
in vec3 v_mpos;

uniform sampler2D u_texture0;
uniform samplerCube u_cubemap;
uniform vec3 u_fogColor;
uniform vec3 u_cameraPos;
uniform float u_fogFactor;
uniform float u_fogCurve;
uniform float u_timer;

void main() {
    vec3 fogColor = texture(u_cubemap, a_dir).rgb;
    vec4 tex_color = texture(u_texture0, a_texCoord);
    float depth = (a_distance/256.0);
    float alpha = a_color.a * tex_color.a;
    // anyway it's any alpha-test alternative required
    if (alpha < 0.3f)
        discard;
    float time = abs(sin(u_timer)) * 0.8;
    if (a_distance < 16) {
        f_color = texture(u_texture0, a_texCoord);
        vec4 cybercol = vec4(0.0, 0.0, 0.0, 0.0);
        alpha = 0;
        if ((int(ve_position.x * 16) % 16 == 0) || (int(ve_position.z * 16) % 16 == 0) || (int(ve_position.y * 16) % 16 == 0)) {
            cybercol = vec4(0.0, 0.5, 0.75, 0.5);
            alpha = 0.5;
        }
        f_color = mix(cybercol, f_color, sin((15 - a_distance) * 0.1));
        alpha = f_color.a;
    }
    else if ((int(ve_position.x * 16) % 16 == 0) || (int(ve_position.z * 16) % 16 == 0) || (int(ve_position.y * 16) % 16 == 0)) {
        float sqr = (1 - exp(-16 * time)) * time;
        f_color = vec4(0.0, 0.5, 0.75, 0.75);
        alpha = 0.5;
    }
    else {
        f_color = vec4(0.0, 0.0, 0.0, 0.0);
        alpha = 0;
    }
    f_color.a -= 0.1;
    f_color.a = alpha;
}
