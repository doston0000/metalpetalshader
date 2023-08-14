//
//  SaturationFilter.swift
//  shaderSwiftUI
//
//  Created by Doston Mirsamukov on 8/14/23.
//
import MetalPetal

final class SaturationFilter: MTIUnaryImageRenderingFilter {
  var saturation: Float = 1

  override var parameters: [String : Any] {
    return ["saturation": saturation]
  }
  override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
    return MTIFunctionDescriptor(name: "metalpetal::saturation::saturationAdjustment", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
  }
}

