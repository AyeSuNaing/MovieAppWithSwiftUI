//
//  ProductionCompanyObject.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import RealmSwift

class ProductionCompanyObject : Object {
    
    @Persisted(primaryKey: true)
    var id : Int?
    
    @Persisted
    var loginPath : String?
    
    @Persisted
    var name : String?
    
    @Persisted
    var originCountry : String?
    
    func toProductionCompanyVO() -> ProductionCompanyVO {
        return ProductionCompanyVO(id: id,loginPath: loginPath,name: name,originCountry: originCountry)
    }
}
