//
//  Movie.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    // Movie Property
    var id: Int?
    var title: String?
    var posterPath: String?
    var overview: String?
    var release_date: String?
    var originalTitle: String?
    var originalLanguage: String?
    var genreIDs: [Int]?
    var backdropPath: String?
    var popularity: Double?
    var voteCount: Int?
    var voteAverage: Double?
    var isAdult: Bool?
    var isVideo: Bool?
    
    init(id: Int? = nil, title: String? = nil, overview: String? = nil, posterPath: String? = nil, release_Date: String? = nil) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.release_date = release_Date
    }
    
    // MARK: Codable Protocol
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case release_date = "release_date"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case genreIDs = "genre_ids"
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case isVideo = "video"
        case isAdult = "adult"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        title = try? container.decode(String.self, forKey: .title)
        posterPath = try? container.decode(String.self, forKey: .posterPath)
        overview = try? container.decode(String.self, forKey: .overview)
        release_date = try? container.decode(String.self, forKey: .release_date)
        originalTitle = try? container.decode(String.self, forKey: .originalTitle)
        originalLanguage = try? container.decode(String.self, forKey: .originalLanguage)
        genreIDs = try? container.decode([Int].self, forKey: .genreIDs)
        backdropPath = try? container.decode(String.self, forKey: .originalLanguage)
        popularity = try? container.decode(Double.self, forKey: .popularity)
        voteCount = try? container.decode(Int.self, forKey: .voteCount)
        voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
        isAdult = try? container.decode(Bool.self, forKey: .isAdult)
        isVideo = try? container.decode(Bool.self, forKey: .isVideo)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id, forKey: .id)
        try? container.encode(title, forKey: .title)
        try? container.encode(posterPath, forKey: .posterPath)
        try? container.encode(overview, forKey: .overview)
        try? container.encode(release_date, forKey: .release_date)
        try? container.encode(originalTitle, forKey: .originalTitle)
        try? container.encode(originalLanguage, forKey: .originalLanguage)
        try? container.encode(genreIDs, forKey: .genreIDs)
        try? container.encode(backdropPath, forKey: .backdropPath)
        try? container.encode(popularity, forKey: .popularity)
        try? container.encode(voteCount, forKey: .voteCount)
        try? container.encode(voteAverage, forKey: .voteAverage)
        try? container.encode(isVideo, forKey: .isVideo)
        try? container.encode(isAdult, forKey: .isAdult)
    }
}

extension Movie: ViewBindable {
    
    func getTitle() -> String {
        guard let title = title else {
            return ""
        }
        return title
    }
    
    func getSubtitle() -> String {
        guard let date = release_date else {
            return ""
        }
        return date
    }
    
    func getImageURL() -> URL? {
        guard let path = posterPath else {
            return nil
        }
        return URL.getMoviePosterURL(fromPath: path, size: .​w185)
    }
    
    func getSubText() -> String? {
        return overview
    }
}

extension Movie: Equatable {
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id // For now id comparision is enough
    }
}
