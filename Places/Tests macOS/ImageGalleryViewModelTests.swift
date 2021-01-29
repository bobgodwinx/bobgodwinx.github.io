//
//  ImageGalleryViewModelTests.swift
//  Tests macOS
//
//  Created by Bob Godwin Obi on 29.01.21.
//

import Foundation
import XCTest
import Combine
@testable import Places

class ImageGalleryViewModelTests: XCTestCase {
    var sut: ImageGalleryViewModel!
    var bag = Set<AnyCancellable>()
    let mockDataService = MockDataAPIService()
    let mockImageService = MockImageAPIService()
    
    override func setUpWithError() throws {
        sut = .init(mockImageService, mockDataService)
    }

    override func tearDownWithError() throws {
        sut = nil
        bag = []
    }
    
    func test_locationImagesPublisher_did_fetchImage() throws {
        /// Given
        var completed = false
        
        /// When
        sut.locationImagesPublisher
            .sink (receiveCompletion: { _ in completed = true },
                   receiveValue: { XCTAssertEqual($0.count, 2)}) // make sure we get 2 LocalImage transformed
            .store(in: &bag)
        mockDataService.fetchLocationsSub.send(MockDataAPIService.makeLocations())
        mockImageService.fetchImagesSub.send([PLImage(), PLImage()]) //sent 2 images
        mockDataService.fetchLocationsSub.send(completion: .finished)
        mockImageService.fetchImagesSub.send(completion: .finished)
        /// Then
        XCTAssertTrue(completed)
    }
}


