const float rotationSpeed = 1.0;
const float particleDensity = 400.;

const float PI = 3.14159;

vec2 rotateUV(vec2 uv, float angle) {
    return vec2(
        uv.x * cos(angle) - uv.y * sin(angle),
        uv.x * sin(angle) + uv.y * cos(angle)
    );
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord / iResolution.y - vec2(1. - iResolution.y / iResolution.x, 0);
    vec2 center = vec2(0.5);
    float dist = length(uv - center);

    float distanceFormula = -sin(dist * particleDensity * PI);
    float size = ceil(dist * particleDensity);
    float rotationAngle = (91029.21029 - iTime * rotationSpeed) * (1.0 + sin(size * 0.91) / 2.0) / 2.0;
    vec2 relative = rotateUV(uv - center, rotationAngle);

    float angle = atan(relative.x, relative.y);
    float t = pow(sin((PI - angle) / 4.0), 300.0);
    float mask = clamp(pow(1.4 - dist, 20.0), 0.0, 1.0);

    fragColor = vec4(t * distanceFormula * mask);

    vec4 terminalColor = texture(iChannel0, q);
    fragColor = mix(fragColor, terminalColor, step(0.05, length(terminalColor.rgb)));
}
