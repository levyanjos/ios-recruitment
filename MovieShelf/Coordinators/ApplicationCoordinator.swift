//
//  ApplicationCoordinator.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    var window: UIWindow
    var rootViewController: UINavigationController
    var tabBarCoordinator: TabBarCoordinator

    init(window: UIWindow) {
        self.window = window
        let navigation = UINavigationController()
        self.rootViewController = navigation
        self.tabBarCoordinator = TabBarCoordinator(presenter: navigation)
    }

    func start() {

        self.window.rootViewController = rootViewController
        window.backgroundColor = .red
        window.makeKeyAndVisible()

        tabBarCoordinator.start()
    }
}
