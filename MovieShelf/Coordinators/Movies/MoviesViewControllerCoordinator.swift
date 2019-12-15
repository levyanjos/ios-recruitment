//
//  MoviesViewControllerCoordinator.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class MoviesViewControllerCoordinator: Coordinator {
    
    let presenter: UINavigationController
    let viewController: MoviesViewController
    var coordinatorDetails: MovieDetailsViewCoodinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.viewController = MoviesViewController()
        self.viewController.viewModel.pushDetailsClosure = { [weak self] (movie) in
            self?.coordinatorDetails = MovieDetailsViewCoodinator(presenter: presenter, movie: movie)
            self?.coordinatorDetails?.start()
        }
    }
    
    func start() {
        viewController.title = "Movies"
        viewController.navigationItem.title = "Movies"
        presenter.navigationBar.barTintColor = UIColor.orange
        presenter.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        presenter.navigationBar.tintColor = .white
        self.presenter.pushViewController(viewController, animated: true)
    }
}

extension MoviesViewControllerCoordinator: AddDelegate {
    
    func add() {
        //vai pra tela de detail, instancia tela e da push :D
    }
    
}
