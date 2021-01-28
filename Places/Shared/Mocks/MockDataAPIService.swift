//
//  MockDataAPIService.swift
//  Places
//
//  Created by Bob Godwin Obi on 28.01.21.
//

import Foundation
import Combine

struct MockDataAPIService: DataServiceUseCase {
    
    let fetchLocationsSub = PassthroughSubject<[Location], APIError>()
    let fetchTipsSub = PassthroughSubject<[Tip], APIError>()
    
    init() {
        print("Debug: Now using MockDataAPIService")
    }
    static func makeLocations() -> [Location] {
        let url = Bundle.main.url(forResource: "MockLocations", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode([Location].self, from: data)
    }
    
    static func makeTips() -> [Tip] {
        let url = Bundle.main.url(forResource: "MockTips", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode([Tip].self, from: data)
    }
    
    static func makeLocation() -> Location {
        Self.makeLocations()[0]
    }
    
    static func maketip() -> Tip {
        Self.makeTips()[0]
    }
    
    func fetchLocations() -> AnyPublisher<[Location], APIError> {
        fetchLocationsSub.eraseToAnyPublisher()
    }
    
    func fetchTips() -> AnyPublisher<[Tip], APIError> {
        fetchTipsSub.eraseToAnyPublisher()
    }
}
