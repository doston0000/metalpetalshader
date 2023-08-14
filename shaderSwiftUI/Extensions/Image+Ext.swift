//
//  Image+Ext.swift
//  shaderSwiftUI
//
//  Created by Doston Mirsamukov on 8/14/23.
//
import SwiftUI

extension Image {
  init(cgImage: CGImage) {
#if os(iOS)
    self.init(uiImage: UIImage(cgImage: cgImage))
#elseif os(macOS)
    self.init(nsImage: NSImage(cgImage: cgImage, size: CGSize(width: cgImage.width, height: cgImage.height)))
#else
#error("Unsupported Platform")
#endif
  }
}
