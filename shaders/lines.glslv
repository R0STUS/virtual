layout (location = 0) in vec3 a_position;
layout (location = 1) in vec4 a_color;

out vec4 v_color;

uniform mat4 u_projview;

void main(){
    v_color = a_color;
    v_color.rgb += vec3(0.0, 0.0, 1.0);
    gl_Position = u_projview * vec4(a_position, 1.0);
}
