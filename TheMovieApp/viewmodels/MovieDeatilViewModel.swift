//
//  MovieDeatilViewModel.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import Combine

class MovieDetailViewModel : ObservableObject{
    
    var movieId : Int?
    var type: String
    
    // state
    @Published var mMovieVO : MovieVO?
    @Published var mCasts : [ActorVO]?
    
    // model
    let mMovieModel : MovieModel = MovieModelImpl.shared
    
    init(movieId: Int, type: String) {
        self.movieId = movieId
        self.type = type
        requestData()
        
    }
    
    func requestData(){
        if let movieId = movieId {
            //database
            self.mMovieVO = mMovieModel.getMovieByIdFromDatabase(id: movieId)
            
            // detail from online
            mMovieModel.getMovieDetails(movieId: movieId, type: type) { movieDetailVO in
                self.mMovieVO = movieDetailVO
              
            } onFailure: { error in
                
            }
            
            //credit
            mMovieModel.getCredits(movieId: movieId) { casts, crews in
                self.mCasts = casts
            } onFailure: { error in
                
            }
        }
    }
    
    func setFavorite(){
        mMovieModel.checkFavorite(movieId: movieId ?? 0 , isSelected: false, completion: {_ in
           // self.mMovieVO = self.mMovieModel.getMovieByIdFromDatabase(id: self.movieId ?? 0 )
        })
    }
        
    
}

