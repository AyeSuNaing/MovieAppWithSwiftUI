//
//  MovieDAO.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import RealmSwift
import RxSwift
//import RxRealm


class MovieDAO {
    //singleton
    
    static let shared = MovieDAO()
    private init(){
        do {
            let realmPath = try Realm().configuration.fileURL?.absoluteString ?? "undefined"
            print("Default Realm is at : \( realmPath )")
        } catch {
            
        }
    }
    
    //save movies
    func saveMovies(movies:[MovieVO],for type:String){
        do {
            let realm = try Realm()
          

            let movieObjs =   movies.map { movieVO in
                
            
                movieVO.toMovieDetailObj(type: type, fav: getMovieFavVlueById(movieId: movieVO.id ?? 0) ?? false)
            }
            
            try realm.write({
                
                realm.add(movieObjs,update: .all)
              //  print("save result : \(movieObjs)")
            })
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    //save movie detail
    func saveMovieDetail(movie:MovieVO, type: String){
        do {
            let fav = getMovieFavVlueById(movieId: movie.id ?? 0)
            print("---------- \(fav)")
            let realm = try Realm()
        

            let movieObj = movie.toMovieDetailObj(type: type , fav: fav ?? false )
            
            
            try realm.write({
                
                realm.add(movieObj,update: .all)
               
            })
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    //get all movies
    func getAllMovies()->[MovieVO]{
        do{
            let realm = try Realm()
            let results = realm.objects(MovieObject.self)
         
            return results.map { movieObj in
                movieObj.toMovieVO()
            }
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    //get movies by type
    func getMoviesByType(type:String)->[MovieVO]{
        do{
            let realm = try Realm()
            let moviesByType = realm.objects(MovieObject.self).filter { movie in
                movie.type == type
            }
            return moviesByType.map { movieObj in
                movieObj.toMovieVO()
            }
            
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
        
    
    }
    
    
    //get movie by id
    func getMovieById(movieId:Int) -> MovieVO?{
        do{
            let realm = try Realm()
            let result = realm.object(ofType: MovieDetailObject.self, forPrimaryKey: movieId)
            //print("get result : \(result?.toMovieVO())")
            return result?.toMovieVO()
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    //get movie by id
    func getMovieFavVlueById(movieId:Int) -> Bool?{
        var returnResult = false
        do{
            let realm = try Realm()
            let result = realm.object(ofType: MovieDetailObject.self, forPrimaryKey: movieId)
            returnResult =  ((result?.toMovieVO().isFavorite) ?? false )
            print("id - \(movieId)")
            print("fav - \(returnResult)")
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
        return returnResult
    }
    
    // check favorite
    func checkFavorite(movieId: Int, isSelected: Bool,completion: @escaping  (Bool) -> Void){
        do{
            let realm = try Realm()
            guard let object : MovieDetailObject  = realm.object(ofType: MovieDetailObject.self, forPrimaryKey: movieId ) else{
            return completion(false)
            }
            let fav = getMovieFavVlueById(movieId: movieId) ?? false
            try realm.write {
                object.isFavorite = !fav
                realm.add(object, update: .modified)
            }
            completion(true)
                    
        }catch{
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
}
