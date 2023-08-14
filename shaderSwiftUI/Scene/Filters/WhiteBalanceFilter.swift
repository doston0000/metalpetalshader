//
//  WhiteBalanceFilter.swift
//  shaderSwiftUI
//
//  Created by Doston Mirsamukov on 8/14/23.
//
import MetalPetal

final class WhiteBalanceFilter: MTIUnaryImageRenderingFilter {
  var temperature: Float = 0
  var hue: Float = 0

  override var parameters: [String : Any] {
    return ["temperature": temperature, "hue": hue]
  }
  override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
    return MTIFunctionDescriptor(name: "metalpetal::whitebalance::whiteBalance", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
  }
}
