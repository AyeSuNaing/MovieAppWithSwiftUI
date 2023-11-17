//
//  MovieModelImpl.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import RxSwift

struct MovieModelImpl : MovieModel {
    
    // Singleton
    static let shared = MovieModelImpl()
    private init(){}
    
    //data agent
    let mDataAgent : MovieDataAgent = MovieDataAgentImpl.shared
    
    //dao
    let mMovieDao = MovieDAO.shared
    
    var disposeBag = DisposeBag()
    
    
    func getUpcoming(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getUpcoming(page: page)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                nowPlayingMovies in
                   
                    //save to db
                var result : [MovieVO] = []
                result.append(nowPlayingMovies.first ?? MovieVO())
                result.append(nowPlayingMovies.last ?? MovieVO())
                self.mMovieDao.saveMovies(movies: result, for: MOVIE_TYPE_NOW_PLAYING)
            }, onError: {
                error in
                onFailure(error)
            })
            .disposed(by: disposeBag)
    }
    
    func getPopularMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getPopularMovies(page: page)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { popularMovies in
              
                //save to db
                var result : [MovieVO] = []
                result.append(popularMovies.first ?? MovieVO())
                result.append(popularMovies.last ?? MovieVO())
                self.mMovieDao.saveMovies(movies: result, for: MOVIE_TYPE_POPULAR)
            }, onError: {
                 error in
                onFailure(error)
            })
            .disposed(by: disposeBag)
    }
    
    func getMovieDetails(movieId: Int, type: String, onSuccess: @escaping (MovieVO) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getMovieDetails(movieId: movieId)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                movieDetails in
                self.mMovieDao.saveMovieDetail(movie: movieDetails, type: type)
                onSuccess(movieDetails)

            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
    }
    
    func getCredits(movieId: Int, onSuccess: @escaping ([ActorVO], [ActorVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getCredits(movieId: movieId)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                (actor,crew) in
                onSuccess(actor,crew)
                
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
    }
    
    // database
    func getAllMoviesFromDatabase() -> [MovieVO] {
        return mMovieDao.getAllMovies()
    }
    
    func getMovieByIdFromDatabase(id: Int) -> MovieVO? {
        return mMovieDao.getMovieById(movieId: id)
    }
    
    func getNowPlayingMoviesFromDatabase() -> [MovieVO] {
        return mMovieDao.getMoviesByType(type: MOVIE_TYPE_NOW_PLAYING)
    }
    
    func getPopularMoviesFromDatabase() -> [MovieVO] {
        return mMovieDao.getMoviesByType(type: MOVIE_TYPE_POPULAR)
    }
    
    func getUpComingMoviesObservable() -> Observable<[MovieVO]> {
        return mDataAgent.getUpcoming(page: 1)
    }
    
    func getPopularMoviesFObservable() -> Observable<[MovieVO]> {
        return mDataAgent.getPopularMovies(page: 1)
    }
 
    func checkFavorite(movieId: Int, isSelected: Bool, completion: @escaping (Bool) -> Void) {
        mMovieDao.checkFavorite(movieId: movieId, isSelected: isSelected, completion: { value in
            return completion(value)
        })
    }
    
    func getMovieFavVlueById(movieId:Int) -> Bool?{
        return mMovieDao.getMovieFavVlueById(movieId: movieId)
    }
    
  
}
