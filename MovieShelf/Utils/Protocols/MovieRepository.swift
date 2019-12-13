//
//  MovieRepository.swift
//  MovieShelf
//
//  Created by Levy Cristian on 13/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation


protocol MovieRemoteDataSource {
    static func getTopMovies(page: Int, completion: @escaping (Result<[Movie], Errors>) -> (Void))
}

public struct MovieRepository: MovieRemoteDataSource {
    
    public init() {}
    
    static func getTopMovies(page: Int, completion: @escaping (Result<[Movie], Errors>) -> (Void)) {
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
   
}
