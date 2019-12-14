//
//  MovieDetailsViewModel.swift
//  MovieShelf
//
//  Created by Levy Cristian on 13/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class MovieDetailsViewModel {
    
    private let movie: Movie
    
    var overview: String {
        return movie.overview
    }
    
    var image: UIImage? {
        return movie.image
    }
    
    init(movie: Movie) {
        self.movie = movie
        
    }
    
}
