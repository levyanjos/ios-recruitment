//
//  TabBarCoordinator.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    
    //"o pai" da tela que será instanciada pela coordinator
    let window: UIWindow
    let tabBarController: UITabBarController
    var childCoordinators = [Coordinator]()
    
    init(window: UIWindow) {
        //inicializa atributos do coordinator
        self.window = window
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        //instancia tela e mostra a partir de presenter
        let moviesNavigation = UINavigationController()
        let moviesCoordinator = MoviesViewControllerCoordinator(presenter: moviesNavigation)
        moviesCoordinator.start()
        
        let searchNavigation = UINavigationController()
        let searchCoordinator = SearchViewControllerCoordinator(presenter: searchNavigation)
        searchCoordinator.start()
        
        tabBarController.viewControllers = [moviesNavigation, searchNavigation]
        self.childCoordinators = [moviesCoordinator, searchCoordinator]
        
        self.window.rootViewController = tabBarController
        self.window.makeKeyAndVisible()
    }
    
}
