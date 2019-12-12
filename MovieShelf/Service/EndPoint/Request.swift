//
//  Request.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

class Request<T: EndPointType>: NetworkProtocol {
    
    private var task: URLSessionTask?
    
    func run<U: Decodable>(_ endPoint: T, completion: @escaping (U?, Errors?) -> Void) {
        let session = URLSession.shared
        
        var request = URLRequest(url: endPoint.url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        request.httpMethod = "GET"
        
        self.task = session.dataTask(with: request, completionHandler: { (data, _, error) in
            guard let responseData = data, error == nil else {
                print("Request Error:", error!.localizedDescription)
                return DispatchQueue.main.async {completion(nil, Errors.failRequest)}
            }
            
            do {
                let decodeObject = try JSONDecoder().decode(U.self, from: responseData)
                
                DispatchQueue.main.async {
                    completion(decodeObject, nil)
                }
            } catch {
                print("Decoding error:", error)
                DispatchQueue.main.async {completion(nil, Errors.failRequest)}
            }
        })
        
        self.task?.resume()
    }
        
    func cancel() {
        self.task?.cancel()
    }
}

enum Errors: Error {
    case invalidURL
    case failRequest
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .failRequest: return "Applicantion cannot request external data"
            
        }
    }
}
