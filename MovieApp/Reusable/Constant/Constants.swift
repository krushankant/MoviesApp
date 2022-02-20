//
//  Constants.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation

struct Domain {
    static let dev = "https://api.themoviedb.org/3"
    static let assest = "http://image.tmdb.org/t/p"
}

struct APIEndpoint {
    static let APIKey = "432f6b5bc7d0b81a715b9d90cb64aba3"
}

extension Domain {
    static func baseUrl() -> String {
        return Domain.dev
    }
}
