//
//  SearchResponse.swift
//  TopMovies
//
//  Created by Никита on 13.04.2021.
//

import Foundation

// MARK: - ResponeTopMovies
struct SearchResponse: Codable {
    let results: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
    let overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}


