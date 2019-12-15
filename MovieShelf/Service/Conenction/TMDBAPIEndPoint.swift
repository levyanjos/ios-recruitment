//
//  TMDBAPIEndPoint.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

public enum TMDBApi {
    case popularMovies(language: Language, page: Int)
    case posterImage(posterSize: PosterSize, posterPath: String)
    case recommendations(movieID: Int, page: Int, language: Language)
    
    public enum PosterSize: String {
        case w92
        case w154
        case w342
        case w500
        case w780
        case original
    }

    public enum Language: String {
        case en = "en-US"
        case pt = "pt-BR"
    }
}

//APIInformation
extension TMDBApi: EndPointType {
    var apiKey: String {
        return "8ea46276a6a27d06a97d94ccc0180d3c"

    }
    
    var apiAdress: String {
        return "https://api.themoviedb.org/3/"

    }
    
    var apiAdressImage: String {
        return "https://image.tmdb.org/t/p/"

    }
    
    var url: URL {
        return URL(string: self.path)!
    
    }
    
    var path: String {
        switch (self) {
        case .popularMovies(let language, let page):
            return self.apiAdress + "movie/popular?api_key=" + apiKey + "&language=" + language.rawValue + "&page=\(page)"
        
        case .posterImage(let posterSize, let posterPath):
            return self.apiAdressImage + "/" + posterSize.rawValue + "/" + posterPath
            
        case .recommendations(let movieID, let page, let language):
            return self.apiAdress + "movie/" + "\(movieID)/recommendations?" + apiKey + "&language=" + language.rawValue + "&page=\(page)"
        }
    }
}
