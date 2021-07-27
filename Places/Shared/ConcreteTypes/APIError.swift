//
//  APIError.swift
//  Places
//
//  Created by Bob Godwin Obi on 27.01.21.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError, CustomStringConvertible {
    case JSONDecoding(_ error: Error)
    case network(_ error: Error)
    case server(_ error: Error)
    case image(_ error: Error)
    case never
    
    var errorDescription: String? {
        switch self {
        case let .JSONDecoding(error),
             let .network(error),
             let .server(error),
             let .image(error):
            return error.localizedDescription
        case .never: return "Impossible"
        }
    }
    
    var description: String {
        switch self {
        case let .JSONDecoding(error):
        return
         """
         Error occured while parsing json object
         \(error.localizedDescription)
         """
        case let .network(error as NSError):
        return
         """
         Internet Error: \(error.code) occured while fetching data
         \(error.localizedDescription)
         """
        case let .server(error as NSError):
        return
         """
         Server Error: \(error.code) occured
         \(error.localizedDescription)
         """
        case let .image(error as NSError):
        return
            """
             Image Error: \(error.code) occured while fetching image
             \(error.localizedDescription)
            """
        case .never: return "Impossible"
        }
    }
}

extension Publisher {
  public func debug(id: String = "") -> AnyCancellable {
    return sink(receiveCompletion: { Swift.print("\(id): \($0)") },
                receiveValue: { Swift.print("\(id): output(\($0))") })
  }
}
