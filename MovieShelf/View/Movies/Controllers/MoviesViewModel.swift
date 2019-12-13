//
//  MoviesViewModel.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

class MoviesViewModel {
    
    // MARK: - TypeAlias
    typealias BindingClosure = () -> Void
    typealias ErrorClouser = (Error) -> Void
    
    // MARK: - Closures
    var reloadCollectionClosure: BindingClosure?
    var errorLoadingDataClosure: ErrorClouser?
    
    // MARK: - Variables
    private let movies: [Movie]
    
    var moviesCellViewModels = [MovieCellViewModel]() {
           didSet {
               self.reloadCollectionClosure?()
           }
       }
    
    var numberOfCells: Int {
        return moviesCellViewModels.count
    }
    
    // MARK: - Init & Functions
    init(movies: [Movie] = [Movie]()) {
        self.movies = movies
        
        self.moviesCellViewModels = movies.map { MovieCellViewModel(movie: $0) }
    }
    
    func loadMovies(page: Int) {
        let request = Request<TMDBApi>()
        request.run(TMDBApi.popularMovies(languege: .pt, page: page)) { (result: Result<TopMovies, Errors>) in
            switch result {
            case .success(let topMovies):
                let newMoviews = topMovies.results.map { MovieCellViewModel(movie: $0)}
                self.moviesCellViewModels.append(contentsOf: newMoviews)
            case .failure(let error):
                self.errorLoadingDataClosure?(error)
            }
        }
    }
    
}
