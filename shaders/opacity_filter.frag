#version 460 core

precision highp float;

#include <flutter/runtime_effect.glsl>

layout(location = 0) uniform float uAlphaThreshold; // Threshold for alpha value
layout(location = 1) uniform vec2 uSize;
// layout(location = 2) uniform vec4 uColor;
layout(location = 2) uniform float test;
layout(location = 3) uniform sampler2D uTexture;


out vec4 fragColor;

void main() {
  vec2 uv = FlutterFragCoord().xy / uSize;
  vec4 color = texture(uTexture, uv);
  vec3 correctedColor = color.rgb / color.a;
  fragColor = vec4(correctedColor, 1.0);
  
  // Check if the alpha value is below the threshold
  if (color.a < uAlphaThreshold) {
    discard; // Discard the fragment (makes it transparent)
  } else {
    // fragColor = color;
    fragColor = vec4(correctedColor.r, correctedColor.g, correctedColor.b, 1.0);
    // fragColor = vec4(uColor.x, uColor.y, uColor.z, 1.0);
    // fragColor = vec4(0.5, 0.0, 0.0, 1.0); // Red color
  }
}
