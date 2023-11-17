//
//  MovieListResponse.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation

struct MovieListResponse : Codable {
    var dates : DateVO?
    var page : Int?
    var results : [MovieVO]?
    
    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
    }
}
