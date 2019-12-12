//
//  NetworkEndPoint.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

protocol EndPointType {
    var url: URL { get }
    var path: String { get }
    var apiKey: String { get }
}

enum HTTPMethod: String {
    case get = "GET"
}
