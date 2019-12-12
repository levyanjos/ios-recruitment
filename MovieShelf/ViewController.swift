//
//  ViewController.swift
//  MovieShelf
//
//  Created by Levy Cristian on 11/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

protocol AddDelegate {
    func add()
}

class ViewController: UIViewController {

    var delegate: AddDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.add))
        self.navigationItem.rightBarButtonItem = button
        
//        let request = Request<TMDBApi>()
//        request.run(TMDBApi.popular(languege: .pt, page: 1)) { (result: Result<TopMovies, Errors>) in
//            switch result {
//            case .success(let topMovies):
//                print(topMovies)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
    }

    @objc func add() {
        delegate.add()
    }

}
