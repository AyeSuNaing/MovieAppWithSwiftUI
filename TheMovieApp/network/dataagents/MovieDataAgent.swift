//
//  MovieDataAgent.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import Alamofire
import RxSwift

protocol MovieDataAgent {
    
    func getUpcoming(page : Int) -> Observable<[MovieVO]>
    
    func getPopularMovies(page : Int) -> Observable<[MovieVO]>
    
    func getMovieDetails(movieId : Int) -> Observable<MovieVO>
    
    func getCredits(movieId : Int) -> Observable<([ActorVO],[ActorVO])>
    
}
