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
        ///Add implementation
    }
    
    func fetchImage(_ request: URLRequest) -> AnyPublisher<UIImage, APIError> {
        ///Add implementation
    }
}
