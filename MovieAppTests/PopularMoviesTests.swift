//
//  PopularMoviesTests.swift
//  MovieAppTests
//
//  Created by krushankant on 6/10/21.
//  Copyright © 2022 Patel. All rights reserved.
//

import XCTest
@testable import MovieApp

class PopularMoviesTests: XCTestCase {

    var popularMovieModal: PopularMoviesViewModel?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        popularMovieModal = PopularMoviesViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // To get the Popular Movies From API Successfully Returns List of Popular Movies
    func testfetchPopularMoviesSuccessReturnsMovies() {
        
        var state = MovieListState()
        state.update(page: Pagenation.default)
        var moviesResponse: [Movie]?
        let moviesExpectation = expectation(description: "movies")
        popularMovieModal?.fetch(at: state.page.currentPage) { (movies) in
            moviesResponse = movies
            XCTAssertNotNil(movies);
            moviesExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNotNil(moviesResponse)
            XCTAssertNil(error)
            XCTAssertTrue(true)
        }
    }
    
    // To get the Popular Movies From API With error, Returns API moviesResponse response empty
    func testfetchPopularMoviesSuccessReturnsError() {
        //let vieModal = PopularMoviesViewModel()
        var moviesResponse: [Movie]?
        popularMovieModal?.fetch(at: -1) { (movies) in
            moviesResponse = movies
            XCTAssertNil(moviesResponse)
        }
    }
}
