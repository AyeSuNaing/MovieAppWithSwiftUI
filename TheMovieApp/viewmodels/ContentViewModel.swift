//
//  ContentViewModel.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import Combine
import RxSwift

enum UIState {
    case idle
    case loading
    case error(String)
}

class ContentViewModel: ObservableObject {
    private let mMovieModel: MovieModel
    @Published var mUpComing: [MovieVO]? = nil
    @Published var mPopularMovies: [MovieVO]? = nil
    
    // UI states
    
    @Published var uiState: UIState = .idle
    
    private let disposeBag = DisposeBag()
    
    init(movieModel: MovieModel) {
        self.mMovieModel = movieModel
        requestData()
    }
    
    func requestData() {
            uiState = .loading
            
            mMovieModel.getUpcoming(page: 1) { [weak self] _ in
                self?.uiState = .idle
            } onFailure: { [weak self] error in
                self?.uiState = .error(error.localizedDescription)
            }
            
            mMovieModel.getPopularMovies(page: 1) { [weak self] _ in
                self?.uiState = .idle
            } onFailure: { [weak self] error in
                self?.uiState = .error(error.localizedDescription)
            }
            
            self.mUpComing = mMovieModel.getNowPlayingMoviesFromDatabase()
            self.mPopularMovies = mMovieModel.getPopularMoviesFromDatabase()
            
            mMovieModel.getUpComingMoviesObservable()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] mUpComing in
                    self?.mUpComing = mUpComing
                    self?.uiState = .idle
                })
                .disposed(by: disposeBag)
            
            mMovieModel.getPopularMoviesFObservable()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] popularMovies in
                    self?.mPopularMovies = popularMovies
                    self?.uiState = .idle
                })
                .disposed(by: disposeBag)
        }
        
    
    func setFavorite(movieId: Int){
            mMovieModel.checkFavorite(movieId: movieId  , isSelected: false, completion: {_ in
                // self.mMovieVO = self.mMovieModel.getMovieByIdFromDatabase(id: self.movieId ?? 0 )
            })
        }
    
    
   
    
    func retry() {
            uiState = .loading
            requestData()
        }
}

