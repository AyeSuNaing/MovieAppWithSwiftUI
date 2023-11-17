//
//  ProductionCountryObject.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import RealmSwift
class ProductionCountryObject : Object {
    
    @Persisted var iso_3166_1 : String?
    
    @Persisted var name: String?
    
    func toProductionCountyVO()->ProductionCountryVO{
        return ProductionCountryVO(iso_3166_1: iso_3166_1, name: name)
    }

}
