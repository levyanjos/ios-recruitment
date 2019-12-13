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
    
    var pushDetailsClosure: ((Movie) -> Void)?
    
    // MARK: - Variables
    private var movies: [Movie]
    
    var currentPage = 1
    
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
    
    func loadMovies(page: Int?) {
        MovieRepository.getTopMovies(page: page ?? currentPage) { (result: Result<[Movie], Errors>) -> Void in
            switch result {
            case .success(let movies):
                let newMoviews = movies.map { MovieCellViewModel(movie: $0)}
                self.moviesCellViewModels.append(contentsOf: newMoviews)
                self.movies.append(contentsOf: movies)
            case .failure(let error):
                self.errorLoadingDataClosure?(error)
            }
        }
        
    }
    
    func cellWasTapped(atPosition position: Int) {
        let movie = self.movies[position]
        pushDetailsClosure?(movie)
    }
}