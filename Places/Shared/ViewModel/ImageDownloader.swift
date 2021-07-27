////
////  ImageDownloader.swift
////  Places
////
////  Created by Bob Godwin Obi on 10.06.21.
////
//
//import Foundation
//import SwiftUI
//
//enum ImageDownloaderError: Error {
//    case unwrappError
//}
//actor ImageDownloader {
//    private enum CacheEntry {
//        typealias GetImage = () async throws -> (Image?, Error?)
//        case inProgress(GetImage)
//        case ready(Image)
//    }
//    
//    private var cache: [URL: CacheEntry] = [:]
//    
//    func image(from url: URL) async throws -> Image? {
//        if let cached = cache[url] {
//            switch cached {
//            case let .ready(image):
//                return image
//            case let .inProgress(handle):
//                return try await handle().0
//            }
//        }
//        
//        cache[url] = CacheEntry.inProgress(handle)
//        
//        do {
//            if let image = try await handle().0 {
//                cache[url] = CacheEntry.ready(image)
//                return image
//            } else {
//                throw ImageDownloaderError.unwrappError
//            }
//        } catch {
//            cache[url] = nil
//            throw error
//        }
//    }
//}
//
//
// 
//func handle() async throws -> (Image?, Error?) {
//    return  (Image(systemName: "Australia"), nil)
//}
//
//
//func downloadImage(from url: URLRequest) async throws -> Image? {
//    return nil
//}
