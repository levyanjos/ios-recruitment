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
    let presenter: UINavigationController
    let tabBarController: UITabBarController
    var childCoordinators = [Coordinator]()
    
    init(presenter: UINavigationController) {
        //inicializa atributos do coordinator
        self.presenter = presenter
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        //instancia tela e mostra a partir de presenter
        let navigation1 = UINavigationController()
        let coordinator1 = ViewControllerCoordinator(presenter: navigation1, color: .white)
        coordinator1.start()
        
        let navigation2 = UINavigationController()
        let coordinator2 = ViewControllerCoordinator(presenter: navigation2, color: .green)
        coordinator2.start()
        
        let navigation3 = UINavigationController()
        let coordinator3 = ViewControllerCoordinator(presenter: navigation3, color: .blue)
        coordinator3.start()
        
        tabBarController.viewControllers = [navigation1, navigation2, navigation3]
        self.childCoordinators = [coordinator1, coordinator2, coordinator3]
        self.presenter.pushViewController(tabBarController, animated: true)
    }
    
}

class ViewControllerCoordinator: Coordinator {
    
    let presenter: UINavigationController
    let viewController: UIViewController
    
    init(presenter: UINavigationController, color: UIColor) {
        self.presenter = presenter
        self.viewController = UIViewController()
        self.viewController.view.backgroundColor = color
    }
    
    func start() {
        self.presenter.pushViewController(viewController, animated: true)
    }
}
