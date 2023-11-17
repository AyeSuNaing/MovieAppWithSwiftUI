//
//  MovieDataAgentImpl.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import RealmSwift
import RxSwift

class MovieDataAgentImpl : MovieDataAgent {
    
    // Singleton
    static let shared = MovieDataAgentImpl()
    private init(){}
    
    func getUpcoming(page: Int) -> RxSwift.Observable<[MovieVO]> {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY,
            PARAM_PAGE : page
        ]
        return fetchDataWithParametersObservable(forEndPoint: ENDPOINT_NOW_PLAYING, parameters: parameters)
            .map { (response : MovieListResponse) in
                return response.results     ?? []
        }
    }
    
    func getPopularMovies(page: Int) -> RxSwift.Observable<[MovieVO]> {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY,
            PARAM_PAGE : page
        ]
        return fetchDataWithParametersObservable(forEndPoint: ENDPOINT_GET_TOPRATED, parameters: parameters).map { (response : MovieListResponse) in
            return response.results ?? []
        }
    }
    
    func getMovieDetails(movieId: Int) -> RxSwift.Observable<MovieVO> {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY
        ]
        
        return fetchDataWithParametersObservable(forEndPoint: "\(ENDPOINT_GET_MOVIE_DETAILS)/\(movieId)", parameters: parameters)
    }
    
    func getCredits(movieId: Int) -> RxSwift.Observable<([ActorVO], [ActorVO])> {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY
        ]
        
        return fetchDataWithParametersObservable(forEndPoint: "\(ENDPOINT_GET_CREDITS_BY_MOVIE)/\(movieId)/credits", parameters: parameters)
            .map { (response : CreditsListResponse) in
                return (response.cast ?? [], response.crew ?? [])
            }
    }
    
    
    
    
}

