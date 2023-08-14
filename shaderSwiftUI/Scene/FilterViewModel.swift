//
//  FilterViewModel.swift
//  shaderSwiftUI
//
//  Created by Doston Mirsamukov on 8/14/23.
//
import Foundation
import MetalPetal

final class FilterViewModel: ObservableObject {
  private var renderContext = try! MTIContext(device: MTLCreateSystemDefaultDevice()!)
  private let filterUseCase: FilterUseCase
  private let defaultImg = DefaultImageRepository().loadImage()
  @Published var filteredMTIImage: CGImage?
  @Published var saturation: Float = 0.0 {
    didSet {
      applyFilter()
    }
  }
  
  init(filterUseCase: FilterUseCase = DefaultFilterUseCase()) {
    self.filterUseCase = filterUseCase
    applyFilter()
  }
  
  func applyFilter() {
    let inputImage = defaultImg
    let saturationEntity = SaturationEntity(value: saturation/40.0)
    let mtiImg = filterUseCase.applySaturationFilter(to: inputImage, with: saturationEntity).mtiImage
    do {
      let cgImage = try renderContext.makeCGImage(from: mtiImg)
      filteredMTIImage = cgImage
    } catch {
      print("Error rendering image: \(error)")
      filteredMTIImage = nil
    }
  }
}
