//
//  MovieDetailsViewCoordinator.swift
//  MovieShelf
//
//  Created by Levy Cristian on 13/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit
/**
    Movie Details Coordinator
*/
class MovieDetailsViewCoodinator: Coordinator {
    let presenter: UINavigationController
    let viewController: MovieDetailsViewController
    var coordinatorDetails: MovieDetailsViewCoodinator?
    
    /**
     Coordinato initilizator
    - parameter presenter: The root application UINavigationController
    - parameter Movie: A specifc movie to be presented in ViewController
    */
    init(presenter: UINavigationController, movie: Movie) {
        self.presenter = presenter
        viewController = MovieDetailsViewController(viewModel: MovieDetailsViewModel(movie: movie))
        viewController.title = movie.title
        viewController.navigationItem.title = movie.title
        viewController.viewModel.pushDetailsClouser = { [weak self] movie in
            self?.coordinatorDetails = MovieDetailsViewCoodinator(presenter: presenter, movie: movie)
            self?.coordinatorDetails?.start()
        }
    }
    
    func start() {
        self.presenter.pushViewController(viewController, animated: true)
    }
    
}
