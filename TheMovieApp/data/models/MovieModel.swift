//
//  MovieModel.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import RxSwift
 
protocol MovieModel {
    func getUpcoming(page : Int, onSuccess : @escaping([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void)
    
    func getPopularMovies(page : Int, onSuccess : @escaping([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void)
    
    func getMovieDetails(movieId : Int, type: String , onSuccess : @escaping(MovieVO) -> Void, onFailure: @escaping (Error) -> Void)
    
    func getCredits(movieId : Int, onSuccess : @escaping([ActorVO],[ActorVO]) -> Void, onFailure: @escaping (Error) -> Void)
    
    //database
    func getAllMoviesFromDatabase() -> [MovieVO]
    func getMovieByIdFromDatabase(id:Int) -> MovieVO?
    func getNowPlayingMoviesFromDatabase() -> [MovieVO]
    func getPopularMoviesFromDatabase() -> [MovieVO]
    
    
    //database with observable
    func getUpComingMoviesObservable() -> Observable<[MovieVO]>
    func getPopularMoviesFObservable() -> Observable<[MovieVO]>
    
    // check favorite
    func checkFavorite(movieId: Int, isSelected: Bool, completion: @escaping (Bool) -> Void) 
    
}
