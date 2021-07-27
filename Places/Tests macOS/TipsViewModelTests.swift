//
//  TipsViewModelTests.swift
//  Tests macOS
//
//  Created by Bob Godwin Obi on 29.01.21.
//

import Foundation
import XCTest
import Combine
@testable import Places

class TipsViewModelTests: XCTestCase {
    
    var sut: TipsViewModel!
    var bag = Set<AnyCancellable>()
    let mock = MockDataAPIService()
    
    override func setUpWithError() throws {
        sut = .init(mock)
    }

    override func tearDownWithError() throws {
        sut = nil
        bag = []
    }
    
    func test_tipsPublisher_happy_scenario() throws {
        /// Given
        var completed = false
        let expected = MockDataAPIService.makeTips()
        /// When
        mock.fetchTipsSub.send(expected)
        mock.fetchTipsSub.send(completion: .finished)
        /// Then
        sut.tipsPublisher
            .sink (receiveCompletion: { _ in completed = true },
                   receiveValue: {
                    XCTAssertEqual($0.count, expected.count)
                    XCTAssertEqual($0[0], expected[0])
                    XCTAssertEqual($0[1], expected[1])
                   })
            .store(in: &bag)
        XCTAssertTrue(completed)
    }
    
    
    func test_tipsPublisher_error_while_decoding() throws {
        /// Given
        var completion: Subscribers.Completion<APIError>?
        let decodingError = APIError.JSONDecoding("Some corrupt data")
        let expected = MockDataAPIService.makeTips()
        /// When
        mock.fetchTipsSub.send(expected)
        mock.fetchTipsSub.send(completion: .failure(decodingError))
        /// Then
        sut.tipsPublisher
            .sink (receiveCompletion: { completion = $0 },
                   receiveValue: { _ in  })
            .store(in: &bag)

        XCTAssertNotNil(completion)
        XCTAssertEqual(completion.unwrap().error, APIError.JSONDecoding("Some corrupt data"))
    }
    
    func test_tipsPublisher_had_a_server_error() throws {
        /// Given
        var completion: Subscribers.Completion<APIError>?
        let nserror = NSError(domain: "Could not reach the server bo", code: 404, userInfo: nil)
        let serverError = APIError.server(nserror)
        let expected = MockDataAPIService.makeTips()
        /// When
        mock.fetchTipsSub.send(expected)
        mock.fetchTipsSub.send(completion: .failure(serverError))
        /// Then
        sut.tipsPublisher
            .sink (receiveCompletion: { completion = $0 },
                   receiveValue: { _ in  })
            .store(in: &bag)

        XCTAssertNotNil(completion)
        XCTAssertEqual(completion.unwrap().error, APIError.server(nserror))
    }
    
    func test_tipsPublisher_had_a_network_error() throws {
        /// Given
        var completion: Subscribers.Completion<APIError>?
        let nserror = NSError(domain: "Looks like you're offline", code: 1009, userInfo: nil)
        let serverError = APIError.network(nserror)
        let expected = MockDataAPIService.makeTips()
        /// When
        mock.fetchTipsSub.send(expected)
        mock.fetchTipsSub.send(completion: .failure(serverError))
        /// Then
        sut.tipsPublisher
            .sink (receiveCompletion: { completion = $0 },
                   receiveValue: { _ in  })
            .store(in: &bag)

        XCTAssertNotNil(completion)
        XCTAssertEqual(completion.unwrap().error, APIError.network(nserror))
        XCTAssertNotEqual(completion.unwrap().error, APIError.server(nserror))
        XCTAssertNotEqual(completion.unwrap().error, APIError.JSONDecoding(nserror))
        XCTAssertNotEqual(completion.unwrap().error, APIError.never)
    }
}
