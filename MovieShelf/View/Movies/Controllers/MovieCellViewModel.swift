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
    typealias ImageBindingClosure = (UIImage?) -> Void
   
    // MARK: - Variales
    private var movie: Movie
    var name: String {
           return movie.title
       }
       
       var image: UIImage? {
           return movie.image
       }
    
    // MARK: - init & Functions
    init(movie: Movie) {
        self.movie = movie
    }

    func downloadImage(imageClosure: @escaping ImageBindingClosure) {
        MovieRepository.downloadImage(postSize: .w154, posterPath: movie.posterPath) { (result: Result<UIImage?, Error>) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    imageClosure(image)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    imageClosure(UIImage(named: "error"))
                }
            }
        }
    }
    
}
