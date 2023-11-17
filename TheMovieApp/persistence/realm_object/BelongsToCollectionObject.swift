//
//  BelongsToCollectionObject.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import RealmSwift


class BelongsToCollectionObject : Object{
    
    @Persisted(primaryKey: true) dynamic var id : Int?
    @Persisted dynamic var name : String?
    @Persisted dynamic var posterPath : String?
    @Persisted dynamic var backdropPath : String?
    
    func toBelongsToCollectionVO() -> BelongsToCollectionVO {
        return BelongsToCollectionVO(id: id,name: name,posterPath: posterPath,backdropPath: backdropPath)
    }
    
}
