//
//  SpokenLanguageVO.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
struct SpokenLanguageVO : Codable {
    
     var englishName : String?
     var iso_639_1 : String?
     var name : String?
    
    enum CodingKeys : String,CodingKey {
        case englishName = "english_name"
        case iso_639_1
        case name
    }
    
    
    func toSpokenLanguageObj() -> SpokenLanguageObject{
        
    let obj = SpokenLanguageObject()
        obj.englishName = englishName
        obj.iso639_1 = iso_639_1
        obj.name = name
        return obj
    }
}
