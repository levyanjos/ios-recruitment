//
//  MovieCellViewModel.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class MovieCellViewModel {
    
    // MARK: - TypeAlias
    //typealias ImageBindingClosure = (UIImage?) -> Void
    
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }

    var name: String {
        return movie.title
    }
    
    var image: UIImage? {
        return movie.image
    }
    
}
