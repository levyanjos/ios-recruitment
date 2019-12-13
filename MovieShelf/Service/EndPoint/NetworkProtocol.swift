//
//  NetworkProtocol.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    
    associatedtype EndPoint: EndPointType
    func run<T: Decodable>(_ route: EndPoint, completion: @escaping (Result<T, Errors>) -> Void)
    func cancel()
}
