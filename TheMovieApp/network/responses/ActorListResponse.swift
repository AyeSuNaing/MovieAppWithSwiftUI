//
//  ActorListResponse.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation

struct ActorListResponse : Codable {
    
    var page : Int?
    var results : [ActorVO]?
     
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}
