//
//  ActorVO.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
struct ActorVO: Codable {
        var adult : Bool?
        var gender : Int?
        var id : Int?
        var KnownFor : [MovieVO]?
        var knwonForDepartment : String?
        var name        : String?
        var popularity  : Double?
        var profilePath : String?
    
    var isSelected : Bool = false
    
    enum CodingKeys : String, CodingKey {
        case adult
        case gender
        case id
        case KnownFor = "known_for"
        case knwonForDepartment = "known_for_department"
        case name
        case popularity
        case profilePath = "profile_path"
    }
    
    func getProfilePathTogetherWithImageBaseUrl() -> String {
        return  "\(BASE_IMAGE_URL)\(profilePath ?? "")"
    }
}
