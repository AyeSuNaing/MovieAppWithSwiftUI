//
//  ContentView.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import SwiftUI
import RxSwift

struct ContentView: View {
    @StateObject var mViewModel: ContentViewModel
    
    init(mViewModel: ContentViewModel) {
        self._mViewModel = StateObject(wrappedValue: mViewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(PRIMARY_COLOR)
                    .edgesIgnoringSafeArea([.top, .bottom])
                
                VStack(spacing: 0.0) {
                    AppBarView()
                    
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 0.0) {
                            RecommendedMovieListView(mMovies: mViewModel.mPopularMovies, label: LABEL_POPULAR) { id in
                                mViewModel.setFavorite(movieId: id)
                            }
                            
                            UpComingMovieListView(mMovies: mViewModel.mUpComing, label: LABEL_UPCOMING) { id in
                                mViewModel.setFavorite(movieId: id)
                            }
                            
                            Spacer().frame(height: MARGIN_XXLARGE)
                        }
                    }
                }
                .padding(.top, MARGIN_MEDIUM_3)
            }
            .edgesIgnoringSafeArea([.top, .bottom])
            .navigationDestination(for: MovieVO.self) { movie in
                MovieDetailScreen(movieId: movie.id ?? 0, type: movie.type)
            }
            .overlay(overlayView)
        }
    }
    
    private var overlayView: some View {
        switch mViewModel.uiState {
        case .loading:
            return AnyView(LoadingOverlay())
        case .error(let message):
            return AnyView(ErrorOverlay(message: message, retryAction: mViewModel.retry))
        default:
            return AnyView(EmptyView())
        }
    }
}

struct AppBarView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text(LABEL_TITLE_LOOKING_FOR)
                .font(.system(size: TEXT_REGULAR_3X))
                .fontWeight(.bold)
                .padding([.top], MARGIN_LARGE)
        }
        .padding()
    }
}


struct LoadingOverlay: View {
    var body: some View {
        VStack {
            ProgressView("Loading...")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.7))
        .edgesIgnoringSafeArea(.all)
    }
}



struct ErrorOverlay: View {
    var message: String
    var retryAction: () -> Void

    var body: some View {
        VStack {
            Text(message)
                .foregroundColor(.white)
                .padding()
            
            Button(action: {
                retryAction()
            }) {
                Text("Retry")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
        }
        .background(Color.black.opacity(0.7))
        .cornerRadius(16)
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let movieModel = MovieModelImpl.shared
        let viewModel = ContentViewModel(movieModel: movieModel)
        ContentView(mViewModel: viewModel)
    }
}

