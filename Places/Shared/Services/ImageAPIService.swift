//
//  ImageAPIService.swift
//  Places
//
//  Created by Bob Godwin Obi on 28.01.21.
//

import Foundation
import Combine
import UIKit.UIImage


protocol ImageAPIServiceUseCase {
    func fetchImage(_ request: URLRequest) -> AnyPublisher<UIImage, APIError>
    func fetchImages(_ request: [URLRequest]) -> AnyPublisher<[UIImage], APIError>
}


struct ImageAPIService: ImageAPIServiceUseCase {
    static let shared = ImageAPIService()

    func fetchImages(_ request: [URLRequest]) -> AnyPublisher<[UIImage], APIError> {
        request
            .publisher
            .flatMap(maxPublishers: .max(1)){ self.fetchImage($0) }
            .scan([UIImage]()){ result, image in
                var _result = result
                _result.append(image)
                return _result
            }
            .eraseToAnyPublisher()
    }
    
    func fetchImage(_ request: URLRequest) -> AnyPublisher<UIImage, APIError> {
        URLSession
            .shared
            .dataTaskPublisher(for: request)
            .compactMap { $0.data }
            .compactMap { UIImage(data: $0) }
            .mapError { .image($0) }
            .eraseToAnyPublisher()
    }
}
