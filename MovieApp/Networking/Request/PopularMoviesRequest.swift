//
//  PopularMoviesRequest.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation

struct PopularMoviesRequest: MovieRequest {
    // MovieRequest protocol variables
    var path: String = "/movie/popular"
    var parameters: [String : Any] {
        return [
            "page": page
        ]
    }
    // Class variables
    private let page: Int
    
    // Initializer
    init(page: Int) {
        self.page = page
    }
}
