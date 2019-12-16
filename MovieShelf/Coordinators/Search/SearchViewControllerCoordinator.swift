//
//  SearchViewControllerCoordinator.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class SearchViewControllerCoordinator: Coordinator {
    
    let presenter: UINavigationController
    let viewController: SearchViewController
    var coordinatorDetails: MovieDetailsViewCoodinator?
    /**
        Coordinato initilizator
        - parameter presenter: The root application UINavigationController
    */
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.viewController = SearchViewController()
        self.viewController.viewModel.pushDetailsClosure = {[weak self] movie in
            self?.coordinatorDetails = MovieDetailsViewCoodinator(presenter: presenter, movie: movie)
            self?.coordinatorDetails?.start()
        }
    }
    
    func start() {
        self.viewController.title = "Search"
        self.presenter.navigationBar.barTintColor = UIColor.orange
        self.presenter.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.presenter.navigationBar.tintColor = .white
        self.presenter.pushViewController(viewController, animated: true)
    }
}
