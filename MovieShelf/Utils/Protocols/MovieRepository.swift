//
//  MovieRepository.swift
//  MovieShelf
//
//  Created by Levy Cristian on 13/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit
/**
 Repository pattern protocol where contains every data manipulation information case to be implemented
*/
protocol MovieRemoteDataSource {
    static func getTopMovies(page: Int,
                             completion: @escaping (Result<TopMovies, Errors>) -> Void)
    
    static func downloadImage(postSize: TMDBApi.PosterSize,
                              posterPath: String,
                              completion: @escaping (Result<UIImage?, Error>) -> Void)
    
    static func getRecommendations(movieID: Int,
                                   page: Int,
                                   completion: @escaping (Result<TopMovies, Errors>) -> Void)
    
    static func searchForMoviesBy(querry: String,
                                  page: Int,
                                  completion: @escaping (Result<TopMovies, Errors>) -> Void)
}

/**
 Repository struct implementation where contains every data manipulation fom Remote our local
*/
public struct MovieRepository: MovieRemoteDataSource {
    
    private init() {}
    /**
        Get popular movies from API
        - parameter Page: A specific page for api request
        - parameter Completion: A completion of `Result<TopMovies, Errors>` that sould be implemented
    */
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
    /**
        Download a image from a specific movie
        - parameter PostSize: The downloded image size
        - parameter PosterPath: The movie image path from API
        - parameter Completion: A completion of `Result<UIImage, Errors>` that sould be implemented to recive the current image
    */
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
    /**
        Get movies recommendation from an specific movie
        - parameter movieID: iD of a specific movie
        - parameter Page: A specific page for api request
        - parameter Completion: A completion of `Result<TopMovies, Errors>` that sould be implemented
     */
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
    /**
        Search for movies in API
       - parameter querry: User input querry for movie match
       - parameter Page: A specific page for api request
       - parameter Completion: A completion of `Result<TopMovies, Errors>` that sould be implemented
    */
    static func searchForMoviesBy(querry: String,
                                  page: Int,
                                  completion: @escaping (Result<TopMovies, Errors>) -> Void) {
        let request = Request<TMDBApi>()
        request.run(TMDBApi.searchMovieBy(querry: querry, language: .pt, page: page)) { (result: Result<TopMovies, Errors>) in
            switch result {
            case .success(let topMovies):
                completion(.success(topMovies))
            case .failure(let error):
                completion(.failure(error))

            }
        }
    }
}
