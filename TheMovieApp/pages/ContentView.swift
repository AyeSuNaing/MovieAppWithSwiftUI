//
//  ContentView.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import SwiftUI
import RxSwift

struct ContentView: View {
    
    // view model
    @StateObject var mViewModel = ContentViewModel()
   
    let disposeBag = DisposeBag()

    
    var body: some View {
        NavigationStack{
            ZStack{
                // background
                Color(PRIMARY_COLOR)
                
                VStack(spacing: 0.0){
                    
                    // App Bar View
                    AppBarView()
                    
                    
                    
                    ScrollView(.vertical){
                        VStack(alignment: .leading, spacing: 0.0){
                            RecommendedMovieListView(mMovies: mViewModel.mPopularMovies, label: LABEL_POPULAR){ id in
                                mViewModel.setFavorite(movieId: id)
                            }
                            
                            UpComingMovieListView(mMovies: mViewModel.mUpComing, label: LABEL_UPCOMING){ id in
                                mViewModel.setFavorite(movieId: id)
                            }
                            
                            Spacer().frame(height: MARGIN_XXLARGE)
                        }
                    }

                    
                }.padding(.top, MARGIN_MEDIUM_3)
            }
            .edgesIgnoringSafeArea([.top, .bottom])
            .navigationDestination(for: MovieVO.self) { movie in
                MovieDetailScreen(movieId: movie.id ?? 0, type: movie.type)
            }
        }
    }
}


struct AppBarView: View {
    @State private var searchText = ""

    var body: some View {
        VStack(alignment: .leading,spacing: 0.0){
            Text(LABEL_TITLE_LOOKING_FOR)
                .font(.system(size: TEXT_REGULAR_3X))
                .fontWeight(.bold)
                .padding([.top], MARGIN_LARGE)
            
        
        }.padding()
    }
    
}

