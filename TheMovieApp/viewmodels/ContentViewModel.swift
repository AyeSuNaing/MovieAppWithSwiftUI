//
//  ContentViewModel.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import Combine
import RxSwift

class ContentViewModel : ObservableObject{
    // data model
    let mMovieModel : MovieModel = MovieModelImpl.shared

    // state variables
    @Published var mUpComing : [MovieVO]? = nil
    @Published var mPopularMovies : [MovieVO]? = nil
    
    private let disposeBag = DisposeBag()
    
    init(){
        requestData()
    }
    
    func requestData(){
        //now upcoing movies
        mMovieModel.getUpcoming(page: 1) { _ in
            
        } onFailure: { error in
            
        }

        
        //popular movies
        mMovieModel.getPopularMovies(page: 1) { _ in
           
        } onFailure: { error in
        }
      
        
        //database
        self.mUpComing = mMovieModel.getNowPlayingMoviesFromDatabase()
        self.mPopularMovies = mMovieModel.getPopularMoviesFromDatabase()
        
        
        //get data from database
        mMovieModel.getUpComingMoviesObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (mUpComing) in
                guard let self = self  else { return }
                self.mUpComing = mUpComing
            })
            .disposed(by: disposeBag)
        
    
        mMovieModel.getPopularMoviesFObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {  [weak self](popularMovies) in
                guard let self = self  else { return }
                self.mPopularMovies = popularMovies
            })
            .disposed(by: disposeBag)
        

        
    }
   
    func setFavorite(movieId: Int){
        mMovieModel.checkFavorite(movieId: movieId  , isSelected: false, completion: {_ in
           // self.mMovieVO = self.mMovieModel.getMovieByIdFromDatabase(id: self.movieId ?? 0 )
        })
    }
}
