//
//  Identifiable.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

/**
Protocol enable to work with typeSafe reusable idetifiers where class itself names gonna be the identifier

*/

protocol Identifiable {
    /**
    Reusable value from some identifiable View

    - returns: return a `String` with Identifiable name
    */
    static var reuseIdentifier: String { get }
}

extension Identifiable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: Identifiable {}

extension UICollectionReusableView: Identifiable {}
