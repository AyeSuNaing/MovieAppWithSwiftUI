//
//  SpokenLanguageObject.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import RealmSwift

class SpokenLanguageObject : Object {
    
    @Persisted
    var iso639_1 : String?
    
    @Persisted(primaryKey: true)
    var name : String?
    
    
    @Persisted
    var englishName : String?
    
    func toSpokenLanguageVO() -> SpokenLanguageVO {
        return  SpokenLanguageVO(englishName: englishName, iso_639_1: iso639_1, name: name)
    }
}
