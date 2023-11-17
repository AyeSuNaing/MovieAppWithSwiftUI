//
//  GenreVO.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import RealmSwift



struct GenreVO : Codable {
     var id : Int?
     var name : String?
    
    var isSelected : Bool = false
    
    enum CodingKeys: CodingKey {
        case id
        case name
      
    }
    
    
    func toGenreObj() -> GenreObject {
     
        let genre = GenreObject()
        
        genre.id = id
        genre.name = name
        genre.isSelected = isSelected
        
        return genre
    }

    

}

