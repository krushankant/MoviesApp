//
//  URL+ImageURLCreator.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation

// Image poster size
enum ImageSize {
    case w92
    case ​w185
    case ​w500
    case w780
    
    func string() -> String {
        switch self {
        case .w92:
            return "/w92"
        case .​w185:
            return "/w185"
        case .​w500:
            return "/w500"
        case .w780:
            return "/w780"
        }
    }
}

extension URL {
    static private let baseURL = URL(string: Domain.assest)!
    static func getMoviePosterURL(fromPath path: String, size: ImageSize) -> URL {
        var url = baseURL.appendingPathComponent(size.string())
        url = url.appendingPathComponent(path)
        return url
    }
}
