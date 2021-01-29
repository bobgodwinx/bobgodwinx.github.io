//
//  ImageAPIService.swift
//  Places
//
//  Created by Bob Godwin Obi on 28.01.21.
//

import Foundation
import Combine

#if os(iOS)
    import UIKit.UIImage
    typealias PLImage = UIImage
#elseif os(macOS)
    import AppKit.NSImage
    typealias PLImage = NSImage
#endif

protocol ImageAPIServiceUseCase {
    func fetchImage(_ request: URLRequest) -> AnyPublisher<PLImage, APIError>
    func fetchImages(_ request: [URLRequest]) -> AnyPublisher<[PLImage], APIError>
}

struct ImageAPIService: ImageAPIServiceUseCase {
    static let shared = ImageAPIService()

    func fetchImages(_ request: [URLRequest]) -> AnyPublisher<[PLImage], APIError> {
        request
            .publisher
            .flatMap(maxPublishers: .max(1)){ self.fetchImage($0) }
            .scan([PLImage]()){ result, image in
                var _result = result
                _result.append(image)
                return _result
            }
            .eraseToAnyPublisher()
    }
    
    func fetchImage(_ request: URLRequest) -> AnyPublisher<PLImage, APIError> {
        URLSession
            .shared
            .dataTaskPublisher(for: request)
            .compactMap { $0.data }
            .compactMap { PLImage(data: $0) }
            .mapError { .image($0) }
            .eraseToAnyPublisher()
    }
}
