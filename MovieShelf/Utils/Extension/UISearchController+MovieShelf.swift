//
//  UISearchController+MovieShelf.swift
//  MovieShelf
//
//  Created by Levy Cristian on 15/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

extension UISearchController {
    /** Returns true if searchBar text is empty or nil */
    func searchBarIsEmpty() -> Bool {
        return self.searchBar.text?.isEmpty ?? true
    }
}
