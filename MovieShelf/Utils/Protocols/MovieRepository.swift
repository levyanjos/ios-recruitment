//
//  MovieRepository.swift
//  MovieShelf
//
//  Created by Levy Cristian on 13/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

protocol MovieRemoteDataSource {
    static func getTopMovies(page: Int,
                             completion: @escaping (Result<TopMovies, Errors>) -> Void)
    
    static func downloadImage(postSize: TMDBApi.PosterSize,
                              posterPath: String,
                              completion: @escaping (Result<UIImage?, Error>) -> Void)
    
    static func getRecommendations(movieID: Int,
                                   page: Int,
                                   completion: @escaping (Result<TopMovies, Errors>) -> Void)
}

public struct MovieRepository: MovieRemoteDataSource {
    
    private init() {}
    
    static func getTopMovies(page: Int, completion: @escaping (Result<TopMovies, Errors>) -> Void) {
        let request = Request<TMDBApi>()
        request.run(TMDBApi.popularMovies(language: .pt, page: page)) { (result: Result<TopMovies, Errors>) in
            switch result {
            case .success(let topMovies):
                return completion(.success(topMovies))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    static func downloadImage(postSize: TMDBApi.PosterSize,
                              posterPath: String,
                              completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let request = Request<TMDBApi>()
        request.run(TMDBApi.posterImage(posterSize: postSize, posterPath: posterPath)) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                completion(.success(UIImage(data: data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getRecommendations(movieID: Int,
                                   page: Int,
                                   completion: @escaping (Result<TopMovies, Errors>) -> Void) {
        let request = Request<TMDBApi>()
        request.run(TMDBApi.recommendations(movieID: movieID, page: page, language: .pt)) { (result: Result<TopMovies, Errors>) in
            switch result {
            case .success(let movies):
                return completion(.success(movies))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}
