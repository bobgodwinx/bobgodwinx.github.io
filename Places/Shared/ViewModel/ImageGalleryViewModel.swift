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
        let baseString = Endpoint.baseURLString
        return dataService
            .fetchLocations()
            .compactMap ({
                $0.map ({ location -> [URLRequest] in
                    let id = location.id
                     return location
                        .images
                        .map({ ImageEndpoint.makeRequest(ImageEndpoint(id, baseString, $0)) })
                })
            })
            .map({ $0.flatMap { $0 } })
            .flatMap(maxPublishers: .max(1)){ self.imageService.fetchImages($0) }
            .map({ $0.map(Image.init) })
            .map({$0.map(LocationImage.init)})
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
