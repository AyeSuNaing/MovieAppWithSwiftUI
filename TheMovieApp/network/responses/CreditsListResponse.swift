//
//  CreditsListResponse.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
struct CreditsListResponse : Codable {
    var id : Int?
    var cast : [ActorVO]?
    var crew : [ActorVO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
        case crew
    }
}

