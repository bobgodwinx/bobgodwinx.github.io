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
    
    func test_allLocationsPublisher_error_while_decoding() throws {
        /// Given
        var completion: Subscribers.Completion<APIError>?
        let decodingError = APIError.JSONDecoding("Some corrupt data")
        let expected = MockDataAPIService.makeLocations()
        /// When
        mock.fetchLocationsSub.send(expected)
        mock.fetchLocationsSub.send(completion: .failure(decodingError))
        /// Then
        sut.allLocationsPublisher
            .sink (receiveCompletion: { completion = $0 },
                   receiveValue: { _ in  })
            .store(in: &bag)

        XCTAssertNotNil(completion)
        XCTAssertEqual(completion.unwrap().error, decodingError)
    }
    
    func test_allLocationsPublisher_had_a_server_error() throws {
        /// Given
        var completion: Subscribers.Completion<APIError>?
        let nserror = NSError(domain: "Could not reach the server bo", code: 404, userInfo: nil)
        let serverError = APIError.server(nserror)
        let expected = MockDataAPIService.makeLocations()
        /// When
        mock.fetchLocationsSub.send(expected)
        mock.fetchLocationsSub.send(completion: .failure(serverError))
        /// Then
        sut.allLocationsPublisher
            .sink (receiveCompletion: { completion = $0 },
                   receiveValue: { _ in  })
            .store(in: &bag)

        XCTAssertNotNil(completion)
        XCTAssertEqual(completion.unwrap().error, serverError)
    }

}


/// Unit Test Helpers
extension String: Error { }

extension APIError: Equatable {
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.JSONDecoding, .JSONDecoding): return true
        case (.network, .network): return true
        case (.server, .server): return true
        case (.image, .image): return true
        case (.never, .never): return true
        default: return false
        }
    }
}

extension Subscribers.Completion {
    var error: Failure? {
        switch self {
        case .finished: return nil
        case let .failure(error): return error
        }
    }
}
