//
//  MovieVO.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import RealmSwift


struct MovieVO : Codable,Hashable{
   
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
 
    
    
    var adult : Bool?
    var backdropPath : String?
    var belongsToCollection: BelongsToCollectionVO?
    var budget : Int?
    var genres : [GenreVO]?
    var homepage : String?
    var id : Int?
    var imdbID : String?
    var originalLanguage : String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var productionCompanies : [ProductionCompanyVO]?
    var productionCountries : [ProductionCountryVO]?
    var releaseDate : String?
    var revenue: Int?
    var runtime: Int?
    var spokenLanguages : [SpokenLanguageVO]?
    var status : String?
    var tagline: String?
    var title : String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var type : String?
    var isFavorite : Bool = false
    
    
    enum CodingKeys: String,CodingKey{
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbID = "imdb_id"
        case originalLanguage
        case originalTitle
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func getBackdropPathTogetherWithBaseUrl() -> String {
        return "\(BASE_IMAGE_URL)\(backdropPath ?? "")"
    }
    
    func getPosterPathTogetherWithBaseUrl() -> String {
        return "\(BASE_IMAGE_URL)\(posterPath ?? "")"
    }
    func getGenresAsCommaSeparatedString() -> String {
        return genres?.map({ genre in
            genre.name ?? ""
        }).joined(separator: ",") ?? ""
    }
    func getProductionCountryAsCommaSeparatedString() -> String {
        return productionCountries?.map({ productionCountry in
            productionCountry.name ?? ""
        }).joined(separator: ",") ?? ""
    }
  
   
    
     //custom euqtable
    static func == (lhs: MovieVO, rhs: MovieVO) -> Bool {
        return (lhs.id == rhs.id) && (lhs.overview == rhs.overview)
    }
    
    //to movie obj
    func toMovieObj(type:String, fav: Bool = false ) -> MovieObject {
        let movieObj = MovieObject()
        movieObj.adult = adult
        movieObj.backdropPath = backdropPath
        movieObj.belongsToCollection = belongsToCollection?.toBelongsToCollectionObj()
        movieObj.budget = budget
        genres?.forEach({ genreVO in
            movieObj.genres.append(genreVO.toGenreObj())
        })
       
        movieObj.homepage = homepage
        movieObj.id = id
        movieObj.imdbID = imdbID
        movieObj.originalLanguage = originalLanguage
        movieObj.originalTitle = originalTitle
        movieObj.overview = overview
        movieObj.popularity = popularity
        movieObj.posterPath = posterPath
        productionCompanies?.forEach({ companyVO in
            movieObj.productionCompanies.append(companyVO.toProductionCompanyObj())
        })
        productionCountries?.forEach({ countryVO in
            movieObj.productionCountries.append(countryVO.toProductionCountryObj())
        })
        movieObj.releaseDate = releaseDate
        movieObj.revenue = revenue
        movieObj.runtime = runtime
        spokenLanguages?.forEach({ languageVO in
            movieObj.spokenLanguages.append(languageVO.toSpokenLanguageObj())
        })
        movieObj.status = status
        movieObj.tagline = tagline
        movieObj.title = title
        movieObj.video = video
        movieObj.voteAverage = voteAverage
        movieObj.voteCount = voteCount
        movieObj.type = type
        movieObj.isFavorite = fav
        
        return movieObj
    }
    
    
    //to movie detail obj
    func toMovieDetailObj(type:String, fav: Bool = false  ) -> MovieDetailObject {
        let movieObj = MovieDetailObject()
        movieObj.adult = adult
        movieObj.backdropPath = backdropPath
        movieObj.belongsToCollection = belongsToCollection?.toBelongsToCollectionObj()
        movieObj.budget = budget
        genres?.forEach({ genreVO in
            movieObj.genres.append(genreVO.toGenreObj())
        })
       
        movieObj.homepage = homepage
        movieObj.id = id
        movieObj.imdbID = imdbID
        movieObj.originalLanguage = originalLanguage
        movieObj.originalTitle = originalTitle
        movieObj.overview = overview
        movieObj.popularity = popularity
        movieObj.posterPath = posterPath
        productionCompanies?.forEach({ companyVO in
            movieObj.productionCompanies.append(companyVO.toProductionCompanyObj())
        })
        productionCountries?.forEach({ countryVO in
            movieObj.productionCountries.append(countryVO.toProductionCountryObj())
        })
        movieObj.releaseDate = releaseDate
        movieObj.revenue = revenue
        movieObj.runtime = runtime
        spokenLanguages?.forEach({ languageVO in
            movieObj.spokenLanguages.append(languageVO.toSpokenLanguageObj())
        })
        movieObj.status = status
        movieObj.tagline = tagline
        movieObj.title = title
        movieObj.video = video
        movieObj.voteAverage = voteAverage
        movieObj.voteCount = voteCount
        movieObj.type = type
        movieObj.isFavorite = isFavorite
        
        return movieObj
    }
//
    
    
}

let MOVIE_TYPE_NOW_PLAYING = "Now Playing"
let MOVIE_TYPE_POPULAR = "Popular"
