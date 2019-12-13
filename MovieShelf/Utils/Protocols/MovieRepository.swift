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
                             completion: @escaping (Result<[Movie], Errors>) -> Void)
    
    static func downloadImage(postSize: TMDBApi.PosterSize,
                              posterPath: String,
                              completion: @escaping (Result<UIImage?, Error>) -> Void)
}

public struct MovieRepository: MovieRemoteDataSource {
    
    private init() {}
    
    static func getTopMovies(page: Int, completion: @escaping (Result<[Movie], Errors>) -> Void) {
        let request = Request<TMDBApi>()
        request.run(TMDBApi.popularMovies(languege: .pt, page: page)) { (result: Result<TopMovies, Errors>) in
            switch result {
            case .success(let topMovies):
                return completion(.success(topMovies.results))
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
    
}
