//
//  AppDelegate.swift
//  MovieShelf
//
//  Created by Levy Cristian on 11/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: TabBarCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        coordinator = TabBarCoordinator(window: window)
        coordinator?.start()

        return true
    }
}
