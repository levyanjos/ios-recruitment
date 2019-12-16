//
//  NetworkProtocol.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation
/**
    Protocol created to interfaciate Network Layer
 */
protocol NetworkProtocol {
    
    associatedtype EndPoint: EndPointType
    /**
     Generic methoud to be implemented for request from some API EndPoint
    - parameter route: Api route to EndPoint
    - parameter completion: A generic completion of `Result<T, Errors>` that sould be implemented for api result
    */
    func run<T: Decodable>(_ route: EndPoint, completion: @escaping (Result<T, Errors>) -> Void)
    func cancel()
}
