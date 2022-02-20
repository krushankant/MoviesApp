//
//  MoviesResponse.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation

struct MoviesResponse: Codable {

    private(set) var results: [Movie]?
    private(set) var page: Int?
    private(set) var totalResults: Int?
    private(set) var totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }

}
