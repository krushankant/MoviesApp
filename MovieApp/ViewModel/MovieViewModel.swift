//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation

enum MovieListError {
    case connectionError(Error)
    case mappingFailed
    case reloadFailed
}

struct MovieListState {
    fileprivate(set) var movies: [Movie] = []
    fileprivate(set) var page = Pagenation(current: 1, total: 1)
    fileprivate(set) var fetching = false
}

extension MovieListState {
    
    enum Change {
        case none
        case fetchStateChanged
        case error(MovieListError)
        case moviesChanged(CollectionChange)
    }
    
    mutating func setFetching(fetching: Bool) -> Change {
        self.fetching = fetching
        return .fetchStateChanged
    }
    
    mutating func reload(movies: [Movie]) -> Change {
        self.movies = movies
        return .moviesChanged(.reload)
    }
    
    mutating func insert(movies: [Movie]) -> Change {
        let index = self.movies.count
        self.movies.append(contentsOf: movies)
        let range = IndexSet(integersIn: index..<self.movies.count)
        return .moviesChanged(.insertion(range))
    }
    
    mutating func update(page: Pagenation) {
        self.page = page
    }
}

protocol MovieViewModel {
    
    var state: MovieListState { get}
    var onChange: ((MovieListState.Change) -> Void)? { get set }
    
    func reloadMovies()
    func loadMoreMovies()
    
}
