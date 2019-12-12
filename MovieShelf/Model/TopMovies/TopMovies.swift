//
//  TopMovies.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

// MARK: - TopMovies
struct TopMovies: Codable {
    let page, totalResults, totalPages: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let posterPath: String
    let id: Int
    let title: String
    let overview: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case title
        case overview
    }
}
