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
        let request = Request<TMDBApi>()
        request.run(.posterImage(posterSize: TMDBApi.PosterSize.w92, posterPath: movie.posterPath)) { (result: Result<Data, Errors>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    imageClosure(UIImage(data: data))
                }
            case .failure(_):
                DispatchQueue.main.async {
                    imageClosure(UIImage(named: "error"))
                }
            }
        }
    }
    
}
