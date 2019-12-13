//
//  MovieDetailsViewCoordinator.swift
//  MovieShelf
//
//  Created by Levy Cristian on 13/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class MovieDetailsViewCoodinator: Coordinator {
    let presenter: UINavigationController
    let viewController: MovieDetailsViewController
    
    init(presenter: UINavigationController, movie: Movie) {
        self.presenter = presenter
        viewController = MovieDetailsViewController(viewModel: MovieDetailsViewModel(movie: movie))
        
    }
    
    func start() {
        self.presenter.pushViewController(viewController, animated: true)
    }
    
}
