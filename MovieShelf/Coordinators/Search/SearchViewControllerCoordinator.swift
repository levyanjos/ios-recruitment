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
    let viewController: UIViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.viewController = UIViewController()
    }
    
    func start() {
        viewController.title = "Search"
        self.presenter.pushViewController(viewController, animated: true)
    }
}