//
//  FilterView.swift
//  shaderSwiftUI
//
//  Created by Doston Mirsamukov on 8/14/23.
//
import Foundation
import SwiftUI
import MetalPetal

struct FilterView: View {
  @StateObject private var viewModel = FilterViewModel()

  var body: some View {
    Group {
      if let filteredMTIImage = viewModel.filteredMTIImage {
        Image(cgImage: filteredMTIImage)
          .resizable()
          .aspectRatio(contentMode: .fit)
        VStack(alignment: .leading) {
          Text("Intensity \(viewModel.saturation, specifier: "%.2f")")
            .foregroundStyle(.black)
          Slider(value: $viewModel.saturation, in: 0...100)
        }
        .padding()
      } else {
        Text("Failed to apply filter")
      }
    }
  }
}
