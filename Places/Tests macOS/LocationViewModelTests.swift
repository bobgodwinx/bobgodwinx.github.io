//
//  LocationViewModelTests.swift
//  Tests macOS
//
//  Created by Bob Godwin Obi on 28.01.21.
//

import Foundation
import XCTest
import Combine
@testable import Places

class LocationsViewModelTests: XCTestCase {
    
    var sut: LocationsViewModel!
    var bag = Set<AnyCancellable>()
    let mock = MockDataAPIService()
    
    override func setUpWithError() throws {
        sut = .init(mock)
    }

    override func tearDownWithError() throws {
        sut = nil
        bag = []
    }
    
    func test_allLocationsPublisher_happy_scenario() throws {
        /// Given
        var completed = false
        let expected = MockDataAPIService.makeLocations()
        /// When
        mock.fetchLocationsSub.send(expected)
        mock.fetchLocationsSub.send(completion: .finished)
        /// Then
        sut.allLocationsPublisher
            .sink (receiveCompletion: { _ in completed = true },
                   receiveValue: {
                    XCTAssertEqual($0.count, expected.count)
                    XCTAssertEqual($0[0], expected[0])
                    XCTAssertEqual($0[1], expected[1])
                   })
            .store(in: &bag)
        XCTAssertTrue(completed)
    }

}

