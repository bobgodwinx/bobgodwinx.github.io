//
//  ImageEndpoint.swift
//  Places
//
//  Created by Bob Godwin Obi on 28.01.21.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

struct ImageEndpoint {
    let id: Int
    let baseString: String
    let path: String
    let method: HTTPMethod
    
    init(_ id: Int, _ baseString: String, _ path: String, method: HTTPMethod = .get) {
        self.id = id
        self.baseString = baseString
        self.path = path
        self.method = method
    }
    
    static func makeRequest(_ endpoint: ImageEndpoint) -> URLRequest {
        let fullPath = "\(endpoint.baseString)/Images/\(String(endpoint.id))/\(endpoint.path)"
        let url = URL(string: fullPath).unwrap()
        return URLRequest(url: url)
    }
}
