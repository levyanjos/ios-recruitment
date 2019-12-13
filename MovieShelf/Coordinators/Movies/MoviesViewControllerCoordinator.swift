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
    let viewController: UIViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.viewController = MoviesViewController()
    }
    
    func start() {
        viewController.title = "Movies"
        viewController.navigationItem.title = "Movies"
        self.presenter.pushViewController(viewController, animated: true)
    }
}

extension MoviesViewControllerCoordinator: AddDelegate {
    
    func add() {
        //vai pra tela de detail, instancia tela e da push :D
    }
    
}
