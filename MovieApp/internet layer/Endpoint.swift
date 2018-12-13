//
//  File.swift
//  MovieApp
//
//  Created by Амир Разаков on 12.12.2018.
//  Copyright © 2018 Амир Разаков. All rights reserved.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    
    var apiKey: String {
        return "2a2e3cdc92bf1bdb6df865c4af82168e"
    }
    
    var language: String {
        return "ru-RU"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        print(url)
        return URLRequest(url: url)
    }
}

enum MovieFeed {
    case upcoming
    case latest
}

struct MovieFeedEndpoint: Endpoint {
    
    var movieFeed: MovieFeed
    var page: String?
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        switch movieFeed {
        case .upcoming: return "/3/movie/upcoming"
        case .latest: return "/3/movie/latest"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch movieFeed {
            
        case .upcoming:
            let apiKeyQuery = URLQueryItem(name: "api_key", value: apiKey)
            let languageQuery = URLQueryItem(name: "language", value: language)
            let pageQuery = URLQueryItem(name: "page", value: page)
            return [apiKeyQuery, languageQuery, pageQuery]
        case .latest:
            let apiKeyQuery = URLQueryItem(name: "api_key", value: apiKey)
            let languageQuery = URLQueryItem(name: "language", value: language)
            let pageQuery = URLQueryItem(name: "page", value: page)
            return [apiKeyQuery, languageQuery, pageQuery]
        }
    }
}

struct MovieDetailsEndpoint: Endpoint {
    
    var movieId: String
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        return "/3/movie/\(movieId)"
    }
    
    var queryItems: [URLQueryItem] {
        let apiKeyQuery = URLQueryItem(name: "api_key", value: apiKey)
        let languageQuery = URLQueryItem(name: "language", value: language)
        return [apiKeyQuery, languageQuery]
    }
}
