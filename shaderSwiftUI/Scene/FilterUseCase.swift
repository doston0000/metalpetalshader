//
//  FilterUseCase.swift
//  shaderSwiftUI
//
//  Created by Doston Mirsamukov on 8/14/23.
//
import Foundation

protocol FilterUseCase {
  func applySaturationFilter(to image: ImageEntity, with saturation: SaturationEntity) -> ImageEntity
}

struct DefaultFilterUseCase: FilterUseCase {
  func applySaturationFilter(to image: ImageEntity, with saturation: SaturationEntity) -> ImageEntity {
    let filter = SaturationFilter()
    filter.saturation = saturation.value
    filter.inputImage = image.mtiImage
    if let filteredImage = filter.outputImage {
      return ImageEntity(mtiImage: filteredImage)
    }
    return image
  }
}
