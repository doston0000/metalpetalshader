//
//  ImageRepository.swift
//  shaderSwiftUI
//
//  Created by Doston Mirsamukov on 8/14/23.
//
import Foundation
import MetalPetal

protocol ImageRepository {
  func loadImage() -> ImageEntity
}

struct DefaultImageRepository: ImageRepository {
  func loadImage() -> ImageEntity {
    let url = Bundle.main.url(forResource: "user", withExtension: "jpg")!
    return ImageEntity(mtiImage: MTIImage(contentsOf: url, isOpaque: true)!)
  }
}

