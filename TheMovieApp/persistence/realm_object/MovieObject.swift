//
//  MovieObject.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import RealmSwift

@objcMembers
class MovieObject : Object {

    
   @Persisted dynamic var adult : Bool?
   @Persisted dynamic var backdropPath : String?
   @Persisted dynamic var belongsToCollection: BelongsToCollectionObject?
   @Persisted dynamic var budget : Int?
   @Persisted var genres  = List<GenreObject>()
   @Persisted dynamic var homepage : String?
   @Persisted(primaryKey: true) dynamic var id : Int?
   @Persisted dynamic var imdbID : String?
   @Persisted dynamic var originalLanguage : String?
   @Persisted dynamic var originalTitle: String?
   @Persisted dynamic var overview: String?
   @Persisted dynamic var popularity: Double?
   @Persisted dynamic var posterPath: String?
   @Persisted var productionCompanies = List<ProductionCompanyObject>()
   @Persisted var productionCountries = List<ProductionCountryObject>()
   @Persisted dynamic var releaseDate : String?
   @Persisted dynamic var revenue: Int?
   @Persisted dynamic var runtime: Int?
    @Persisted var spokenLanguages = List<SpokenLanguageObject>()
   @Persisted dynamic var status : String?
   @Persisted dynamic var tagline: String?
   @Persisted dynamic var title : String?
   @Persisted dynamic var video: Bool?
   @Persisted dynamic var voteAverage: Double?
   @Persisted dynamic var voteCount: Int?
   @Persisted dynamic var type : String?
   @Persisted dynamic var isFavorite : Bool?
    

    
    // custom euqtable
    static func == (lhs: MovieObject, rhs: MovieObject) -> Bool {
        return (lhs.id == rhs.id) && (lhs.overview == rhs.overview)
    }
    
    func toMovieVO() -> MovieVO {
        return MovieVO(adult:adult,backdropPath: backdropPath,belongsToCollection: belongsToCollection?.toBelongsToCollectionVO(),budget: budget,genres: genres.map({ genreObj in
            genreObj.toGenreVO()
        }),homepage: homepage,id: id,imdbID: imdbID,originalLanguage:originalLanguage,originalTitle: originalTitle,overview: overview,popularity: popularity,posterPath: posterPath, productionCompanies: productionCompanies.map({ companyObj in
            companyObj.toProductionCompanyVO()
        }),productionCountries: productionCountries.map({ countryObj in
            countryObj.toProductionCountyVO()
        }),releaseDate: releaseDate,revenue: revenue,runtime: runtime,spokenLanguages: spokenLanguages.map({ languageObj in
            languageObj.toSpokenLanguageVO()
        }),status: status,tagline: tagline,title: title,video: video,voteAverage: voteAverage,voteCount: voteCount,type: type, isFavorite: isFavorite ?? false )
    }
    
}

