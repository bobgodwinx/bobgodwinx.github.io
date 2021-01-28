//
//  DataAPIService.swift
//  Places
//
//  Created by Bob Godwin Obi on 28.01.21.
//

import Foundation
import Combine

protocol DataServiceUseCase {
    func fetchLocations() -> AnyPublisher<[Location], APIError>
    func fetchTips() -> AnyPublisher<[Tip], APIError>
}

struct DataAPIService {
    
    private let decoder = JSONDecoder()
    
    private func request<T: Decodable>(with query: URLRequest) -> AnyPublisher<T, APIError> {
        ///Add implementation
    }
    
    
    private func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
        Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { .JSONDecoding($0) }
            .eraseToAnyPublisher()
    }
}

extension DataAPIService: DataServiceUseCase {
    func fetchTips() -> AnyPublisher<[Tip], APIError> {
        request(with: URLRequest(endpoint: .tips))
    }
    
    func fetchLocations() -> AnyPublisher<[Location], APIError> {
        request(with: URLRequest(endpoint: .location))
    }
}

extension URLRequest {
    init(endpoint: Endpoint, method: HTTPMethod = .get) {
        let str = endpoint.rawValue
        let url = URL(string: str).unwrap()
        self.init(url: url)
        self.httpMethod = method.rawValue
    }
}

