//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import XCTest
@testable import MovieApp

class MovieAppTests: XCTestCase {
    
    var movie: Movie?
    
    // Create dummies Movie Data
    let id = 337404
    let title = "Cruella"
    let overview = "In 1970s London amidst the punk rock revolution, a young grifter named Estella is determined to make a name for herself with her designs. She befriends a pair of young thieves who appreciate her appetite for mischief, and together they are able to build a life for themselves on the London streets. One day, Estella’s flair for fashion catches the eye of the Baroness von Hellman, a fashion legend who is devastatingly chic and terrifyingly haute. But their relationship sets in motion a course of events and revelations that will cause Estella to embrace her wicked side and become the raucous, fashionable and revenge-bent Cruella."
    let posterPath = "/rTh4K5uw9HypmpGslcKd4QfHl93.jpg"
    let release_Date = "2021-05-26"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        movie = Movie()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //To verify Movie Model
    func testMovieModelInit() {
        // Initialize Movie
        movie = Movie(id: id, title: title, overview: overview, posterPath: posterPath, release_Date: release_Date)
        
        // Verify Movie init successful
        XCTAssertNotNil(movie)
    }
}
