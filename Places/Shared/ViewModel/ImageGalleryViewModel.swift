//
//  ImageGalleryViewModel.swift
//  Places
//
//  Created by Bob Godwin Obi on 29.01.21.
//

import Foundation
import Combine
import SwiftUI

class ImageGalleryViewModel: ObservableObject {
    /// Bindable properties
    @Published  private(set) var locationImages = [LocationImage]()

    private var bag = Set<AnyCancellable>()
    private var imageService: ImageAPIServiceUseCase
    private var dataService: DataServiceUseCase
    
    init(_ imageService: ImageAPIServiceUseCase, _ dataService: DataServiceUseCase)  {
        self.imageService = imageService
        self.dataService = dataService
    }

    var locationImagesPublisher: AnyPublisher<[LocationImage], APIError> {
        /// add implementation for now just empty
        Just([])
            .mapError {_ in APIError.never }
            .eraseToAnyPublisher()
    }
    
    func bind() {
        // reason for the `guard` is that we want to call this on `onAppear:`
        guard self.locationImages.isEmpty else { return }
        locationImagesPublisher
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .assign(to: \.locationImages, on: self)
            .store(in: &bag)
    }
}
