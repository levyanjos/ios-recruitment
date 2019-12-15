//
//  MovieDetailsViewModel.swift
//  MovieShelf
//
//  Created by Levy Cristian on 13/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class MovieDetailsViewModel {
    
    // MARK: - TypeAlias
    typealias BindingClosure = () -> Void
    typealias ErrorClouser = (Error) -> Void
    typealias MovieClouser = ((Movie) -> Void)
       
    // MARK: - Closures
    var reloadCollectionClosure: BindingClosure?
    var errorLoadingDataClosure: ErrorClouser?
    var pushDetailsClouser: MovieClouser?
    
    // MARK: - Variables
    private let movie: Movie
    private var recommendations: [Movie]
    var currentPage = 1
    var totalOfPages = 0
    
    var moviesCellViewModels = [MovieCellViewModel]() {
        didSet {
            self.reloadCollectionClosure?()
        }
    }
    
    var overview: String {
        return movie.overview
    }
    
    var image: UIImage? {
        return movie.image
    }
    
    // MARK: - Initialization & Functions
    init(movie: Movie) {
        self.movie = movie
        self.recommendations = []
    }
    
    func loadMovies(page: Int?) {
        MovieRepository.getRecommendations(movieID: movie.id, page: page ?? currentPage) { (result: Result<TopMovies, Errors>) in
            switch result {
            case .success(let movie):
                let newMoviews = movie.results.map { MovieCellViewModel(movie: $0)}
                   self.moviesCellViewModels.append(contentsOf: newMoviews)
                   self.recommendations.append(contentsOf: movie.results)
                   if self.totalOfPages == 0 {
                       self.totalOfPages = movie.totalPages
                }
            case .failure(let error):
                self.errorLoadingDataClosure?(error)
            }
        }
    }
    
    func cellWasTapped(atPosition position: Int) {
        let cellViewModel = moviesCellViewModels[position]
        var movie = recommendations[position]
        movie.image = cellViewModel.image
        pushDetailsClouser?(movie)
    }
    
}
