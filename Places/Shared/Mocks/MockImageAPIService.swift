//
//  MockImageAPIService.swift
//  Places
//
//  Created by Bob Godwin Obi on 28.01.21.
//


import Foundation
import Combine
import SwiftUI

struct MockImageAPIService: ImageAPIServiceUseCase {
    
    let fetchImageSub = PassthroughSubject<PLImage, APIError>()
    let fetchImagesSub = PassthroughSubject<[PLImage], APIError>()
    
    func fetchImages(_ request: [URLRequest]) -> AnyPublisher<[PLImage], APIError> {
        fetchImagesSub.eraseToAnyPublisher()
    }
    
    func fetchImage(_ request: URLRequest) -> AnyPublisher<PLImage, APIError> {
        fetchImageSub.eraseToAnyPublisher()
    }
}

