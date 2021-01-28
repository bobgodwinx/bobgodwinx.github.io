//
//  MockImageAPIService.swift
//  Places
//
//  Created by Bob Godwin Obi on 28.01.21.
//


import Foundation
import Combine
import UIKit.UIImage
import SwiftUI

struct MockImageAPIService: ImageAPIServiceUseCase {
    
    let fetchImageSub = PassthroughSubject<UIImage, APIError>()
    let fetchImagesSub = PassthroughSubject<[UIImage], APIError>()
    
    func fetchImages(_ request: [URLRequest]) -> AnyPublisher<[UIImage], APIError> {
        fetchImagesSub.eraseToAnyPublisher()
    }
    
    func fetchImage(_ request: URLRequest) -> AnyPublisher<UIImage, APIError> {
        fetchImageSub.eraseToAnyPublisher()
    }
}

