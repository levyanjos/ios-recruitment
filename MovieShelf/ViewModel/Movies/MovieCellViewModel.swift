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
    /**
        Funcition resposible for hang on with downlod of movie image from API
       - parameter imageClouser: The clouser that should be implemented to recive donwlodade image and set to View
    */
    func downloadImage(imageClosure: @escaping ImageBindingClosure) {
        MovieRepository.downloadImage(postSize: .w780, posterPath: movie.posterPath) { (result: Result<UIImage?, Error>) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.movie.image = image
                    imageClosure(image)
                }
            case .failure:
                DispatchQueue.main.async {
                    imageClosure(UIImage(named: "error"))
                }
            }
        }
    }
    
}
