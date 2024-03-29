//
//  MoviesViewModel.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation
/**
    Movies Flow application view model
*/
class MoviesViewModel {
    
    // MARK: - TypeAlias
    typealias BindingClosure = () -> Void
    typealias ErrorClouser = (Error) -> Void
    typealias MovieClouser = ((Movie) -> Void)
    
    // MARK: - Closures
    var reloadCollectionClosure: BindingClosure?
    var errorLoadingDataClosure: ErrorClouser?
    var pushDetailsClosure: MovieClouser?
    
    // MARK: - Variables
    private var movies: [Movie]
    
    /** the current page of api paggination request */
    var currentPage = 1
    /** the total of pages that can be requested from api */
    var totalOfPages = 0
    
    /** View Model of each cell*/
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
    /**
        Function responsible for load movies from api
        - parameter page: The page of resquest
    */
    func loadMovies(page: Int?) {
        MovieRepository.getTopMovies(page: page ?? currentPage) { (result: Result<TopMovies, Errors>) -> Void in
            switch result {
            case .success(let movie):
                let newMoviews = movie.results.map { MovieCellViewModel(movie: $0)}
                self.moviesCellViewModels.append(contentsOf: newMoviews)
                self.movies.append(contentsOf: movie.results)
                if self.totalOfPages == 0 {
                    self.totalOfPages = movie.totalPages
                }
            case .failure(let error):
                self.errorLoadingDataClosure?(error)
            }
        }
    }
    /**
        Function responsible for search movies from user input
        - parameter querry: User input
        - parameter page: The page of resquest
        - parameter erase: Boolean that tells if previous movies should be discarded
    */
    func searchMovies(by querry: String, page: Int?, erase: Bool) {
        MovieRepository.searchForMoviesBy(querry: querry, page: page ?? currentPage) { (result: Result<TopMovies, Errors>) in
            switch result {
            case .success(let movie):
                if erase {
                    self.moviesCellViewModels.removeAll()
                    self.movies.removeAll()
                }
                let newMoviews = movie.results.map { MovieCellViewModel(movie: $0) }
                self.moviesCellViewModels.append(contentsOf: newMoviews)
                self.movies.append(contentsOf: movie.results)
                if self.totalOfPages == 0 {
                    self.totalOfPages = movie.totalPages
                }
            case .failure(let error):
                self.errorLoadingDataClosure?(error)
            }
        }
    }
    /**
          Function responsible for pushing a movie to details
          - parameter position: Index of a cell into the array of cell - It can be indexPath
    */
    func cellWasTapped(atPosition position: Int) {
        let cellViewModel = self.moviesCellViewModels[position]
        var movie = self.movies[position]
        movie.image = cellViewModel.image
        pushDetailsClosure?(movie)
    }
}
