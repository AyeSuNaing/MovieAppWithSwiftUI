//
//  ProductionCountryVO.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
struct ProductionCountryVO : Codable {
     var iso_3166_1 :String?
     var name : String?
    
    enum CodingKeys: String, CodingKey {
        case iso_3166_1
        case name
    }
    
    func toProductionCountryObj() -> ProductionCountryObject{
        
    let obj = ProductionCountryObject()
        obj.iso_3166_1 = iso_3166_1
        obj.name = name
        return obj
    }
}
