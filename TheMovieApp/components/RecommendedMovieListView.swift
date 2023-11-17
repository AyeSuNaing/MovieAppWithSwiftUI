//
//  RecommendedMovieListView.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import SwiftUI

struct RecommendedMovieListView: View {
    var mMovies : [MovieVO]?
    var label: String = ""
    var onTapFav: ((Int)->Void)?

    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text(label)
                    .font(.system(size:TEXT_REGULAR_2X))
                    .fontWeight(.bold)
                    .padding(.top, MARGIN_MEDIUM_2)
                Spacer()
            }.padding([.leading,.trailing], MARGIN_CARD_MEDIUM_2)
        
            HorizontalMovieListItemView(mMovieList: mMovies){ value in 
                guard let onTapFav = self.onTapFav else {
                    return
                }
                onTapFav(value )
            }
        }
    }
}

#Preview {
    RecommendedMovieListView()
}
