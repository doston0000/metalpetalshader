//
//  whiteBalance.metal
//  shaderSwiftUI
//
//  Created by Doston Mirsamukov on 8/14/23.
//
#include "MTIShaderLib.h"
#include <metal_stdlib>

using namespace metal;
using namespace metalpetal;

namespace metalpetal {
  namespace saturation {
    fragment float4 saturationAdjustment(VertexOut vertexIn [[stage_in]],
                                         texture2d<float, access::sample> sourceTexture [[texture(0)]],
                                         constant float &saturation [[buffer(0)]])
    {
      constexpr sampler quadSampler;
      float4 color = sourceTexture.sample(quadSampler, vertexIn.textureCoordinate);
      float gray = dot(color.rgb, float3(0.299, 0.587, 0.114));
      float3 adjustedColor = mix(float3(gray), color.rgb, saturation);
      return float4(adjustedColor, color.a);
    }
  }
  // MARK: below is one more shader for test task 
  namespace whitebalance {
    fragment float4 whiteBalance(VertexOut vertexIn [[stage_in]],
                                 texture2d<float, access::sample> sourceTexture [[texture(0)]],
                                 constant float &temperature [[buffer(0)]],
                                 constant float &hue [[buffer(1)]])
    {
      float3 warmFilter = float3(0.93, 0.54, 0.0);
      float3x3 RGBtoYIQ = float3x3(float3(0.299, 0.587, 0.114), float3(0.596, -0.274, -0.322), float3(0.212, -0.523, 0.311));
      float3x3 YIQtoRGB = float3x3(float3(1.0, 0.956, 0.621), float3(1.0, -0.272, -0.647), float3(1.0, -1.105, 1.702));
      constexpr sampler quadSampler;
      float4 color = sourceTexture.sample(quadSampler, vertexIn.textureCoordinate);
      float3 yiq = RGBtoYIQ * color.rgb;
      yiq.b = clamp(yiq.b + hue*0.5226*0.1, -0.5226, 0.5226);
      float3 rgb = YIQtoRGB * yiq;
      float3 processed = float3(
                                (rgb.r < 0.5 ? (2.0 * rgb.r * warmFilter.r) : (1.0 - 2.0 * (1.0 - rgb.r) * (1.0 - warmFilter.r))),
                                (rgb.g < 0.5 ? (2.0 * rgb.g * warmFilter.g) : (1.0 - 2.0 * (1.0 - rgb.g) * (1.0 - warmFilter.g))),
                                (rgb.b < 0.5 ? (2.0 * rgb.b * warmFilter.b) : (1.0 - 2.0 * (1.0 - rgb.b) * (1.0 - warmFilter.b))));
      return float4(mix(rgb, processed, temperature), color.a);
    }
  }
}
