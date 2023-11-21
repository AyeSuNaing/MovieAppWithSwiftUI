//
//  TheMovieAppApp.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import SwiftUI

@main
struct TheMovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            let movieModel = MovieModelImpl.shared
            let viewModel = ContentViewModel(movieModel: movieModel)
            ContentView(mViewModel: viewModel)
        }
    }
}
